function remainder = calculate_remainder(binary_column, binary_labels)
         
negatives = find(binary_column == 0);
positives = find(binary_column == 1);


n_0 = 0;
p_0 = 0;
n_1 = 0;
p_1 = 0;

binary_positive=[];
binary_negative=[];

for i=1:length(negatives)
    binary_negative(i)=binary_labels(negatives(i));
    if binary_labels(negatives(i))==0
        n_0 = n_0 + 1;
    else
        p_0 = p_0 + 1;
    end
end

for j=1:length(positives)
    binary_positive(j)=binary_labels(positives(j));
    if binary_labels(positives(j))==0
        n_1 = n_1 + 1;
    else
        p_1 = p_1 + 1;
    end
end

negative_entropy = calculate_entropy(binary_negative);
positive_entropy = calculate_entropy(binary_positive);

label_size = length(binary_labels);

remainder = ((p_0+n_0)*negative_entropy+(p_1+n_1)*positive_entropy)/label_size;
end
