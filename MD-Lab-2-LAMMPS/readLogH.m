function [ LogObj ] = readLogH( FileName )
%Thomas Hardin
%3/15/2014
%This will pick out the data tables and variables from a given log file
%If you want a variable to get picked out, use the syntax
%     %%variablename=var;
%in the log file.
%Data tables are located using the keyword "Step" which appears whenever
%the datatable's first column is step number.

try
    fid = fopen(FileName,'r');
catch
    error('Log file not found!');
end

if (fid<0)
    error('Log file not found!');
end

nTabs=0;
TableMode=false;
TableCols=-1;
TempTable=[];
while feof(fid) == 0
    line=fgetl(fid);
    %check for an error
    if (length(line)>=5 && strcmp(line(1:5),'ERROR'))
        LogObj.Error=true;
        LogObj.ErrorMsg=line;
    end
    
    %if we're currently reading a table
    if (TableMode)
        try
            DataLine=strsplit(line);
            DataLine(strcmp('',DataLine))=[];
            for i=1:length(Hdr)
                NumLine(i)=str2double(DataLine{i});
                if (isnan(NumLine(i)))
                   TableMode=false;
                   NumLine=[];
                   break;
                end
            end
            TempTable(end+1,:)=NumLine;
        catch
            TableMode=false;
        end
    end
    
    %if we're NOT currently reading a table
    if (~TableMode)
        %check for a table header
        if (length(line)>=4 && strcmp(line(1:4),'Step'))
            %activate table mode
            TableMode=true;
            nTabs=nTabs+1;
            %save the header
            Hdr=strsplit(line);
            Hdr(strcmp('',Hdr))=[];
            LogObj.Headers{nTabs}=Hdr;
            TempTable=zeros(0,length(Hdr));
        %check for a denoted variable
        elseif (length(line) > 2 && strcmp(line(1:2),'%%') && ~strcmp(line(3),'%'))
            line=strrep(line,'%%','');
            line=strrep(line,' ','');
            neq=strfind(line,'=');
            varname=line(1:(neq-1));
            varval=line((neq+1):length(line));
            evalme=['LogObj.' varname '=' varval ';'];
            eval(evalme);
        end
    end
    
    if (~isempty(TempTable) && ~TableMode)
        LogObj.Tables{nTabs}=TempTable;
        TempTable=[];
    end
end
fclose(fid);
end

