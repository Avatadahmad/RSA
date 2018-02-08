# Usage

```matlab
>> tree=train_tree(1); % the target label you want to train
>> visualise(tree)
```

# Assignment

## First Iteration

### Angie
- [x] Implement function `Calculate_remainder` 
- [x] Implement function `calculate_entropy` 
- [x] Debug previous issues

### Richard 
- [x] Implement function `choose_best_decision_attribute`

### Dongming

- [x] Implement function `divide_by_best_attribute`
- [x] Tree visualisation
- [x] Merge the redundant branches (not affecting the classification accuracy)

### Even
- [x] Implement function `decision_tree_learning` 
- [x] Implement function `train_tree`   
- [x] Implement function `classify_by_tree`

## Second Iteration

### Angie
- [ ] Write code to generate F1-measure，Confunsion_matrix,etc

### Dongming
- [ ] Write code to do cross-validation 
	 (output: a matrix with two rows; one is actural result and other one is predicted result)
	 (divide data into train_set, test_set, called test_trees to give result)

### Richard
- [ ] Do data pre-processing

### Even
- [x] Implement function `test_trees`



