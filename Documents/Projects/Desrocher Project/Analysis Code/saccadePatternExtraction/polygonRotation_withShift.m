function polygonRotation_withShift(trsp_polygon, poly_centroid, step_deg)
% FUNCTION: Creates a live graphic showing the rotation of the specified
%           polygon and its waveform being circularly shifted.
%     
% Written by Karol Szymula, Complex System Group, 2019

theta = step_deg; % degrees to rotate by counterclockwise per step
trsp_polygon(:,3) = ones(size(trsp_polygon,1),1);

% Counter-clock wise rotation matrix
R = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];

% Set rotation to be about grid center (4,4)
posT = [1 0 4; 0 1 4; 0 0 1];
negT = [1 0 -4; 0 1 -4; 0 0 1];

% Create figure to display TRSP and Waveform
%h = figure;
figure;
subplot(1,2,1)
plot(trsp_polygon(:,1), trsp_polygon(:,2), 'Color', 'black', 'LineWidth', 2)
xlim([-2,10]);
ylim([-2,10]); 
set(gca, 'xtick', [], 'xticklabel', [],...
    'ytick', [], 'yticklabel', [],...
    'XColor', [0.5,0.5,0.5], 'YColor', [0.5,0.5,0.5],'LineWidth', 1);
current_polygon = trsp_polygon;

subplot(1,2,2)
plot(polygonToWaveform(trsp_polygon, poly_centroid), 'Color', 'black', 'LineWidth', 2);
xlim([0,500]);

pause()
for rt = 1:length(1:theta:360)
    poly_rotated = posT*R*negT*current_polygon';
    poly_rotated = poly_rotated';
    
    subplot(1,2,1)
    plot(poly_rotated(:,1), poly_rotated(:,2), 'Color', 'black', 'LineWidth', 2)
    xlim([-2,10]);
    ylim([-2,10]); 
    set(gca, 'xtick', [], 'xticklabel', [],...
        'ytick', [], 'yticklabel', [],...
        'XColor', [0.5,0.5,0.5], 'YColor', [0.5,0.5,0.5],'LineWidth', 1);
    current_polygon = poly_rotated;

    subplot(1,2,2)
    %plot(polygonToWaveform(trsp_polygon, poly_centroid), 'Color', 'red', 'LineWidth', 1);
    %hold on
    plot(circshift(polygonToWaveform(trsp_polygon, poly_centroid), ceil((rt*theta)*500/360)), 'Color', 'black', 'LineWidth', 2); 
    %hold off
    xlim([0,500]);

    pause()
end