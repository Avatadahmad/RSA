clear
load('Data/cleandata_students.mat')

% generate binary targets for 6 emotions, stored in 1004-by-6
binary_targets = [];
for i = 1:6
	binary_targets = [binary_targets (y == i)];
end
[total_sample_count, total_feature_count] = size(x);
attributes = ones(1,total_feature_count);

% partition the data into 10 folds
global feature_blocks;
global binary_targets_blocks;
feature_blocks = cell(10,1);
binary_targets_blocks = cell(10,1);
j = 0;
for i=1:9
	feature_blocks{i} = x(j+1:j+floor(total_sample_count/10),:);
	binary_targets_blocks{i} = binary_targets(j+1:j+floor(total_sample_count/10),:);
	j=j+floor(total_sample_count/10);
end
feature_blocks{10}=x(j+1:total_sample_count,:);
binary_targets_blocks{10}=binary_targets(j+1:total_sample_count,:);

% trees = {struct};
% 10-fold cross validation starting
for fold_number=1:10  
	% create 6 trees for each fold
	tree=struct('op',0,'class',0,'kids',{0});
	tree(6)=tree(1);
	% prepare training data and test data for the current fold
	[features_to_train,binary_targets_to_train,features_to_test,binary_targets_to_test] = get_cross_validation_data(fold_number);
	for i=1:6
		tree(i) = decision_tree_learning(features_to_train, attributes ,binary_targets_to_train(:,i));
	end
	% now we have 6 trees, evaluate here

end

function [training_features,training_targets,test_features,test_targets] = get_cross_validation_data(fold_number)
	global feature_blocks;
	global binary_targets_blocks;

	% get trainging data
	training_features = feature_blocks;
	training_features(fold_number)=[];
	training_features = cell2mat(training_features);

	training_targets = binary_targets_blocks;
	training_targets(fold_number)=[];
	training_targets = cell2mat(training_targets);

	% get test data
	test_features = feature_blocks{fold_number};
	test_targets = binary_targets_blocks{fold_number};
end