function p = processCalibrationOutput(inputDir)
%READALGORITHMOUTPUT Summary of this function goes here
%   Detailed explanation goes here
    
    algnames = ["BLS","BMA","MMAS"];
    
    flist = dir(inputDir);
    
    instsize=-ones(1,length(flist)-2);
    runtime=-ones(1,length(flist)-2);
    algorithm=cell(1,length(flist)-2);
    solutions=-ones(1,length(flist)-2);
    instname=cell(1,length(flist)-2);
    shortname=cell(1,length(flist)-2);
    sourcelist=cell(1,length(flist)-2);
    
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
            
            if length(tline) >= 9 && strcmp(tline(1:9),'ABORTING:')
                runtime(i-2)=0;
                solutions(i-2)=0;
            end

            tline = fgetl(fileID);
        end

        fclose(fileID);

    end
    
%     outtables = cell(length(algnames),1);
%     
%     for i = 1:length(algnames)
%         outtables{i} = cell(1,4);
%     end
%     
%     count = zeros(length(algnames),1);
%     
%     for i = 1:length(instname)
%         lastslashpos = find(instname{i} == '/', 1, 'last');
%         lastdotpos = find(instname{i} == '.', 1, 'last');
%         realname = instname{i}(lastslashpos+1:lastdotpos-1);
%         for j = 1:length(algnames)
%             if strcmp(algorithm{i},algnames(j))
%                 count(j) = count(j)+1;
%                 outtables{j}{count(j),1} = realname;
%                 outtables{j}{count(j),2} = solutions(i);
%                 outtables{j}{count(j),3} = runtime(i);
%                 outtables{j}{count(j),4} = instsize(i);
%             end
%         end
%     end
    
%     colnames = ["Name","AverageSoln","AvgRuntimeForBest","InstSize"];
%     
%     for i = 1:length(algnames)
%         tble = cell2table(outtables{i},'VariableNames',colnames);
%         writetable(tble,strcat(outputDir,algnames(i),"data.csv"));
%     end
    instsize = instsize - 25;
    runtime = max(runtime, 1);

    [~, ~, libsource] = qap_DefineSources();
    for i=3:length(flist)
        tmp = split(instname{i-2},'/');
        tmp2 = tmp{end};
        tmp3 = split(tmp2,'.');
        shortname{i-2} = tmp3{1};
        alphaonly = shortname{i-2}(isstrprop(shortname{i-2},'alpha'));

        found = 0;
        for s = 1:size(libsource,1)
            if ~isempty(regexp(alphaonly,libsource(s,2),'ONCE'))
                if found > 0
                    error('Regex clash')
                else
                    found = s;
                end
            end
        end
        if found > 0
            sourcelist{i-2} = libsource(found,1);
        else
            sourcelist{i-2} = "None";
        end
    end
    sourcelist = cellstr(sourcelist);

    qaplibindex = find(contains(sourcelist,"QAPLIB"));

    figure
    scatter(instsize, runtime)
    p2 = polyfit(instsize, runtime, 2);
    p3 = polyfit(instsize, runtime, 3);
    p4 = polyfit(instsize, runtime, 4);
    p5 = polyfit(instsize, runtime, 5);
    hold on
    x1 = linspace(0,175);
    y2 = polyval(p2,x1);
    plot(x1,y2)
    y3 = polyval(p3,x1);
    plot(x1,y3)
%     y4 = polyval(p4,x1);
%     plot(x1,y4)
%     y5 = polyval(p5,x1);
%     plot(x1,y5)
    scatter(instsize(qaplibindex),runtime(qaplibindex),'red','x')
    hold off
    
    p = {p2, p3, p4, p5};

end

