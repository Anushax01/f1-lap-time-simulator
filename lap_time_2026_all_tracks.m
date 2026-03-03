%% ===================================================
%   FORMULA 1 2026 LAP TIME SIMULATOR
%   Complete 24-Race Calendar Edition
%   Created by: ANOSHA
%   Description: Lap time prediction for all F1 2026 circuits
%% ===================================================

clc; clear; close all;

fprintf('\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf('                 FORMULA 1 2026 LAP TIME SIMULATOR                         \n');
fprintf('                    Complete 24-Race Calendar Edition                      \n');
fprintf('════════════════════════════════════════════════════════════════════════════\n\n');

%% CAR PARAMETERS (Standard F1 2026 Specs)
mass = 798;        % kg (F1 minimum weight with driver)
power = 735000;    % watts (985 hp - F1 hybrid era)
Cd = 0.7;          % drag coefficient
Area = 1.5;        % frontal area (m^2)
rho = 1.225;       % air density
mu = 1.4;          % tire grip (F1 spec)
g = 9.81;          % gravity

%% F1 2026 COMPLETE CALENDAR DATABASE
% Each circuit has unique characteristics

fprintf('F1 2026 RACE CALENDAR\n');
fprintf('────────────────────────────────────────────────────────────────────────────\n');
fprintf(' #  Grand Prix         Circuit            Country         Date\n');
fprintf('────────────────────────────────────────────────────────────────────────────\n');

circuits = {
    1,  'Australian GP',     'Albert Park',        'Australia',     'Mar 6-8';
    2,  'Chinese GP',        'Shanghai',           'China',         'Mar 20-22';
    3,  'Japanese GP',       'Suzuka',             'Japan',         'Apr 3-5';
    4,  'Bahrain GP',        'Sakhir',             'Bahrain',       'Apr 17-19';
    5,  'Saudi Arabian GP',  'Jeddah',             'Saudi Arabia',  'May 1-3';
    6,  'Miami GP',          'Miami',              'USA',           'May 15-17';
    7,  'Emilia Romagna GP', 'Imola',              'Italy',         'May 22-24';
    8,  'Monaco GP',         'Monaco',             'Monaco',        'May 29-31';
    9,  'Spanish GP',        'Barcelona',          'Spain',         'Jun 5-7';
    10, 'Canadian GP',       'Montreal',           'Canada',        'Jun 12-14';
    11, 'Austrian GP',       'Red Bull Ring',      'Austria',       'Jun 26-28';
    12, 'British GP',        'Silverstone',        'UK',            'Jul 3-5';
    13, 'Belgian GP',        'Spa-Francorchamps',  'Belgium',       'Jul 17-19';
    14, 'Hungarian GP',      'Hungaroring',        'Hungary',       'Jul 24-26';
    15, 'Dutch GP',          'Zandvoort',          'Netherlands',   'Jul 31-Aug 2';
    16, 'Italian GP',        'Monza',              'Italy',         'Aug 28-30';
    17, 'Azerbaijan GP',     'Baku',               'Azerbaijan',    'Sep 4-6';
    18, 'Singapore GP',      'Marina Bay',         'Singapore',     'Sep 18-20';
    19, 'United States GP',  'COTA',               'USA',           'Oct 2-4';
    20, 'Mexican GP',        'Mexico City',        'Mexico',        'Oct 23-25';
    21, 'Brazilian GP',      'Interlagos',         'Brazil',        'Oct 30-Nov 1';
    22, 'Las Vegas GP',      'Las Vegas',          'USA',           'Nov 13-15';
    23, 'Qatar GP',          'Lusail',             'Qatar',         'Nov 27-29';
    24, 'Abu Dhabi GP',      'Yas Marina',         'UAE',           'Dec 4-6';
    };

for i = 1:24
    fprintf(' %2d  %-18s %-18s %-15s %s\n', circuits{i,:});
end

fprintf('────────────────────────────────────────────────────────────────────────────\n\n');

%% CIRCUIT SELECTION
circuit_choice = input('Select circuit number (1-24): ');

% Circuit-specific parameters based on track characteristics
switch circuit_choice
    case 1  % Australian GP
        track_name = 'Albert Park';
        country = 'Australia';
        straight1 = 900;      % Main straight length (m)
        corner_radius = 45;    % Average corner radius (m)
        straight2 = 600;       % Back straight (m)
        track_type = 'Street Circuit';
        
    case 2  % Chinese GP
        track_name = 'Shanghai International Circuit';
        country = 'China';
        straight1 = 1200;
        corner_radius = 40;
        straight2 = 800;
        track_type = 'Permanent Circuit';
        
    case 3  % Japanese GP
        track_name = 'Suzuka Circuit';
        country = 'Japan';
        straight1 = 950;
        corner_radius = 60;    % High-speed corners
        straight2 = 700;
        track_type = 'Permanent Circuit';
        
    case 4  % Bahrain GP
        track_name = 'Bahrain International Circuit';
        country = 'Bahrain';
        straight1 = 1100;
        corner_radius = 35;    % Tight technical sections
        straight2 = 900;
        track_type = 'Permanent Circuit';
        
    case 5  % Saudi Arabian GP
        track_name = 'Jeddah Corniche Circuit';
        country = 'Saudi Arabia';
        straight1 = 1000;
        corner_radius = 55;    % High-speed street circuit
        straight2 = 850;
        track_type = 'Street Circuit';
        
    case 6  % Miami GP
        track_name = 'Miami International Autodrome';
        country = 'USA';
        straight1 = 800;
        corner_radius = 50;
        straight2 = 600;
        track_type = 'Street Circuit';
        
    case 7  % Emilia Romagna GP
        track_name = 'Imola Circuit';
        country = 'Italy';
        straight1 = 700;
        corner_radius = 45;
        straight2 = 500;
        track_type = 'Permanent Circuit';
        
    case 8  % Monaco GP
        track_name = 'Circuit de Monaco';
        country = 'Monaco';
        straight1 = 500;       % Very short straights
        corner_radius = 20;    % Very tight corners
        straight2 = 300;
        track_type = 'Street Circuit';
        
    case 9  % Spanish GP
        track_name = 'Circuit de Barcelona-Catalunya';
        country = 'Spain';
        straight1 = 1000;
        corner_radius = 50;
        straight2 = 700;
        track_type = 'Permanent Circuit';
        
    case 10 % Canadian GP
        track_name = 'Circuit Gilles Villeneuve';
        country = 'Canada';
        straight1 = 900;
        corner_radius = 40;
        straight2 = 800;
        track_type = 'Street Circuit';
        
    case 11 % Austrian GP
        track_name = 'Red Bull Ring';
        country = 'Austria';
        straight1 = 800;
        corner_radius = 45;
        straight2 = 600;
        track_type = 'Permanent Circuit';
        
    case 12 % British GP
        track_name = 'Silverstone Circuit';
        country = 'UK';
        straight1 = 1100;      % Long straights
        corner_radius = 65;    % High-speed corners
        straight2 = 900;
        track_type = 'Permanent Circuit';
        
    case 13 % Belgian GP
        track_name = 'Spa-Francorchamps';
        country = 'Belgium';
        straight1 = 1200;      % Very long straights
        corner_radius = 70;    % Famous Eau Rouge, Pouhon
        straight2 = 1000;
        track_type = 'Permanent Circuit';
        
    case 14 % Hungarian GP
        track_name = 'Hungaroring';
        country = 'Hungary';
        straight1 = 800;
        corner_radius = 35;    
        straight2 = 600;
        track_type = 'Permanent Circuit';
        
    case 15 % Dutch GP
        track_name = 'Circuit Zandvoort';
        country = 'Netherlands';
        straight1 = 700;
        corner_radius = 40;
        straight2 = 500;
        track_type = 'Permanent Circuit';
        
    case 16 % Italian GP
        track_name = 'Autodromo Nazionale Monza';
        country = 'Italy';
        straight1 = 1300;      
        corner_radius = 50;    % Temple of Speed
        straight2 = 1100;
        track_type = 'Permanent Circuit';
        
    case 17 % Azerbaijan GP
        track_name = 'Baku City Circuit';
        country = 'Azerbaijan';
        straight1 = 2000;      
        corner_radius = 30;    % Very long straight, tight castle section
        straight2 = 400;
        track_type = 'Street Circuit';
        
    case 18 % Singapore GP
        track_name = 'Marina Bay Street Circuit';
        country = 'Singapore';
        straight1 = 800;
        corner_radius = 30;    % Tight street circuit
        straight2 = 600;
        track_type = 'Street Circuit';
        
    case 19 % United States GP
        track_name = 'Circuit of the Americas';
        country = 'USA';
        straight1 = 1000;
        corner_radius = 55;
        straight2 = 800;
        track_type = 'Permanent Circuit';
        
    case 20 % Mexican GP
        track_name = 'Autodromo Hermanos Rodriguez';
        country = 'Mexico';
        straight1 = 1200;      
        corner_radius = 40;
        straight2 = 700;
        track_type = 'Permanent Circuit';
        
    case 21 % Brazilian GP
        track_name = 'Interlagos';
        country = 'Brazil';
        straight1 = 900;
        corner_radius = 45;
        straight2 = 700;
        track_type = 'Permanent Circuit';
        
    case 22 % Las Vegas GP
        track_name = 'Las Vegas Strip Circuit';
        country = 'USA';
        straight1 = 1500;      
        corner_radius = 50;
        straight2 = 800;
        track_type = 'Street Circuit';
        
    case 23 % Qatar GP
        track_name = 'Lusail International Circuit';
        country = 'Qatar';
        straight1 = 1000;
        corner_radius = 45;
        straight2 = 800;
        track_type = 'Permanent Circuit';
        
    case 24 % Abu Dhabi GP
        track_name = 'Yas Marina Circuit';
        country = 'UAE';
        straight1 = 1000;
        corner_radius = 40;
        straight2 = 700;
        track_type = 'Permanent Circuit';
        
    otherwise
        fprintf('Invalid selection. Using Australian GP as default.\n');
        track_name = 'Albert Park';
        country = 'Australia';
        straight1 = 900;
        corner_radius = 45;
        straight2 = 600;
        track_type = 'Street Circuit';
end

%% CALCULATIONS
fprintf('\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf(' SIMULATING: %s Grand Prix\n', circuits{circuit_choice,2});
fprintf(' Circuit: %s, %s\n', track_name, country);
fprintf(' Track Type: %s\n', track_type);
fprintf('════════════════════════════════════════════════════════════════════════════\n');

% Calculate top speed limited by drag
v_max_drag = (2 * power / (rho * Cd * Area))^(1/3);
step = 10;

% Initialize arrays
d_record = [];
v_record = [];

%% PART 1: FIRST STRAIGHT
v = 0;
distance = 0;

while distance < straight1
    F_drag = 0.5 * rho * Cd * Area * v^2;
    
    if v < 0.1
        F_engine = power / 0.1;
    else
        F_engine = power / v;
    end
    
    F_net = F_engine - F_drag;
    a = F_net / mass;
    
    v_new = sqrt(v^2 + 2 * a * step);
    if v_new > v_max_drag
        v_new = v_max_drag;
    end
    
    distance = distance + step;
    d_record = [d_record, distance];
    v_record = [v_record, v_new];
    v = v_new;
end

speed1 = v;

%% PART 2: CORNER
v_corner_max = sqrt(mu * g * corner_radius);
corner_distance = pi * corner_radius;

if speed1 > v_corner_max
    v_corner = v_corner_max;
    braking_distance = (speed1^2 - v_corner^2) / (2 * mu * g);
    d_record = [d_record, straight1 + braking_distance];
    v_record = [v_record, v_corner];
else
    v_corner = speed1;
end

time_corner = corner_distance / v_corner;
corner_end = straight1 + corner_distance;

d_record = [d_record, corner_end];
v_record = [v_record, v_corner];

%% PART 3: SECOND STRAIGHT
v = v_corner;
distance = corner_end;

while distance < corner_end + straight2
    F_drag = 0.5 * rho * Cd * Area * v^2;
    
    if v < 0.1
        F_engine = power / 0.1;
    else
        F_engine = power / v;
    end
    
    F_net = F_engine - F_drag;
    a = F_net / mass;
    
    v_new = sqrt(v^2 + 2 * a * step);
    if v_new > v_max_drag
        v_new = v_max_drag;
    end
    
    distance = distance + step;
    d_record = [d_record, distance];
    v_record = [v_record, v_new];
    v = v_new;
end

%% CALCULATE LAP TIME
time_straight1 = straight1 / ((0 + speed1) / 2);
time_straight2 = straight2 / ((v_corner + v) / 2);
total_time = time_straight1 + time_corner + time_straight2;
total_distance = straight1 + corner_distance + straight2;

%% DISPLAY RESULTS
fprintf('\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf(' LAP TIME SIMULATION RESULTS\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf(' VEHICLE SPECIFICATIONS:\n');
fprintf('   • Mass: %.0f kg\n', mass);
fprintf('   • Power: %.0f HP\n', power/745.7);
fprintf('   • Top Speed: %.1f km/h\n', max(v_record)*3.6);
fprintf('\n');
fprintf(' TRACK: %s Grand Prix\n', circuits{circuit_choice,2});
fprintf('   • Circuit: %s\n', track_name);
fprintf('   • Country: %s\n', country);
fprintf('   • Type: %s\n', track_type);
fprintf('   • Simulated Sector Time: %.2f seconds\n', total_time);
fprintf('   • Corner Speed: %.1f km/h\n', v_corner*3.6);
fprintf('   • Sector Length: %.0f m\n', total_distance);
fprintf('\n');
fprintf(' PIT STRATEGY ANALYSIS:\n');
fprintf('   • 1 Stop (Medium-Hard): %.1f s race time\n', total_time*58 + 25);
fprintf('   • 1 Stop (Soft-Medium): %.1f s race time\n', total_time*58 + 25 + total_time*0.5);
fprintf('   • 2 Stops: %.1f s race time\n', total_time*58 + 50 + total_time*0.3);
fprintf('   • No Stop: %.1f s race time\n', total_time*58 + total_time*2);
fprintf('\n');
fprintf(' WEATHER IMPACT:\n');
fprintf('   • Dry (Optimal): %.2f s\n', total_time);
fprintf('   • Damp: %.2f s (+%.1f s)\n', total_time*1.08, total_time*0.08);
fprintf('   • Wet: %.2f s (+%.1f s)\n', total_time*1.15, total_time*0.15);
fprintf('   • Heavy Rain: %.2f s (+%.1f s)\n', total_time*1.25, total_time*0.25);
fprintf('════════════════════════════════════════════════════════════════════════════\n');

%% PLOT RESULTS
figure('Position', [100, 100, 1200, 600]);

% Speed Profile
subplot(2,2,1);
plot(d_record, v_record * 3.6, 'b-', 'LineWidth', 2);
xlabel('Distance (m)');
ylabel('Speed (km/h)');
title(sprintf('%s GP - Speed Profile', circuits{circuit_choice,2}));
grid on;
hold on;
xline(straight1, 'r--', 'LineWidth', 1.5);
xline(corner_end, 'r--', 'LineWidth', 1.5);
hold off;

% Track Map (simplified representation)
subplot(2,2,2);
% Create circular track representation
theta = linspace(0, 2*pi, 100);
x_track = cos(theta) * total_distance/(2*pi);
y_track = sin(theta) * total_distance/(2*pi);
plot(x_track, y_track, 'b-', 'LineWidth', 2);
hold on;
plot(x_track(1), y_track(1), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
plot(x_track(50), y_track(50), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
axis equal off;
title('Track Layout (Representation)');
text(0, -total_distance/4, track_name, 'HorizontalAlignment', 'center');

% Strategy Comparison
subplot(2,2,3);
strategies = {'1 Stop M-H', '1 Stop S-M', '2 Stops', 'No Stop'};
strategy_times = [total_time*58 + 25, total_time*58 + 25 + total_time*0.5, ...
                  total_time*58 + 50 + total_time*0.3, total_time*58 + total_time*2];
bar(strategy_times, 'FaceColor', [0.2 0.4 0.8]);
set(gca, 'XTickLabel', strategies);
ylabel('Race Time (s)');
title('Pit Strategy Comparison');
grid on;

% Weather Impact
subplot(2,2,4);
weather = {'Dry', 'Damp', 'Wet', 'Heavy Rain'};
weather_times = [total_time, total_time*1.08, total_time*1.15, total_time*1.25];
bar(weather_times, 'FaceColor', [0.3 0.5 0.9]);
set(gca, 'XTickLabel', weather);
ylabel('Lap Time (s)');
title('Weather Impact');
grid on;

sgtitle(sprintf('F1 2026 %s Grand Prix - Lap Time Simulation', circuits{circuit_choice,2}), ...
    'FontSize', 14, 'FontWeight', 'bold');

%% CALENDAR OVERVIEW
fprintf('\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf(' COMPLETE F1 2026 CALENDAR - QUICK COMPARISON\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf(' #  Grand Prix         Est. Lap Time  Top Speed    Circuit Type\n');
fprintf('────────────────────────────────────────────────────────────────────────────\n');

% Quick estimates for all circuits
estimates = [
    32.8, 376;  % Australia
    35.2, 372;  % China
    31.5, 380;  % Japan
    34.1, 374;  % Bahrain
    29.8, 388;  % Saudi
    33.4, 370;  % Miami
    34.5, 365;  % Imola
    42.0, 320;  % Monaco (slowest)
    32.5, 375;  % Spain
    33.8, 373;  % Canada
    30.5, 382;  % Austria
    31.2, 385;  % Silverstone
    28.5, 390;  % Spa (fastest)
    35.5, 360;  % Hungary
    34.8, 362;  % Zandvoort
    27.5, 395;  % Monza (highest speed)
    30.2, 384;  % Baku
    36.5, 350;  % Singapore
    32.2, 377;  % COTA
    33.0, 371;  % Mexico
    31.8, 378;  % Brazil
    29.5, 386;  % Las Vegas
    33.2, 375;  % Qatar
    36.1, 368;  % Abu Dhabi
];

for i = 1:24
    type_symbol = 'P';
    if contains(circuits{i,5}, 'Street')
        type_symbol = 'S';
    end
    fprintf(' %2d  %-18s %8.1f s   %4.0f km/h     %s\n', ...
        i, circuits{i,2}, estimates(i,1), estimates(i,2), type_symbol);
end

fprintf('────────────────────────────────────────────────────────────────────────────\n');
fprintf(' P = Permanent Circuit | S = Street Circuit\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
fprintf('\n');
fprintf('SIMULATION COMPLETE - Check figure window for detailed visualization.\n');
fprintf('════════════════════════════════════════════════════════════════════════════\n');
