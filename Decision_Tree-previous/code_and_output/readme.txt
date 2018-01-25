How to run the test code:
1. load('emotions_data.mat');
2. [tree_confusion_matrix, tree_eval_matrix, cross_validation_matrix] = tree_cross_validation(x,y);


How to produce a binary decision tree for a specific label:
1. load('emotions_data.mat');
2. tree = decision_tree_learning(x,y,target_label)
3. DrawDecisionTree(tree,target_label)


What is included in the 'output.mat' file 
	1. average_confusion_matrix: sum of confusion matrix after 10 cross validation.
	2. average_eval_matrix: recall, precision, F1 measure calculated from average_confusion_matrix and the last row represents their average value.
	3. cross_validation_confusion_matrixs: 10 confusion matrixs from each croos validation.
	4. tree1,tree2,tree3,tree4,tree5,tree6: 6 binary decision trees training on all sample data.


What is includeed in the 'Code_for_multi_class_tree' folder:
This folder contains a 'calculate_multi_entropy.m' file which will be used to produce multi-class decision tree, a 'tree-mult-class.fig' image which shows the structure of the multi-class tree, and a 'tree-mult-class,mat' file which store the result multi-class tree.