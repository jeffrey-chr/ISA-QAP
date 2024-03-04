function replaceAlgorithmOutput(infile1,infile2,outfile)
%REPLACEALGORITHMOUTPUT Summary of this function goes here
%   Detailed explanation goes here
    T1 = sortrows(readtable(infile1));
    T2 = sortrows(readtable(infile2));

   T3 = T1;

   count = 0;
   count2 = 0;

   for i = 1:length(T2.Name)
       found = false;
       for j = 1:length(T1.Name)
           newname = T2.Name{i};
           oldname = T1.Name{j};

            %temporary kludge
            if strcmp(newname(1:4),"xtab") == 1
                newname = newname(1:end-1);
                oldname = oldname(1:end-1);
            end

           if strcmp(oldname, newname)
               found = true;
               T3(j,:) = T2(i,:);
               count = count + 1;
               fprintf("Replacing %s with %s, total %d\n", T1.Name{j}, T2.Name{i}, count)
           end
       end
       if ~found
           T3(end+1,:) = T2(i,:);
           count2 = count2 + 1;
           fprintf("Adding %s, total %d\n", T2.Name{i}, count2)
           
       end
   end

   fprintf("Total count: %d, %d\n", count, count2)

   writetable(T3,outfile);
end

