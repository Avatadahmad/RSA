function visualise(tree)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global tree_nodes;
nodes_to_plot = traverse_tree(tree);
[x,y] = treelayout(nodes_to_plot);
leaves = find( y == min(y) );
num_layers = 1/min(y)-1;
chains = zeros(num_layers, length(leaves));
for l=1:length(leaves)
    index = leaves(l);
    chain = [];
    chain(1) = index;
    parent_index = nodes_to_plot(index);
    j = 2;
    while (parent_index ~= 0)
        chain(j) = parent_index;
        parent_index = nodes_to_plot(parent_index);
        j = j+1;
    end
    chains(:,l) = padarray(flip(chain), [0, num_layers-length(chain)], 'post');
end
% clf()
figure(1)
y_new = zeros(size(y));
for i=1:length(nodes_to_plot)
    [r,c] = find(chains==i, 1);
    y_new(i) = max(y) - (r-1)*1/(num_layers+1);
end

plot(x, y_new, 'o');
hold on
for c=1:size(chains, 2)
    line_x = x(chains(chains(:,c)>0, c));
    line_y = y_new(chains(chains(:,c)>0, c));
    line(line_x, line_y);
end

for t=1:length(nodes_to_plot)
    if isempty(tree_nodes{t}{2}.op)
        node_text = num2str(tree_nodes{t}{2}.class);
    else
        node_text = "AU\_"+ num2str(tree_nodes{t}{2}.op(1));
    end
    text(x(t)+0.008, y_new(t), node_text); % 
end
xlim([0 1]);
ylim([0 1]);
end

