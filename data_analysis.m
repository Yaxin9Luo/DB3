%% problem description and initialization 

clear all
clc
close all

% Misson: read data and plot Temperature between thermocouples vs time;
% Total energy collected in the water(also average power over that time);
% Maximum heating power


% automated program : the whole structure design 
% 1.read data from the experiment data file
% 2.plot Temperature between thermocouples vs time
% 3.create a function that calculated energy collected and plot power vs t
% 4.create a function that calculated the heating power.



%% Main script
% 1: read data from the experiment data file
filename = 'ExpData.lvm';
delimiterIn = '\t';
headerlinesIn = 23;
A = importdata(filename,delimiterIn,headerlinesIn);

% 2: plot Temperature between thermocouples vs time
x = A.data(:,1);
T_of_couple1 = A.data(:,2);
T_of_couple2 = A.data(:,4);
T_of_couple3 = A.data(:,6);


tiledlayout(3,1,"TileSpacing",'compact')
%Top
ax1 = nexttile;
plot(ax1,x,T_of_couple1,Color='g')
title(ax1,'Temperature between thermocouples vs time',FontSize=18)
legend('Thermocouple 1',Location='northwest')
%Middle
ax2 = nexttile;
plot(ax2,x,T_of_couple2,Color='r')
ylabel(ax2,'Temperature',FontSize=30)
legend('Thermocouple 2',Location='northwest')
%Bottom
ax3 = nexttile;
plot(ax3,x,T_of_couple3,Color='b')
xlabel(ax3,'Time',FontSize=30)
legend('Thermocouple 3',Location='northwest')

%In a single figure
figure
plot(x,T_of_couple1)
hold on
plot(x,T_of_couple2)
plot(x,T_of_couple3)
legend('Thermocouple1','Thermocouple2','Thermocouple3',Location='northwest')
title('Temperature vs Times')
%3:calculated energy captured and plot power vs t


%{
figure
subplot(1,3,1)
plot(x,T_of_couple1)
title('Thermocouple 1')
xlabel('Time')
ylabel('Temperature')

subplot(1,3,2)
plot(x,T_of_couple2)
title('Thermocouple 2')
xlabel('Time')
ylabel('Temperature')

subplot(1,3,3)
plot(x,T_of_couple3)
title('Thermocouple3')
xlabel('Time')
ylabel('Temperature')
%}