% Code to plot simulation results from BatteryMonitoring
%% Plot Description:
%
% The plot below shows the battery temperature and temperature out-of-tange
% errors.

% Copyright 2022 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('BatteryMonitoringSimlog', 'var') || ...
        get_param('BatteryMonitoring','RTWModifiedTimeStamp') == double(simscape.logging.timestamp(BatteryMonitoringSimlog))
    sim('BatteryMonitoring')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_BatteryMonitoring', 'var') || ...
        ~isgraphics(h2_BatteryMonitoring, 'figure')
    h2_BatteryMonitoring = figure('Name', 'BatteryMonitoring');
end
figure(h2_BatteryMonitoring)
clf(h2_BatteryMonitoring)

% Get simulation results
simlog_temp = BatteryMonitoringLogsout.get('temperature');
simlog_overtemp = BatteryMonitoringLogsout.get('OverTemp');
simlog_undertemp = BatteryMonitoringLogsout.get('UnderTemp');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_temp.Values.Time/3600, simlog_temp.Values.Data(:,1), 'LineWidth', 1)
hold on
plot(simlog_temp.Values.Time/3600, simlog_temp.Values.Data(:,2), 'LineWidth', 1)
plot(simlog_temp.Values.Time/3600, simlog_temp.Values.Data(:,3), 'LineWidth', 1)
hold off
grid on
title('Battery temperature monitoring')
ylabel('Temperature (K)')
xlabel('Time (hours)')
legend({'Temperature','Upper limit','Lower limit'},'Location','Best');
simlog_handles(1) = subplot(2, 1, 2);
plot(simlog_overtemp.Values.Time/3600, simlog_overtemp.Values.Data(:), 'LineWidth', 1)
hold on
plot(simlog_undertemp.Values.Time/3600, simlog_undertemp.Values.Data(:), 'LineWidth', 1)
hold off
grid on
title('Out-of-range errors')
legend({'Overtemperature','Undertemperature'},'Location','Best');
ylabel('Error flag (-)')
xlabel('Time (hours)')

linkaxes(simlog_handles, 'x')  

% Remove temporary variables
clear simlog_temp simlog_undertemp simlog_overtemp
clear simlog_handles