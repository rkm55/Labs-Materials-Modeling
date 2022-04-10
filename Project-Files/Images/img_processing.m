%%% image processing
clear; clc; close all;

%% Temperatures

latparam = [4.0982,4.1031,4.1076,4.1115];
height = [latparam(1:3)*60, latparam(4)*90];
temp = 750:50:900;
time = 500:100:800;

n_grains = 4;
L_grain = zeros(n_grains);
fraction = zeros(n_grains);
for m = 1:n_grains
    for n = 1:n_grains
        filename = [num2str(temp(m)),'K_',num2str(time(n)),'.png'];
        I = imread(filename,"png");
        I = im2bw(I);
        % imshow(I)
        [r,c] = size(I);
        center = round(c/2);
        for i = 1:r
            s = sum(I(i:i+9,center),'all');
            if s == 10
                break
            end
        end
        L = r-i;
        fraction(n,m) = L/r;
        L_grain(n,m) = fraction(n,m)*height(m);
    end
end

dx = diff(L_grain);
t = diff(time).'; 

v = zeros(3,4);
for i = 1:4
    v(:,i) = -1*(dx(:,i)./t);
end
v = mean(v,1);

% fit line
P = polyfit(temp,v,1);
xt = 700:50:950;
fline = P(1)*xt+P(2);

MS = 7;
figure(1)
plot(temp,v,'*r','MarkerSize',MS)
hold on
plot(xt,fline,'--k')
xlim([700 950])
ylim([0.06 0.22])
xlabel('Temperature (K)')
ylabel('Velocity (angstrom/ps)')


%% Curvatures

latparam = 4.0982;
height = [latparam*60, latparam*80, latparam*80, latparam*90];
temp = 5:8;
time = 1000:100:1300;

n_grains = 4;
L_grain = zeros(n_grains);
fraction = zeros(n_grains);
for m = 1:n_grains
    for n = 1:n_grains
        filename = [num2str(temp(m)),'x_',num2str(time(n)),'.png'];
        I = imread(filename,"png");
        I = im2bw(I);
        % imshow(I)
        [r,c] = size(I);
        center = round(c/2);
        for i = 1:r
            s = sum(I(i:i+9,center),'all');
            if s == 10
                break
            end
        end
        L = r-i;
        fraction(n,m) = L/r;
        L_grain(n,m) = fraction(n,m)*height(m);
    end
end

dx = diff(L_grain);
t = diff(time).'; 

v = zeros(3,4);
for i = 1:4
    v(:,i) = -1*(dx(:,i)./t);
end
v = mean(v,1);

% fit line
rc = temp*latparam;
P = polyfit(rc,v,1);
xt = 4:9;
xt = latparam*xt;
fline = P(1)*xt+P(2);

MS = 7;
figure(2)
plot(rc,v,'*r','MarkerSize',MS)
hold on
plot(xt,fline,'--k')
xlim([min(xt) max(xt)])
ylim([0.01 0.09])
xlabel('Radius of Curvature')
ylabel('Velocity (angstrom/ps)')













