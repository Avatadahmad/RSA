function test(x,y,index)
    [row,~] = size(x);
    array = x(index,:);
    for i = 1 : row
        result = x(i,:)==array;
        if(all(result(:) == 1))
            disp(string('index is:')+i+string(' y is:')+y(i,1));
        end    
    end    
end