% Given a distance, flow and permutation vector (the solution) this returns the cost of that solution. 
function r_solCost = qap_solutionCostVec(dist, flow, permvec)

n = length(permvec);
permmat = zeros(n);
for i = 1:n
    permmat(i,permvec(i)) = 1;
end

r_solCost = qap_solutionCost(dist,flow,permmat);

end