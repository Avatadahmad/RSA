% divide the examples and binary_targets into two subsets according to the best attribute 
function  [left_examples, left_targets, right_examples, right_targets] = divide_by_best_attribute(best_attribute, examples, binary_targets)
	best_attribute_column = examples(:,best_attribute);
	left_examples = examples(find(best_attribute_column==0),:);
	left_targets = binary_targets(find(best_attribute_column==0));
	right_examples = examples(find(best_attribute_column==1),:);
	right_targets = binary_targets(find(best_attribute_column==1));
end