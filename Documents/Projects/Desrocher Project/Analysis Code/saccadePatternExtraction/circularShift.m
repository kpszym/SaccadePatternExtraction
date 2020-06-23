function [shifted_data] = circularShift(dist_centroid_matrix, rot_step)
% FUNCTION: Shifts each saccade waveform set a total of N-1 times (where N
%           is the number of points. This gives all the possible rotations
%           of the shape from which the waveform is derived from. 
%           
% INPUT: 
%           dist_centroid_matrix - Output from saccadeToWaveform.m. 
%
%           shift_matrix_collection - Output from shiftPrep.m
%
%           set_names - cell array continaing the labels of the sets.
% 
% OUTPUT:   
%           shifted_data - Same as shift_matrix_collection, but now each 2D
%           matrix contains all the shifted possibilities of the trial
%           waveform.
%
% Written by Karol Szymula, Complex System Group, 2020

numb_waveforms = 2*((360/rot_step)+1);
shift_prep_matrix_holder = zeros(numb_waveforms, 600, size(dist_centroid_matrix,1), 'single');
for n = 1:size(dist_centroid_matrix,1)
    shift_prep_matrix_holder(1:(numb_waveforms/2),:,n) = single(repmat(dist_centroid_matrix(n,:,1),[numb_waveforms/2,1]));
    shift_prep_matrix_holder(1+(numb_waveforms/2):numb_waveforms,:,n) = single(repmat(fliplr(dist_centroid_matrix(n,:,1)),[numb_waveforms/2,1]));
end

shifted_data = zeros(numb_waveforms, 600, size(dist_centroid_matrix,1),'single');
shift_step = 600/((numb_waveforms/2)-1);
for n = 1:size(dist_centroid_matrix,1)
    % Set shift values
    id = (0:((size(shift_prep_matrix_holder,1)/2)-1)).*(shift_step);
    
    % Shift all data per pattern
    shifted_data(1:(numb_waveforms/2),:,n) = cell2mat(arrayfun(@(x) circshift(shift_prep_matrix_holder(x,:,n), id(x), 2), (1:numel(id))','un',0));
    shifted_data((numb_waveforms/2+1):numb_waveforms,:,n) = cell2mat(arrayfun(@(x) circshift(shift_prep_matrix_holder(x+((numb_waveforms/2)),:,n), id(x), 2), (1:numel(id))','un',0));
end

