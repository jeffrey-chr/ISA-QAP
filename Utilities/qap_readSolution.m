function [val,perm] = qap_readSolution(filename)
% qap_readFile Reads a QAP solution from a file.
% Solutions are assumed to be of the form:
% n val
% perm
% where perm is a vector of length n, possibly spread over multiple lines, 
% representing the solution permutation.
fid = fopen(filename);
[A,count] = fscanf(fid,'%d');
fclose(fid);

n = A(1);
if (count ~= n+2) 
    error(strcat("invalid slnfile ",filename));
end

val = A(2);
perm = A(3:end);
if any(perm == 0) % a few solution files start at 0 instead.
    perm = perm + 1;
end

end

