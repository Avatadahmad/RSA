function F1_matrix = calculate_F1(recall_and_precision)

F1_matrix = zeros(6,1);

for i = 1:6
    recall_rate = recall_and_precision(i,1);
    precision_rate = recall_and_precision(i,2);
    
    F1 = (2* precision_rate* recall_rate)/(precision_rate+recall_rate);
    
    F1_matrix(i,1) = F1;
end
    

end

