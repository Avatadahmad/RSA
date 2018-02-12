% This function is used to out the result of the 6 decision tress.
% The final result is depended on all 6 trees.
% The input is a array T contains 6 decision trees, 
% and a features example x2 need to be tested
function predictions = testTrees2(T, x2)
    [example_size,~] = size(x2);
    predictions = zeros(1,example_size);
    priority = get_priority(T);
    for x = 1:example_size
        
        results = zeros(1,6);
       
        for i = 1:6
            results(i) = classify_by_tree(x2(x,:),T(i));
        end

        % Get index of positive results
        positives = find(results==1);
         % If all result are negative, return a random number   
        if(isempty(positives))
            predictions(x) = round(rand(1,1)*5)+1;
        else
             % otherwise, pick one number from the positives 
            current_priority = priority(positives);
            result_index = find(current_priority==max(current_priority));
            predictions(x) = positives(result_index);
        end
    end   
    predictions = transpose(predictions);
end

function priority = get_priority(T)
  tree_number = length(T);
  priority = zeros(1,tree_number);
  for i = 1:tree_number
      priority(i) = get_singtree_evaluate_result(T(i),i);
  end    
end

function  result = get_singtree_evaluate_result(tree,target_label)
    load('Data/cleandata_students.mat');
    binary_labels = (y == target_label);
    predict_labels = zeros(size(binary_labels));
    for i = 1:length(binary_labels)
        predict_labels(i) = classify_by_tree(x(i,:),tree);
    end
    
    %add 1 to original binary_labels and predict_labels so that we can
    %reuse the calculate confusion function;
    binary_labels    = binary_labels+1;
    predict_labels   = predict_labels+1;
    prediction_actual_record = [predict_labels binary_labels];
    confusion_matrix = calculate_confusion_matrix(prediction_actual_record,2);
    recall = confusion_matrix(1,1)/(confusion_matrix(1,1)+confusion_matrix(1,2));
    precision = confusion_matrix(1,1)/(confusion_matrix(1,1)+confusion_matrix(2,1));
    f1_measure = 2*precision*recall/(precision+recall);
    classification_rate = (confusion_matrix(1,1)+confusion_matrix(2,2))/sum(sum(confusion_matrix));
    result = 0.5*classification_rate + 0.5*f1_measure;
end


