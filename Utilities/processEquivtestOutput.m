function processEquivtestOutput(inputDir,outputDir)
%READALGORITHMOUTPUT Summary of this function goes here
%   Detailed explanation goes here
    
    algnames = ["BMA","MMAS"];
    
    flist = dir(inputDir);
    
    instsize=-ones(1,length(flist)-2);
    runtime=-ones(1,length(flist)-2);
    algorithm=cell(1,length(flist)-2);
    solutions=-ones(1,length(flist)-2);
    instname=cell(1,length(flist)-2);
    variant=cell(1,length(flist)-2);
    
    allruntimes=cell(1,length(flist)-2);
    allsolutions=cell(1,length(flist)-2);
    
    for i = 3:length(flist)
    
        algorithm{i-2} = 'none';

        fileID = fopen(strcat(inputDir,flist(i).name),'r');

        tline = fgetl(fileID);

        variant{i-2} = extractBetween(flist(i).name,'#','.out');
        
        while ischar(tline)
            %disp(tline)
            if strcmp(tline,'ALGORITHMNAME:')
                algorithm{i-2} = strtrim(fgetl(fileID));
            end
            if strcmp(tline,'INSTANCENAME:')
                instname{i-2} = strtrim(fgetl(fileID));
            end
            if strcmp(tline,'AVERAGETIMEFORBEST:')
                tline = fgetl(fileID);
                %runtime(i-2)=str2double(tline);
            end
            if strcmp(tline,'INSTANCESIZE:')
                tline = fgetl(fileID);
                instsize(i-2)=str2num(tline);
            end
            if strcmp(tline,'ADJUSTEDSOLN:')
                tline = fgetl(fileID);
                %solutions(i-2)=str2num(tline);
            end
            if strcmp(tline,'TRIALS:')
                allruntimes{i-2} = -ones(50,1);
                allsolutions{i-2} = -ones(50,1);
                tcount = 0;
                tline = fgetl(fileID);
                foundend = false;
                if strcmp(tline,'TRIALSEND')
                    foundend = true;
                end
                while (~foundend)
                    if startsWith(tline,'Trial')
                        tcount = tcount + 1;
                        data = strsplit(tline,',');
                        allsolutions{i-2}(tcount) = str2double(data{3});
                        allruntimes{i-2}(tcount) = str2double(data{4}(1:end-1));
                    end
                    tline = fgetl(fileID);
                    if strcmp(tline,'TRIALSEND')
                        foundend = true;
                    end
                end
                allruntimes{i-2} = allruntimes{i-2}(1:tcount);
                allsolutions{i-2} = allsolutions{i-2}(1:tcount);
                runtime(i-2) = mean(allruntimes{i-2});
                solutions(i-2) = mean(allsolutions{i-2});
            end
            
            

            if length(tline) >= 9 && strcmp(tline(1:9),'ABORTING:')
                runtime(i-2)=0;
                solutions(i-2)=0;
            end

            tline = fgetl(fileID);
        end

        fclose(fileID);

    end
    
    outtables = cell(length(algnames),1);
    
    for i = 1:length(algnames)
        outtables{i} = cell(1,4);
    end
    
    count = zeros(length(algnames),1);
    
    for i = 1:length(instname)
        lastslashpos = find(instname{i} == '/', 1, 'last');
        lastdotpos = find(instname{i} == '.', 1, 'last');
        realname = instname{i}(lastslashpos+1:lastdotpos-1);
        for j = 1:length(algnames)
            if strcmp(algorithm{i},algnames(j))
                count(j) = count(j)+1;
                outtables{j}{count(j),1} = realname;
                outtables{j}{count(j),2} = variant(i);
                outtables{j}{count(j),3} = solutions(i);
                outtables{j}{count(j),4} = std(allsolutions{i});
                outtables{j}{count(j),5} = runtime(i);
                outtables{j}{count(j),6} = std(allruntimes{i});
                outtables{j}{count(j),7} = instsize(i);
            end
        end
    end
    
    colnames = ["Name","Variant","AverageSoln","StDevSoln","AvgRuntimeForBest","StDevRuntimeForBest","InstSize"];
    
    for i = 1:length(algnames)
        tble = cell2table(outtables{i},'VariableNames',colnames);
        writetable(tble,strcat(outputDir,algnames(i),"data.csv"));
    end
end

