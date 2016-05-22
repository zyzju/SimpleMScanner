function handles = scannerGUI_fig
% Build a GUI for the scanner and return the handles to the plot and ui objects
%	
% function handles = scannerGUI_fig
%
% 


handles.hFig = figure;
set(handles.hFig, ...
	'ToolBar', 'none', ...
	'MenuBar', 'none', ...
	'Name', 'scannerGUI');


%Scan button
handles.startStopScan = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'normalized', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [0.1 0.1 0.18 0.12], ...
    'ForeGroundColor','g', ...
    'String', 'START SCAN');


%Bidi checkbox
handles.bidi = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'normalized', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [0.3 0.15 0.1 0.05], ...
    'Style','CheckBox', ...
    'String', 'Bidi');
