function [trsp_polygon] = saccadeToPolygon(trsp_sequence)
% FUNCTION: Converts the longest cyclic saccade path, the TRSP, into a 
%           polygon. Each saccade between two targets consists of 100 (x,y) 
%           coordinate points. 
%
% INPUT: 
%           trsp_sequence - Output from identifyTRSP.mat. Cell array
%           containing the longest cyclic path of each trial
% 
% OUTPUT:   
%           trsp_polygon - (x,y) coordinate points representing the
%           shape of the TRSP. 
%       
% Written by Karol Szymula, Complex System Group, 2019
node_xdata = [1 4 7 1 4 7 1 4 7];
node_ydata = [7 7 7 4 4 4 1 1 1];
seq_data = [];
for m = 1:size(trsp_sequence,1)
    seq_data = [seq_data; [node_xdata(trsp_sequence(m,1)), node_ydata(trsp_sequence(m,1))]];
    if m == size(trsp_sequence,1)
        seq_data = [seq_data; node_xdata(trsp_sequence(m,2)), node_ydata(trsp_sequence(m,2))];
    end
end

final_data = [];
for l = 1:size(seq_data,1)-1
    ratio = pdist([seq_data(l,:);seq_data(l+1,:)],'euclidean')/3;
    NumberNewPoints = round(100*ratio);
    xvals = linspace(seq_data(l,1), seq_data(l+1,1), NumberNewPoints);
    yvals = linspace(seq_data(l,2), seq_data(l+1,2), NumberNewPoints);
    pts = [xvals(:), yvals(:)];
    final_data = [final_data; pts];
end

% Make sure polygon coordinates start with top left corner of grid
dist_to_poly_start = pdist([1 7; final_data]);
dist_to_poly_start_mat = squareform(dist_to_poly_start);
[~,min_idx] = min(dist_to_poly_start_mat(1,2:end));
if min_idx > 1
    shift_amt = ((size(final_data,1)) - (min_idx));
    fixed_shift_idx = circshift(1:size(final_data,1), shift_amt, 2);
    final_data = final_data(fixed_shift_idx,:);
end
poly_orientation = checkPolygonCoordinate_Orientation(final_data, 1, [], []);
if poly_orientation == 0
    final_data(2:end,:) = flipud(final_data(2:end,:));
end

trsp_polygon = final_data;
