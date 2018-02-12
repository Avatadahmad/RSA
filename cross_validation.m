function [evaluation_results,average_confusion_matrix,average_classification_rate] = cross_validation(data_type)

 if string(data_type) ==string('clean')
     load('Data/cleandata_students.mat');
 elseif  string(data_type)==string('noisy')
     load('Data/noisydata_students.mat');
 elseif  string(data_type)==string('processed_noisy')
     load('Data/noisydata_students.mat');
     [x,y] = filter_duplicates(x,y);
 else    
     disp('Error! Usage: cross_validation(data_type)');
     return;
 end
   
[~, total_feature_count] = size(x);
attributes = ones(1,total_feature_count);

% average confusion matrix
average_confusion_matrix = zeros(6,6);

% average classification_rate of the whole model
average_classification_rate = 0;

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
    classification_rate = calculate_model_classification_rate(confusion_matrix);
    average_classification_rate = average_classification_rate + classification_rate;
    average_confusion_matrix = average_confusion_matrix + confusion_matrix;
end
evaluation_results = evaluation_results / 10;
% Get the average value of the classification results
evaluation_results(7,:) = mean(evaluation_results);
average_classification_rate = average_classification_rate/10;
average_confusion_matrix = average_confusion_matrix/10;
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


% This function is used to calcuate the model's classification rate based
% on the  confusion matrix we get
function classification_rate = calculate_model_classification_rate(confusion_matrix)
        [row,~] = size(confusion_matrix);
        total = sum(sum(confusion_matrix));
        correct_result = 0;
        for x = 1:row
           correct_result = correct_result + confusion_matrix(x,x);
        end
        classification_rate = correct_result/total;
end
