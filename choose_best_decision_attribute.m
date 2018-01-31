% This function will return the index of the best attribute according
% information gain. To calculate the information gain, we need a helper
% function called calculate_entropy.
function best_attribute = choose_best_decision_attribute(examples, attributes,binary_targets)