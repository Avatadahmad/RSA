% This function is the key function to produce a binary decision tree
% according to the sample data and their labels. It will product a decision
% tree which can classify the target label as users input.
% The attribute will be a 1*45 vector with all 1 values, a attribute will be set to 0 if it is used before. 
function tree = decision_tree_learning(examples, attributes ,binary_targets)

    % if all examples have the same value of binary_targets, then return a leaf node with this value
    if(length(unique(binary_targets))==1)
        tree.op=[];
        tree.kids={};
        tree.class=unique(binary_targets);
        return;
    end
    
    % If all attributes has been used, return a leaf node with the most common label as the class.
    if(all(attributes==0))
        tree.op = [];
        tree.kids = {};
        tree.class = mode(binary_targets);
        return;
    end
    % return the index of the best attribute
    best_attribute = choose_best_decision_attribute(examples, attributes,binary_targets);
    % divide the examples and binary_targets into two subsets according to the best attribute
    display(best_attribute);
    [left_examples, left_targets, right_examples, right_targets] = divide_by_best_attribute(best_attribute, examples,binary_targets);
    % set the best attribute to 0 so that we would not reuse it later.
    attributes(best_attribute)=0;
    % If the left subset is empty, then return a empty leaf node.
    if (isempty(left_examples))
        left_tree.op = [];
        left_tree.kids = {};
        left_tree.class = mode(binary_targets);
    else
        left_tree = decision_tree_learning(left_examples,attributes,left_targets);
        if ~isempty(left_tree.kids)
            if and(~isempty(left_tree.kids{1}.class), ~isempty(left_tree.kids{2}.class))    
                if left_tree.kids{1}.class==left_tree.kids{2}.class
                    left_tree.class = left_tree.kids{1}.class;
                    left_tree.kids = {};
                    left_tree.op = [];
                end
            end
        end
    end
    
    % If the right subset is empty, then return a empty right node.
    if (isempty(right_examples))
        right_tree.op = [];
        right_tree.kids = {};
        right_tree.class = mode(binary_targets);
    else
        right_tree = decision_tree_learning(right_examples,attributes,right_targets);
        if ~isempty(right_tree.kids)
            if and(~isempty(right_tree.kids{1}.class), ~isempty(right_tree.kids{2}.class))    
                if right_tree.kids{1}.class==right_tree.kids{2}.class
                    right_tree.class = right_tree.kids{1}.class;
                    right_tree.kids = {};
                    right_tree.op = [];
                end
            end
        end
    end
    
    tree.op = best_attribute;
    tree.kids = {left_tree, right_tree};
    tree.class = [];
end

    
