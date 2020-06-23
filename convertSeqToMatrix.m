function [saccade_matrix] = convertSeqToMatrix(trial_seq)
% FUNCTION: Converts a example trial saccade sequence output from
%           constructExample_saccadeData.m into a saccade network, which is
%           represented by an adjacency matrix. Each node in the network is 
%           a target in the task grid space 
%           (see constructExample_saccadeData.m for task explanation) and
%           an edge between the two nodes exist if a saccade was observed
%           between the two target nodes. The weight of the edge is the
%           number of times that saccade was observed. 
% INPUT: 
%           trial_seq - Sx2 matrix containing the saccade data
%           for the example trail. S is equal to numb_saccades. The first 
%           column contains the starting node and the second contains the
%           ending node. Each row is an individual saccade. 
% 
% OUTPUT:   
%           saccade_matrix - 9x9 adjacency matrix summarizing the trial
%           saccade sequence. Each i,j element denotes the number of
%           saccades that occured between target i and target j. 
%       
% Written by Karol Szymula, Complex System Group, 2019
saccade_matrix = zeros(9,9);

% Convert saccade sequence into saccade network.
for m = 1:size(trial_seq,1)
    saccade_matrix(trial_seq(m,1), trial_seq(m,2)) = saccade_matrix(trial_seq(m,1), trial_seq(m,2)) + 1;
end

saccade_matrix(eye(size(saccade_matrix)) == 1) = 0;
end
