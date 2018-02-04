% This function will return the index of the best attribute according
% information gain. To calculate the information gain, we need a helper
% function called calculate_entropy.
function best_attribute = choose_best_decision_attribute(examples, attributes,binary_targets)

entropySet = calculate_entropy(binary_targets);

    
% if attribute used, skip calculation of information gain
for i=1:length(attributes)
    if attributes(i) == 0
        info_gain(i)= NaN;
    else
        binary_column = examples(:,i);
  
    % calculate remainder of binary value true and false to get informatoin gain
        remainder = calculate_remainder(binary_column, binary_targets);
        info_gain(i) = entropySet - remainder;
    end
end

current_best = 1;
for j=1:length(info_gain)
    if isnan(info_gain(j))==true
        continue;
    else
        if info_gain(j) > info_gain(current_best)
            current_best = j;
        end
    end
end

best_attribute = current_best;
return;