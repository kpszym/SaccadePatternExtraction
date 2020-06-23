function [trsp_sequence] = convertPathToSequence(trsp_path)
% FUNCTION: Identifies the set of edges in the saccade network that are a 
%           part of
% INPUT: 
%           trsp_path - Vector containing the node order in the longest
%           path of the saccade network identified.
% 
% OUTPUT:   
%           trsp_sequence - Sx2 matrix containing the saccade data
%           representing the TRSP identified via network analysis.
%       
% Written by Karol Szymula, Complex System Group, 2019
trsp_sequence = zeros(length(trsp_path)-1, 2);
for t = 1:length(trsp_path)-1
    trsp_sequence(t,:) = [trsp_path(t) trsp_path(t+1)];
end

