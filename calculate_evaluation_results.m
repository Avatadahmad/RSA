function evaluation_results = calculate_evaluation_results(confusion_matrix)

%initialise a matrix to record recall_rate, precision_rate, F1 and
%classification_rate
evaluation_results = zeros(6,4);

for i=1:6
    %the diagonal value will be TP for each class
    TP = confusion_matrix(i,i);
    
    %calculate the sum of each row and store in a column matrix
    sum_of_rows = sum(confusion_matrix,2);
    %FN will be the difference between sum and TP
    FN = sum_of_rows(i,1) - TP;
    
    %calcluate the sum of each column and store in a row matrix
    sum_of_columns = sum(confusion_matrix,1);
    %FP will be the difference between sum and TP
    FP = sum_of_columns(1,i)-TP;
    
    recall_rate = TP/(TP+FN);
    precision_rate = TP/(TP+FP);
    
    F1 = (2* precision_rate* recall_rate)/(precision_rate+recall_rate);
    
    evaluation_results(i,1) =  recall_rate;
    evaluation_results(i,2) = precision_rate;
    evaluation_results(i,3) = F1;
    
end
    
    
end

