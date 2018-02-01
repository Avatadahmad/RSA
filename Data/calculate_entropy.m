%This function is used to calculate the entropy of a dataset, 
function entropy = calculate_entropy(binary_labels)

    positives = 0;
    negatives = 0;

    label_size = length(binary_labels);

    positives = length(find(binary_labels==1));
    negatives = label_size - positives;

    positive_ratio = positives/label_size;
    negative_raito = negatives/label_size;

    if (positives == 0 || negatives == 0)
        entropy = 0;
    else
        entropy = -positive_ratio * log2(positive_ratio) - (negative_raito)*log2(negative_raito);
    end
end
