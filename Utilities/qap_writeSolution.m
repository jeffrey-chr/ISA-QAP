function qap_writeSolution(filename,val,perm)
%QAP_WRITESOLUTION Summary of this function goes here
%   Detailed explanation goes here

    n = length(perm);
    colwidth = 2 + floor(log10(n)+1);

    if isempty(filename)
        fileID = 1;
    else
        fileID = fopen(filename,'w');
    end

    fprintf(fileID,"  %d  %d\n", n, val);
    remaining = n;
    i = 1;
    while remaining > 0
        next = min(20, remaining);
        remaining = remaining - next;
        while next > 0
            next = next - 1;
            numwidth = floor(log10(perm(i))+1);
            spaces = string(repmat(' ',1,colwidth-numwidth));
            fprintf(fileID,"%s%d",spaces,perm(i));
            i = i + 1;
        end
        fprintf(fileID,"\n");
    end

    if ~isempty(filename)
        fclose(fileID);
    end

end

