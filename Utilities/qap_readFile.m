function [dist, flow] = qap_readFile(filename)
% qap_readFile Reads a QAP instance from a file.
% Instances are assumed to be of the form:
% n
% A
% B
% where A and B are n x n matrices with columns separated
% by whitespace and a new line for each row. Multiple newlines
% may or may not separate the three components, and each line
% of the matrix may correspond to one or more lines in the file.
% We're just going to read all the numbers in order 
% and arrange them accordingly.

fid = fopen(filename);
[A,count] = fscanf(fid,'%d');
fclose(fid);

n = A(1);
if (count ~= 2*n^2 + 1) 
    error(strcat("invalid datafile ",filename));
end
dist = reshape(A(2:n^2+1),n,n)';
flow = reshape(A(n^2+2:2*n^2+1),n,n)';

end
