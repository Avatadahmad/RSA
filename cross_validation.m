function [evaluation_results,average_confusion_matrix,average_classification_rate] = cross_validation(x,y)
   
% load('Data/noisydata_students.mat');   
load('Data/cleandata_students.mat'); 

[~, total_feature_count] = size(x);
attributes = ones(1,total_feature_count);

% average confusion matrix
average_confusion_matrix = zeros(6,6);

% 10-fold cross validation starting
evaluation_results = zeros(6,4);
for fold_number=1:10
    % create 6 trees for each fold
    tree=struct('op',0,'class',0,'kids',{0});
    tree(6) = tree(1);
    % prepare training data and test data for the current fold
    [training_features,training_binary_targets,test_features,test_targets] = get_cross_validation_data(fold_number,x,y);
    for i=1:6
        tree(i) = decision_tree_learning(training_features, attributes ,training_binary_targets(:,i));
    end
    % now we have 6 trees, evaluate here
    predictions = test_trees(tree, test_features);
    prediction_actual_record = [predictions test_targets];
    confusion_matrix = calculate_confusion_matrix(prediction_actual_record,6);
    evaluation_results = evaluation_results + calculate_evaluation_results(confusion_matrix);
    average_confusion_matrix = average_confusion_matrix + confusion_matrix;
end
evaluation_results = evaluation_results / 10;
average_classification_rate = get_classification_rate(average_confusion_matrix);
end


% subfunction
function [training_features,training_binary_targets,test_features,test_targets] = get_cross_validation_data(fold_number,x,y)
% generate binary targets for 6 emotions, stored in 1004-by-6
binary_targets = [];
for i = 1:6
    binary_targets = [binary_targets (y == i)];
end

[total_sample_count, ~] = size(x);
fold_size = floor(total_sample_count/10);
if fold_number<10
    test_data_range = [fold_size*(fold_number-1)+1,fold_size*fold_number];
else
    test_data_range = [fold_size*(fold_number-1)+1,total_sample_count];
end

test_features = x(test_data_range(1):test_data_range(2),:);
test_targets = y(test_data_range(1):test_data_range(2),:);
training_features = [x(1:test_data_range(1)-1,:);x(test_data_range(2)+1:total_sample_count,:)];
training_binary_targets = [binary_targets(1:test_data_range(1)-1,:);binary_targets(test_data_range(2)+1:total_sample_count,:)];
end

function average_classification_rate = get_classification_rate(average_confusion_matrix)
        [row,~] = size(average_confusion_matrix);
        total = sum(sum(average_confusion_matrix));
        correct_result = 0;
        for x = 1:row
           correct_result = correct_result + average_confusion_matrix(x,x);
        end
        average_classification_rate = correct_result/total;
end