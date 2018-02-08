% This function is used to out the result of the 6 decision tress.
% The final result is depended on all 6 trees.
% The input is a array T contains 6 decision trees, 
% and a features example x2 need to be tested
function predictions = test_trees(T, x2)
    results = zeros(1,6);    
    for i = 1:6
        results(i) = classify_by_tree(x2,T(i));
    end
    
    % Get index of positive results
    positives = find(results==1);
     % If all result are negative, return a random number   
    if(isempty(positives) == 0)
        predictions = round(rand(1,1)*5)+1;
    else
         % otherwise, pick one number from the positives  
        result_index = round(rand(1,1)*(length(positives)-1))+1;
        predictions = positives(result_index);
    end    
end