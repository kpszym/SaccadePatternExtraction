function [trial_saccade_data] = constructExample_saccadeData(numb_saccades, numb_trials)
% FUNCTION: Creates a set of example data for a specified amount of trials
%           of a free-view scanning task. The task involves a 3x3 grid of 
%           equally sized & spaced green circular targets. Saccades (short
%           eye movements) can be performed between any of the two targets
%           on the grid. Grid targets are numbered as follows:
%
%                               (1)  (2)  (3)
%                               
%                               (4)  (5)  (6)
%
%                               (7)  (8)  (9)
%           
%           Saccade data is output as a matrix of size Sx2, where the
%           first column indicates the saccade starting target and the
%           second column indicates the ending target of the saccade. Each
%           row in the matrix is a new saccade in the trial, with a total
%           of S number of saccades. 
%           
% INPUT: 
%           numb_saccades - an integer indicating how many individual
%           saccades to include in a given trial
%
%           numb_trials - an integer indicating how many example trials to
%           create saccade data for. 
% 
% OUTPUT:   
%           trial_saccade_data - Sx2xT matrix containing the saccade data
%           for all example trails. S is equal to numb_saccades and T is 
%           equal to numb_trials. 
%       
% Written by Karol Szymula, Complex System Group, 2019


trial_saccade_data = zeros(numb_saccades,2,numb_trials);
for t = 1:numb_trials
    all_targets = 1:9; 
    for s = 1:numb_saccades
        
        % Pick saccade start
        if s == 1
            trial_saccade_data(s,1,t) = randsample(all_targets(:), 1);
        else
            trial_saccade_data(s,1,t) = trial_saccade_data(s-1,2,t);
        end
        open_targets = 1:9;
        open_targets(all_targets == trial_saccade_data(s,1,t)) = [];
        
        % Pick saccade end (cannnot be same as start)
        trial_saccade_data(s,2,t) = randsample(open_targets, 1);
    end
end

