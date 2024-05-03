%% Battery Monitoring
% This example shows how to use battery management system blocks to monitor 
% the current and temperature of a battery. A random current and
% temperature profile is applied to the battery which is then simulated 
% for 6 hours.

% Copyright 2022 The MathWorks, Inc.

%% Model

open_system('BatteryMonitoring')

set_param(find_system('BatteryMonitoring','FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Current Monitoring Results
%
% The plot below shows the battery current and overcurrent error.
%


BatteryMonitoringPlotCurrent;

%% Temperature Monitoring Results
%
% The plot below shows the battery temperature and temperature out-of-range
% errors.
%


BatteryMonitoringPlotTemp;

%% Results from Real-Time Simulation
%%
%
% This example has been tested on a Speedgoat Performance real-time target 
% machine with an Intel(R) 3.5 GHz i7 multi-core CPU. This model can run 
% in real time with a step size of 50 microseconds.

