function qap_writeFile(filename,dist,flow)
%QAP_WRITEFILE Writes QAP instance to file.

n = size(dist,1);

fid = fopen(filename,'w');

% Finds the maximum width required for each matrix column
% in the data file to make everything align nicely.
digits = floor(max(max(log10(dist(:))),max(log10(flow(:)))))+1;

fprintf(fid,"%d\n\n",n);

for i = 1:n
    for j = 1:n
        fprintf(fid,strcat("%",num2str(digits),"d  "),dist(i,j));
    end
    fprintf(fid,"\n");
end

fprintf(fid,"\n");

for i = 1:n
    for j = 1:n
        fprintf(fid,strcat("%",num2str(digits),"d  "),flow(i,j));
    end
    fprintf(fid,"\n");
end

fclose(fid);

end

