% This is the function to train a decision tree. The only input is a number
% which represents the type of expression you would like to learn.
function tree = train_tree(target_label)
    load('./data/cleandata_students.mat');
    binary_targets = (y == target_label);
    [~, total_feature_count] = size(x);
    attributes = ones(1,total_feature_count);
    tree = decision_tree_learning(x, attributes ,binary_targets);
return;