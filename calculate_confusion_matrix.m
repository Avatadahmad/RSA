function confusion_matrix = calculate_confusion_matrix(prediction_actual_record)
prediction_data = prediction_actual_record(:,1);
actual_data = prediction_actual_record(:,2);

confusion_matrix = zeros(6,6);

for i=1:length(prediction_data)
    confusion_matrix(actual_data(i),prediction_data(i)) = confusion_matrix(actual_data(i),prediction_data(i))+1;
end

end

