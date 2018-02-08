function recall_and_precision = calculate_recall_and_precision(confusion_matrix)

%initialise the recall and precision rate table
recall_and_precision = zeros(6,2);

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
    
    recall_and_precision(i,1) =  recall_rate;
    recall_and_precision(i,2) = precision_rate;
end
    
    
end

