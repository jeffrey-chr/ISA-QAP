function processAlgorithmOutput(inputDir,outputDir)
%READALGORITHMOUTPUT Summary of this function goes here
%   Detailed explanation goes here
    
    algnames = ["BMA","MMAS"];
    
    flist = dir(inputDir);
    
    instsize=-ones(1,length(flist)-2);
    runtime=-ones(1,length(flist)-2);
    algorithm=cell(1,length(flist)-2);
    solutions=-ones(1,length(flist)-2);
    instname=cell(1,length(flist)-2);
    alltrials=cell(1,length(flist)-2);
    alltimes=cell(1,length(flist)-2);
    
    for i = 3:length(flist)
    
        algorithm{i-2} = 'none';

        fileID = fopen(strcat(inputDir,flist(i).name),'r');

        tline = fgetl(fileID);

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
                runtime(i-2)=str2double(tline);
            end
            if strcmp(tline,'INSTANCESIZE:')
                tline = fgetl(fileID);
                instsize(i-2)=str2num(tline);
            end
            if strcmp(tline,'AVERAGESOLN:')
                tline = fgetl(fileID);
                solutions(i-2)=str2num(tline);
            end
            if strcmp(tline,'TRIALS:')
                tline = fgetl(fileID);
                alltrials{i-2} = [];
                while ~strcmp(tline,'TRIALSEND')
                    tok = strsplit(tline, ',');
                    alltrials{i-2}(end+1) = str2num(tok{2});
                    alltimes{i-2}(end+1) = str2num(extractBefore(tok{4},'s'));
                    tline = fgetl(fileID);
                end
            end
            
            if length(tline) >= 9 && strcmp(tline(1:9),'ABORTING:')
                runtime(i-2)=0;
                solutions(i-2)=0;
            end

            tline = fgetl(fileID);
        end

        fclose(fileID);

        % check to see if we need to calculate these manually
        if runtime(i-2) == -1
            runtime(i-2) = sum(alltimes{i-2})/length(alltimes{i-2});
        end
        if solutions(i-2) == -1
            solutions(i-2) = sum(alltrials{i-2})/length(alltrials{i-2});
        end

    end
    
    outtables = cell(length(algnames),1);
    
    for i = 1:length(algnames)
        outtables{i} = cell(1,5);
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
                outtables{j}{count(j),2} = solutions(i);
                outtables{j}{count(j),3} = runtime(i);
                outtables{j}{count(j),4} = instsize(i);
                outtables{j}{count(j),5} = alltrials{i};
                outtables{j}{count(j),6} = alltimes{i};
            end
        end
    end
    
    colnames = ["Name","AverageSoln","AvgRuntimeForBest","InstSize","AllTrials","AllTimes"];
    
    for i = 1:length(algnames)
        tble = cell2table(outtables{i},'VariableNames',colnames);
        writetable(tble,strcat(outputDir,algnames(i),"data.csv"));
    end
end

