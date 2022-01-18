% Modeling Materials (ME EN 556) - Random Walk Assignment - P3
clc; clear; close all;
%uncomment next line to set random number generator seed so that answers are consistent
% rng(1);

%define the latticeConstant
latticeConstant=1;
%define the initial position
initialPos=[0,0];
%define the number of desired jumps
Njumps=1000;
%define the increment of time for each jump
dt=1;
%define the number of trajectories
Ktrajectories=2000;

%set the time (column) vector
t=dt * (0:1:Njumps)';

%get the updated position and jump by calling the function randomJumpSeries
[newPosSerTrajs,SDserTrajs,MSDser]=randomJumpSeriesTrajectories(Ktrajectories,Njumps,initialPos,latticeConstant);

%plot the data

%plot data for first few jump series and squared displacements
% Kplot=3; % square root of number of trajectories to plot ( will get this number squared)
% f1=figure;
% f2=figure;
% a2=axes('parent',f2);
% hold(a2,'on');
% count=0;
% for kk=1:(Kplot^2)
%     count=count+1;
%     %plot jump paths
%     a1=subplot(Kplot,Kplot,count,'parent',f1);
%     hold(a1,'on');
%     plot(a1,[newPosSerTrajs(1:end-1,1,count),newPosSerTrajs(2:end,1,count)],...
%         [newPosSerTrajs(1:end-1,2,count),newPosSerTrajs(2:end,2,count)],'k-')
%     plot(a1,newPosSerTrajs(1,1,count),newPosSerTrajs(1,2,count),'r*',...
%         newPosSerTrajs(end,1,count),newPosSerTrajs(end,2,count),'gs')
%     axis(a1,'equal')
%     box(a1,'on');
%     
%     %plot squared displacements
%     plot(t,SDserTrajs(:,count),'-');
%     
% end
% box(a2,'on');
% xlabel(a2,'Time')
% ylabel(a2,'Squared Displacement')
% 
% %plot the MSD
% f3=figure;
% a3=axes('parent',f3);
% plot(a3,t,MSDser,'r')
% title(['n = ',num2str(Njumps),', a = ',num2str(latticeConstant)])
% set(gcf,'position',[200,200,350,300])
% xlabel(a3,'Time')
% ylabel(a3,'Mean Squared Displacement')
%%

[r,~] = size(SDserTrajs);
x = sqrt(SDserTrajs(r,:));
% z = max(x);
% zz = z/20;
% y = zeros(1,zz);
% i = 1;
% for n = zz:zz:z
%     y(1,i) = sum(x(x>=n-zz & x<n));
%     i = i+1;
% end
% y = y/Ktrajectories;


%% plot distribution
histogram(x,30)
xlabel 'r'
ylabel 'Number of Trajectories'



