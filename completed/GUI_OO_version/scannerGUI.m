classdef scannerGUI < handle

% The scannerGUI class is used to build a GUI that controls
% scanAndAcquire_OO
%
% simply run "scannerGUI" to start.
% if scanAndAcquire_OO has not already been started, scannerGUI will do so


	properties
		gui 	 %Stores the GUI handles
		scanner  %Stores the scanAndAcquire_OO object
	end

	properties (Hidden)
		scanning=0
	end

	methods

		function obj=scannerGUI(deviceID,varargin)

			%Import BakingTray object from base workspace			
			obj.scanner = getScannerObjectFromBaseWorkSpace; %function in "private" directory
			if isempty(obj.scanner)
				obj.scanner = scanAndAcquire_OO(deviceID,varargin{:});
			end

			%Build GUI and return handles
			obj.gui = scannerGUI_fig;

			%Attach callbacks to buttons is BT is available
			if isempty(obj.scanner)
				fprintf('Not attaching button callbacks: BakingTray is not available')
				return
			end

    		set(obj.gui.startStopScan,'Callback',@(~,~) obj.startStopScan);
    		set(obj.gui.bidi,'Callback',@(~,~) obj.bidiScan);

		    set(obj.gui.hFig,'CloseRequestFcn', @obj.scannerGUIClose);

		end

		function delete(obj)


		end

		function scannerGUIClose(obj,~,~)
			%Close figure then run destructor
			if obj.scanning
				obj.scanner.stopScan
			end
			delete(obj.gui.hFig)
		end

		function startStopScan(obj)
			if obj.scanning
				obj.scanner.stopScan
				obj.scanning=0;
				set(obj.gui.startStopScan, ...
					'Value', obj.scanning, ...
					'ForeGroundColor', 'g', ...
					'String', 'START SCAN');
			else
				%Open a figure in the top right of the screen
				thisFig=figure;
				movegui(thisFig,'northwest')

				obj.scanner.startScan
				obj.scanning=1;
				set(obj.gui.startStopScan, ...
					'Value', obj.scanning, ...
					'ForeGroundColor', 'r', ...
					'String', 'STOP SCAN');
			end
		end	%close startStopScan

		function bidiScan(obj)
			if obj.gui.bidi.Value
				obj.scanner.scanPattern='bidi';
			else
				obj.scanner.scanPattern='uni';
			end
			obj.scanner.restartScan
		end %close bidiScan

	end %close methods


end %close scannerGUI

