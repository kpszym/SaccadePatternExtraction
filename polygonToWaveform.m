function [trsp_waveform] = polygonToWaveform(trsp_polygon, poly_centroid)
% FUNCTION: Converts the TRSP polygon into a 1-D waveform, repreenting the 
%           euclidean distance of each point of the polygon from the 
%           centroid of the polygon. 
%
% INPUT: 
%           trsp_polygon - Output from saccadeToPolygon.mat. Matric of two
%           columns containing the (x,y) coordinates of points making up
%           the polygon. 
%
%           poly_centroid - (x,y) coordinates of polygon centroid
% 
% OUTPUT:   
%           trsp_waveform - 1x500 vector of euclidean distances of polygon 
%           coordinate points from polygon centroid.
%       
% Written by Karol Szymula, Complex System Group, 2020

% Calcualte the distance of each point to centroid
dist_centroid = sqrt((trsp_polygon(:,1)-poly_centroid(1)).^2 + (trsp_polygon(:,2)-poly_centroid(2)).^2);

% Interpolate waveform to consist of only 600 points each
trsp_waveform = interp1(1:length(dist_centroid), dist_centroid, linspace(1,length(dist_centroid), 600));

