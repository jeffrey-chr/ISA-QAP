function [dist, flow] = qap_readFile(filename)
% qap_readFile Reads a QAP instance from a file.
% Instances are assumed to be of the form:
% n
% A
% B
% where A and B are n x n matrices with columns separated
% by whitespace and a new line for each row. Multiple newlines
% may or may not separate the three components, and 

fid = fopen(filename);
tline = fgetl(fid);
n = str2num(strtrim(tline));
dist = zeros(n);
flow = zeros(n);
tline = fgetl(fid);
cells = regexp(strtrim(tline), '\s{1,}', 'split');

if size(cells,2) == 1
	cellNo = 2;
else
	cellNo = 1;
end

for i = 1:n
	for j = 1:n
		if cellNo > size(cells,2)
			tline = fgetl(fid);
			cells = regexp(strtrim(tline), '\s{1,}', 'split');
			cellNo = 1;
		end
		
		while size(strtrim(tline), 2) == 0
			tline = fgetl(fid);
			cells = regexp(strtrim(tline), '\s{1,}', 'split');
			cellNo = 1;
		end
		
		dist(i,j) = str2num(cells{1,cellNo});
		
		cellNo = cellNo + 1;
	end
end	

for i = 1:n
	for j = 1:n
		if cellNo > size(cells,2)
			tline = fgetl(fid);
			cells = regexp(strtrim(tline), '\s{1,}', 'split');
			cellNo = 1;
		end
		
		while size(strtrim(tline), 2) == 0
			tline = fgetl(fid);
			cells = regexp(strtrim(tline), '\s{1,}', 'split');
			cellNo = 1;
		end
		
		flow(i,j) = str2num(cells{1,cellNo});
		
		cellNo = cellNo + 1;
	end
end	

fclose(fid);