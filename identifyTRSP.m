function [trsp_sequence] = identifyTRSP(saccade_matrix)
% FUNCTION: Identifies the set of edges in the saccade network that are a 
%           part of the longest path (set of edges with greatest sum of
%           weights).
% INPUT: 
%           saccade_matrix - 9x9 adjacency matrix summarizing the trial
%           saccade sequence. Each i,j element denotes the number of
%           saccades that occured between target i and target j. 
% 
% OUTPUT:   
%           trsp_sequence - Sx2 matrix containing the saccade data
%           representing the TRSP identified via network analysis. 
%       
% Written by Karol Szymula, Complex System Group, 2019
net_graph = digraph(saccade_matrix);
[e,~] = dfsearch(net_graph, 2, 'edgetodiscovered', 'Restart', true);
max_path_weight = zeros(1,size(e,1));
max_paths = cell(1,size(e,1));
for c = 1:size(e,1)
    paths = pathbetweennodes(saccade_matrix,e(c,2),e(c,1));
    path_weight = zeros(1,size(paths,1));
    for p = 1:size(paths,1)
        path_taken = paths{p};
        path_weight(p) = 0;
        for m = 2:length(path_taken)
            path_weight(p) = path_weight(p) + net_graph.Edges.Weight(findedge(net_graph, path_taken(m-1), path_taken(m)));
        end
    end
    [max_path_weight(c), max_path_idx] = max(path_weight);
    max_paths{c} = [paths{max_path_idx}, e(c,2)];
end

max_path = max_paths{(max_path_weight == max(max_path_weight))};

trsp_sequence = path2seq(max_path);
end

