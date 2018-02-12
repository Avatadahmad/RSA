% % gets average data for noisy, preprocessed, and clean datasets
% 
% clear all;
% num_trials = 100;
% 
% for datasets = 1:3
%     trials = 0;
%     i=0;
%     
%     if datasets == 1
%         load('Data/noisydata_students.mat'); 
%     
%     for trials = 0:num_trials
%        [classification_table, confusion, classification_avg] = cross_validation(x, y);
%        
%        for i = 1:6
%             %f1
%             noisy(i+(trials*6), 1) = classification_table(i, 3);
%             %classification rate
%             noisy(i+(trials*6), 2) = classification_table(i, 4);
%             %avg classification rate
%             noisy(i+(trials*6), 3) = classification_avg;
%        end
%     end
%     
%     elseif datasets == 2
%         %load pre-procsesed data
%         load('Data/noisydata_students.mat');
%         [x,y] = filter_duplicates(x,y);
%         
%         for trials = 0:num_trials
%         [classification_table, confusion, classification_avg] = cross_validation(x, y);  
%        
%         for i = 1:6
%             %f1
%             preprocessed(i+(trials*6), 1) = classification_table(i, 3);
%             %classification rate
%             preprocessed(i+(trials*6), 2) = classification_table(i, 4);
%             %avg classification rate
%             preprocessed(i+(trials*6), 3) = classification_avg;
%         end
%     end
% 
%     else
%         load('Data/cleandata_students.mat');        
%         for trials = 0:num_trials
%         [classification_table, confusion, classification_avg] = cross_validation(x, y);  
%             for i = 1:6
%                  %f1
%                  clean(i+(trials*6), 1) = classification_table(i, 3);
%                 %classification rate
%                  clean(i+(trials*6), 2) = classification_table(i, 4);
%                  %avg classification rate
%                  clean(i+(trials*6), 3) = classification_avg;
%             end
%         
%         end
%         
%     end
% 
% end
%      
% sum_noisy_f1 = [0;0;0;0;0;0];
% sum_preprocessed_f1 = [0;0;0;0;0;0];
% sum_clean_f1 = [0;0;0;0;0;0];
% 
% 
% sum_noisy_classification_rates = [0;0;0;0;0;0];
% sum_preprocessed_classification_rates = [0;0;0;0;0;0];
% sum_clean_classification_rates = [0;0;0;0;0;0];
% 
% 
% for i = 1:6
%    for trials = 0:num_trials
%        sum_noisy_f1(i,1) = sum_noisy_f1(i,1) + noisy(i+(trials*6),1);
%        sum_preprocessed_f1(i,1) = sum_preprocessed_f1(i,1) + preprocessed(i+(trials*6),1);
%        sum_clean_f1(i,1) = sum_clean_f1(i,1) + clean(i+(trials*6),1);
%        
%        sum_noisy_classification_rates(i,1) = sum_noisy_classification_rates(i,1) + noisy(i+(trials*6),2);
%        sum_preprocessed_classification_rates(i,1) = sum_preprocessed_classification_rates(i,1) + preprocessed(i+(trials*6),2);
%        sum_clean_classification_rates(i,1) = sum_clean_classification_rates(i,1) + clean(i+(trials*6),2);      
%        
%    end
%    
%    
%    averaged_noisy(i, 1) = sum_noisy_f1(i,1)/(num_trials+1);
%    averaged_preprocessed(i, 1) = sum_preprocessed_f1(i,1)/(num_trials+1);
%    averaged_clean(i, 1) = sum_clean_f1(i,1)/(num_trials+1);
%    
%    averaged_noisy(i, 2) = sum_noisy_classification_rates(i,1)/(num_trials+1);
%    averaged_preprocessed(i, 2) = sum_preprocessed_classification_rates(i,1)/(num_trials+1);
%    averaged_clean(i, 2) = sum_clean_classification_rates(i,1)/(num_trials+1);
%    
%    averaged_noisy(i,3) = (sum(noisy(:,3))) / ((num_trials+1)*6);
%    averaged_preprocessed(i,3) = (sum(clean(:,3))) / ((num_trials+1)*6);
%    averaged_clean(i,3) = (sum(preprocessed(:,3))) / ((num_trials+1)*6);
%    
% end

function [evaluation_results,average_confusion_matrix,average_classification_rate] = get_average(iterations_number,data_type)
 evaluation_results = zeros(7,4);
 average_confusion_matrix = zeros(6,6);
 average_classification_rate = 0;
 for i = 1:iterations_number
      [temp1,temp2,temp3] = cross_validation(data_type);
      evaluation_results = evaluation_results + temp1;
      average_confusion_matrix = average_confusion_matrix + temp2;
      average_classification_rate = average_classification_rate + temp3;
 end
evaluation_results = evaluation_results/iterations_number;
average_confusion_matrix = average_confusion_matrix/iterations_number;
average_classification_rate = average_classification_rate/iterations_number;
 
 


