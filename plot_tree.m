function plot_tree(tree)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fig_tree = figure();
clf(fig_tree)
global tree_nodes;
nodes_to_plot = traverse_tree(tree);
nodes_for_treeplot = nodes_to_plot(1,:);
[x,y] = treelayout(nodes_for_treeplot);
leaves = find( y == min(y) );
num_layers = 1/min(y)-1;
chains = zeros(num_layers, length(leaves));
for l=1:length(leaves)
    index = leaves(l);
    chain = [];
    chain(1) = index;
    parent_index = nodes_for_treeplot(index);
    j = 2;
    while (parent_index ~= 0)
        chain(j) = parent_index;
        parent_index = nodes_for_treeplot(parent_index);
        j = j+1;
    end
    chains(:,l) = padarray(flip(chain), [0, num_layers-length(chain)], 'post');
end

y_new = zeros(size(y));
for i=1:length(nodes_for_treeplot)
    [r,c] = find(chains==i, 1);
    y_new(i) = max(y) - (r-1)*1/(num_layers+1);
end


for c=1:size(chains, 2)
    line_x = x(chains(chains(:,c)>0, c));
    line_y = y_new(chains(chains(:,c)>0, c));
    line(line_x, line_y,'linewidth',1);
end
hold on
leaf_nodes_0 = find(nodes_to_plot(3,:)==0); 
leaf_nodes_1 = find(nodes_to_plot(3,:)==1); 
internal_nodes = find(~isnan(nodes_to_plot(2,:))); 
% plot(x(internal_nodes), y_new(internal_nodes), 'ws','MarkerFaceColor','w');
% hold on
positive_nodes = plot(x(leaf_nodes_0), y_new(leaf_nodes_0), 'o','color',[0.961, 0.263, 0.212],'MarkerFaceColor',[0.961, 0.263, 0.212]);
hold on
negative_nodes = plot(x(leaf_nodes_1), y_new(leaf_nodes_1), 'o','color',[0.000, 0.588, 0.529],'MarkerFaceColor',[0.000, 0.588, 0.529]);
legend([positive_nodes,negative_nodes],'positive', 'negative', 'location','SouthEast');

for t=1:length(nodes_for_treeplot)
    if isempty(tree_nodes{t}{2}.class)
        node_text = num2str(tree_nodes{t}{2}.op(1));
        text(x(t), y_new(t), node_text,'FontWeight','bold', 'fontsize',12);  
        % text(x(t), y_new(t), node_text,'FontWeight','bold', 'fontsize',12,'fontname','Roboto');  
    end
end
% xlim([0 1]);
% ylim([0 1]);
axis off
end

