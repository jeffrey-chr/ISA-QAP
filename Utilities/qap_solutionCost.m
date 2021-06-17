% Given a distance, flow and permutation matrix (the solution) this returns the cost of that solution. 
function r_solCost = qap_solutionCost(dist, flow, perm)

% dist is an asymmetric distance matrix. 
% Each element distance from location_row to location_col.

% flow is an asymmetric flow matrix. 
% Each Element is the flow from factory_row to factor_col as read across the row.

% perm is the permutation matrix. It is the result of row swaps on the identity matrix.
% Each occurrence of a 1 means place factory_col at location_row.

flow = perm*flow*(perm');
cost = sum(sum(dist.*flow));

% Test code to validate above. This is much slower than the simple matrix ops above.
% It is much easier to see that the below code is correct.
%quickCost = cost;
%cost = 0;
%n = size(dist,1);
%for fac = 1: n
%	loc = find(perm(:,fac),1); % finds the first non-0 element along colum fac
%	for otherFac = 1: n
%		otherLoc = find(perm(:,otherFac),1);
%		cost = cost + dist(otherLoc,loc)*flow(otherLoc,loc);
%	end
%end
% End test

r_solCost = cost;

end