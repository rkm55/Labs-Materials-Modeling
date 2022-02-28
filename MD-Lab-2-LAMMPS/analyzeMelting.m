clear; clc; close all;
 
%% Analyze Melting
path(path,'C:\Users\Ryan Melander\Desktop\ME 556\Labs_ME556\MD-Lab-2-LAMMPS\xe-melting')
temperature_list= 130:5:180;

for i=1:length(temperature_list)-1
    %analyze the .log file
    T_target=temperature_list(i);
    inputFile=sprintf('output.%d.log',T_target);
    outputFile=sprintf('data.%d.txt',T_target);
    %the following command will only work on a Linux or Unix operating
    %system but cuts your file down to only the sampling data. You can do
    %this by hand if needed and skip this line.
    % system(['sed -e ''1,/StartSampling/ d'' -e ''/EndSampling/,$ d'' ',...
    %         inputFile,' > ',outputFile]);
    %import data into an array
    A = importdata(outputFile, ' ', 4);
    d=A.data;
    %set data into variables
    Step=d(:,1);
    Temp=d(:,2);
    E_pair=d(:,3);
    TotEng=d(:,4);
    Press=d(:,5);
    myMSD=d(:,6);
    myVACF=d(:,7);
    
    
    %calculate the average temperature
    
    %run other calculations to operate on the data (ave TotEng, MSD, VACF)
    
    %analyze the rdf file
    inputFile=sprintf('rdf.%d.out',T_target);
    outputFile=sprintf('rdfdata.%d.txt',T_target);
    system(['sed -e ''1,/75000 50/ d'' ',...
            inputFile,' > ',outputFile]);
    %import data into an array
    B = importdata(outputFile, ' ');
    
    %plot the RDF data
    
end

%plot temperature dependent values
