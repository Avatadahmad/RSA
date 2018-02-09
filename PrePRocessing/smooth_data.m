% takes binary labels

%function smooth_data(x, y, filtered_output)

    rng('shuffle');
    [ROW, COL] = size(filtered_output); 

    for i = 1:ROW
        tie = true;
        j = 1;
        counter_array = [0,0,0,0,0,0];

        if filtered_output(i, 2) ~= 0 % if no duplicates, skip
            while j <= COL && filtered_output(i, j) ~= 0
                % update counter array with counts of y values for current
                % row of duplicates
                counter_array(y(filtered_output(i, j))) = counter_array(y(filtered_output(i, j))) + 1;
                j = j + 1;
            end
            
            cnt = 0;
            % totals y values of the duplicates into counter_array and
            % determines if a tie is present
            
            sec_array_counter = 1;
            arr = 0;
            %suspicious
            for index = 1:6
                if counter_array(index) ~= 0
                    arr(sec_array_counter) = counter_array(index);
                    sec_array_counter = sec_array_counter + 1;
                end
            end
            
                if length(arr) == 1
                    tie = false;
                else
                    loop_index = 2;
                    while loop_index <= length(arr)
                        if arr(loop_index) ~= arr(loop_index-1)
                            tie = false;
                        end
                        loop_index = loop_index + 1;
                    end
                end
            
            
        % if no tie, select majority value
        if tie == false
            current_index_winner = 1;
            current_highest_vote = counter_array(1);
            for index = 1:6
                if counter_array(index) > current_highest_vote
                    current_index_winner = index;
                    current_highest_vote = counter_array(index);
                end
            end
            adjusted_y = current_index_winner;
        end
        if tie == true
            % if tie, randomize value based on prersent y values of that
            % pattern
            
            % moves indexes of tied values into a second array
            tie_array_counter = 1;

            for index = 1:6
                if counter_array(index) ~= 0
                    tie_array(tie_array_counter) = index;
                    tie_array_counter = tie_array_counter + 1;
                else
                    continue;
                end
            end
        
            % picks a random index from tie array and return its value to
            % adjusted_y
            adjusted_y = tie_array(randi(length(tie_array)));
            
        end
        
            % delete all repeated rows except first occurrance, 
            % replace y of first row with this pattern with adjusted_y
            j = 2;
            while j <= COL && filtered_output(i, j) ~= 0
                for index = 1:COL
                    x(filtered_output(i,j), index) = NaN;
                end
                    y(filtered_output(i,j)) = NaN; 
                    
                    %bug below
                    y(i) = adjusted_y;
                    j = j + 1;
            end
        end
    end
    
    %end