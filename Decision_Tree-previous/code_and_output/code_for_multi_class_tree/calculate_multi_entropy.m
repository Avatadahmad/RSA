% This function is used to calculate the entropy of a dataset, it is used for
% multiple class classification trees.

function entropy = calculate_multi_entropy(labels)

      entropy = 0;
      
      label_count = length(labels);
      label_types = unique(labels);
      
      type_count = length(label_types);
      
      if (type_count > 1)
     
          for i = 1 : type_count
              positive_count = length(find(labels == label_types(i)));
              p_i = positive_count/label_count;
              entropy = entropy + -(p_i) * log2(p_i);  
          end
          
      end
end
      