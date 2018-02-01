% This function will return the index of the best attribute according
% information gain. To calculate the information gain, we need a helper
% function called calculate_entropy.
function best_attribute = choose_best_decision_attribute(examples, attributes,binary_targets)

entropySet = calculate_entropy(binary_targets);

% if attribute used, skip calculation of information gain
for i=1:length(attributes)
    if attributes(i) == 0
        continue;
    end
    
    binary_column = examples(i,:);
% calculate entropy of binary value true and false to get informatoin gain
    entropy = calculate_entropy(binary_column);
    info_gain(i) = entropySet - entropy;
    
    disp(length(attributes));
end

current_best = 0;


for j=1:length(info_gain)
    if info_gain(j) > current_best
        current_best = j;
    end
end

best_attribute = current_best;