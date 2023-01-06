%% problem description and initialization 

clear all
clc
close all

% Misson: read data and plot Temperature between thermocouples vs time;
% Total energy collected in the water(also average power over that time);
% Matimeimum heating power


% automated program : the whole structure design 
% 1.read data from the etimeperiment data file
% 2.plot Temperature between thermocouples vs time
% 3.create a function that calculated energy collected and plot power vs t
% 4.create a function that calculated the heating power.


%% Main script
%% 1: read data from the etimeperiment data file
filename = 'ExpData.lvm';
delimiterIn = '\t';
headerlinesIn = 23;
A = importdata(filename,delimiterIn,headerlinesIn);
%% 2: plot Temperature between thermocouples vs time
time = A.data(:,1);
T_of_couple1 = A.data(:,2);
T_of_couple2 = A.data(:,4);
T_of_couple3 = A.data(:,6);

tiledlayout(3,1,"TileSpacing",'compact')
%Top
ax1 = nexttile;
plot(ax1,time,T_of_couple1,Color='g')
title(ax1,'Temperature between thermocouples vs time',FontSize=18)
legend('Thermocouple 1',Location='northwest')
%Middle
ax2 = nexttile;
plot(ax2,time,T_of_couple2,Color='r')
ylabel(ax2,'Temperature',FontSize=30)
legend('Thermocouple 2',Location='northwest')
%Bottom
ax3 = nexttile;
plot(ax3,time,T_of_couple3,Color='b')
xlabel(ax3,'Time',FontSize=30)
legend('Thermocouple 3',Location='northwest')

%In a single figure
figure
plot(time,T_of_couple1)
hold on
plot(time,T_of_couple2)
plot(time,T_of_couple3)
legend('Thermocouple1','Thermocouple2','Thermocouple3',Location='northwest')
title('Temperature vs Times')

%% 3:Calculated energy captured and plot power vs t
m = 0.3; % mass of water in kg
heat_water = xlsread("Specific heat of water.xlsx",'A2:B41');

%fit a line for specific heat of water

% check the shape to choose degree of fitting curve
plot(heat_water(:,1),heat_water(:,2))
hold on
% quadratic fitting
coefficients = polyfit(heat_water(:,1),heat_water(:,2),6); 
% Create a new x axis with exactly 1000 points.
xFit = linspace(min(heat_water(:,1)), max(heat_water(:,1)), 1000); 
yFit = polyval(coefficients , xFit);
% compare fitting curve with real specific heat of water data 
plot(xFit, yFit) 
format long
display(['Equation is heat_water = ' num2str(coefficients(1)) '*T^6 +' num2str(coefficients(2)) ...
    '*T^5 +' num2str(coefficients(3)) '*T^4 +' num2str(coefficients(4)) '*T^3 +' ...
    num2str(coefficients(5)) '*T^2 +' num2str(coefficients(6)) '*T +' num2str(coefficients(7))])
%function for specific of heat of water with variable temperature
heatofwater = @(x) coefficients(1)*x.^6 + coefficients(2)*x.^5 + ...
    coefficients(3)*x.^4 + coefficients(4)*x.^3 ...
    + coefficients(5)*x.^2 + coefficients(6)*x.^1 + coefficients(7);

%% Energy
integral1 = m*heatofwater(T_of_couple1);
integral2 = m*heatofwater(T_of_couple2);
integral3 = m*heatofwater(T_of_couple3);
% energy captured using temperature from 3 thermocouples
E_couple1 = trapz(T_of_couple1,integral_fun);
E_couple2 = trapz(T_of_couple2,integral_fun);
E_couple3 = trapz(T_of_couple3,integral_fun);
% average energy captured
avEnergy = (E_couple3+E_couple2+E_couple1)/3
% average power
avPower = avEnergy/(max(time)-min(time))
