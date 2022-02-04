clear; clc; close all;

N=50;
rinit=2.5;
sigma = 2.338;            %LJ sigma parameter
epsilon = 2.4096;             %LJ epsilon parameter
numNN = 2;

r = logspace(0.001,12,1800);
E = zeros(1,length(r));

for i = 1:length(r)
    rinit = r(i);
    [Etotal,force,x,chlen]=LJ_atom_array(N,rinit,epsilon,sigma,numNN);
    E(i) = Etotal;
end

% Energy vs. Atomic Spacing
% calculated plot
Ang = char(197);
[~,rm1] = min(E);
rmin1 = r(rm1);
E = E/50;   % normalize E
figure(1)
plot(r,E,'k*','MarkerSize',5)
xlim([2 4])
ylim([-10 15])
xlabel(['Atomic Spacing (',Ang,')'])
ylabel('Energy (eV)')
hold on
% analytical plot
r = 2:0.01:4;
Ea = 4.*epsilon.*((sigma./r).^12 - (sigma./r).^6);
rmin = logspace(0.001,12,3000);
Eamin = 4*epsilon*(((6*sigma^6)./rmin.^7) - ((12*sigma^12)./rmin.^13));
% Ea = Ea*100;
plot(r,Ea,'b','LineWidth',1)
plot(rmin,Eamin,'LineWidth',0.6)
anmin = ((4.*epsilon.*((sigma./rmin(105)).^12 - (sigma./rmin(105)).^6)) +...
    (4.*epsilon.*((sigma./rmin(106)).^12 - (sigma./rmin(106)).^6)))/2;
% zero line and legend
z = linspace(0,5);
y = zeros(length(z));
plot(z,y,'k--')
lgd = legend([' Computational = ',num2str(round(min(E),2)),' eV'],...
    [' Analytical = ',num2str(round(anmin,2)),' eV'],...
    ' Analytical Derivative','Location','northeast');
title(lgd,'Minimum Energy')
set(gcf,'position',[400,400,450,350])
[~,rm2] = min(Ea);
rmin2 = r(rm2);

%% Force vs atom position
clear; clc;

N=50;
rinit=2.5;
sigma = 2.338;            %LJ sigma parameter
epsilon = 2.4096;             %LJ epsilon parameter
numNN = 2;

req = 2.6375;
spacing = 0.0375;
% r1
r = [req-spacing req req+spacing];
r1 = r(1);
rinit = r1;
[~,force1,x1,~]=LJ_atom_array(N,rinit,epsilon,sigma,numNN);   
% r2 = req
r2 = r(2);
rinit = r2;
[~,force2,x2,~]=LJ_atom_array(N,rinit,epsilon,sigma,numNN);   
% r3
r3 = r(3);
rinit = r3;
[~,force3,x3,~]=LJ_atom_array(N,rinit,epsilon,sigma,numNN);   

% Plot
Ang = char(197);
LS = 1.5;
figure(2)
plot(x1,force1,'LineWidth',LS)
hold on
plot(x2,force2,'LineWidth',LS)
plot(x3,force3,'LineWidth',LS)
xlim([0 max(x3)])
ylim([-1.2 1.2])
lgd = legend([' ',num2str(r1),' ',Ang],...
    [' ',num2str(r2),' ',Ang,' (equilibrium)'],...
    [' ',num2str(r3),' ',Ang],...
    'Location','best');
title(lgd,'Atomic Spacing')
set(gcf,'position',[400,400,450,350])
xlabel([Ang,' (50 Atom Chain)'])
ylabel(['Force (eV/',Ang,')'])
