% outputs the row numbers with same patterns, those in same row mean same
% pattern

%function new_filter_res(x, y)

%     clc;
%     clear all;
%     load('noisydata_students.mat');

    [ROW, COL] = size(x);
    x_change = x;
    row_counter = 0;

    for i = 1:ROW

        if isnan(x_change(i, 1))
            filtered_output(i, 1) = i;
        end
        
            col_counter = 1;
            row_counter = row_counter + 1;

            for index_change1 = 1:COL
                out_x_change(1, index_change1) = x_change(i, index_change1); % stores current row in var
                x_change(i, index_change1) = NaN; % deletes current row off of data
            end

            % outputs row number that was searched to filtered_output array
            filtered_output(row_counter, col_counter) = i;

            for j = i+1:ROW
                if ~isnan(x_change(j, 1))
                    %fprintf("taking in row %i \n", j);
                    comparison_counter = 0;
                    % compares row stored in out_x_change to all other rows
                    for index_change3 = 1:COL
                        if out_x_change(1, index_change3) == x_change(j, index_change3)
                            comparison_counter = comparison_counter + 1;
                        end
                    end

                    if comparison_counter == COL
                       % if found a match, move index_change to next column in same row
                       col_counter = col_counter + 1; 
                       filtered_output(row_counter, col_counter) = j;

                       for index_change2 = 1:COL
                           x_change(j, index_change2) = NaN; % deletes same row off of data
                       end
                    end
                end
            end

    end
