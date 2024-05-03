% Code to plot simulation results from BatteryMonitoring
%% Plot Description:
%
% The plot below shows the battery current and overcurrent error.

% Copyright 2022 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('BatteryMonitoringSimlog', 'var') || ...
        get_param('BatteryMonitoring','RTWModifiedTimeStamp') == double(simscape.logging.timestamp(BatteryMonitoringSimlog))
    sim('BatteryMonitoring')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_BatteryMonitoring', 'var') || ...
        ~isgraphics(h1_BatteryMonitoring, 'figure')
    h1_BatteryMonitoring = figure('Name', 'BatteryMonitoring');
end
figure(h1_BatteryMonitoring)
clf(h1_BatteryMonitoring)

% Get simulation results
simlog_current = BatteryMonitoringLogsout.get('current');
simlog_overcur = BatteryMonitoringLogsout.get('OverCur');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_current.Values.Time/3600, simlog_current.Values.Data(:,1), 'LineWidth', 1)
hold on
plot(simlog_current.Values.Time/3600, simlog_current.Values.Data(:,2), 'LineWidth', 1)
plot(simlog_current.Values.Time/3600, simlog_current.Values.Data(:,3), 'LineWidth', 1)
hold off
grid on
title('Battery current monitoring')
ylabel('Current (A)')
xlabel('Time (hours)')
legend({'Current','Upper limit','Lower limit'},'Location','Best');
simlog_handles(1) = subplot(2, 1, 2);
plot(simlog_overcur.Values.Time/3600, simlog_overcur.Values.Data(:), 'LineWidth', 1)
grid on
title('Overcurrent error')
ylabel('Error flag (-)')
xlabel('Time (hours)')

linkaxes(simlog_handles, 'x')  

% Remove temporary variables
clear simlog_current simlog_overcur
clear simlog_handles