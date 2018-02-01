% This function wil go through the tree according to the attribute of node
% and stop until it reach the leaf node and return the node class as result.
function result = classify_by_tree(attributes, tree)
        
        if ~isempty(tree.class)
            result = tree.class(1,1);
            return
        end
        
        attribute_id = tree.op(1,1);        
        left = tree.kids{1};
        right = tree.kids{2};
              
        value = attributes(attribute_id);
        
        if (value == 0)
           result = classify_by_tree(attributes, left);
        else
           result = classify_by_tree(attributes, right);
        end       
end

