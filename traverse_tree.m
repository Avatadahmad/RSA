function  nodes_to_plot = traverse_tree(tree)
%UNTITLED4 Summary of this function goes here
global tree_nodes;
tree_nodes = {{0,tree}};
traverse_tree_sub(tree,1);
node_number = length(tree_nodes)
nodes_to_plot = zeros(3,node_number);
for i = 1:node_number
	nodes_to_plot(1,i)=tree_nodes{i}{1};
	if isempty(tree_nodes{i}{2}.op)
		nodes_to_plot(2,i)=nan;
	else
		nodes_to_plot(2,i)=tree_nodes{i}{2}.op;
	end

	if isempty(tree_nodes{i}{2}.class)
		nodes_to_plot(3,i)=nan;
	else
		nodes_to_plot(3,i)=tree_nodes{i}{2}.class;
	end

end
end

function  traverse_tree_sub(tree,parent)
global tree_nodes;
if isempty(tree.class)
	tree_nodes{end+1} = {parent,tree.kids{1}}; 
	tree_nodes{end+1} = {parent,tree.kids{2}};
	tmplen = length(tree_nodes);
	traverse_tree_sub(tree.kids{1},tmplen-1);
	traverse_tree_sub(tree.kids{2},tmplen);
end
end