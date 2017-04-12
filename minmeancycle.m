function [mu] = minmeancycle( FlowGraph, CostGraph)

n = length(FlowGraph) + 1; %The number of nodes + 1
disp(n);
ResidGraph = FlowGraph;
Cost = CostGraph;

s = n; %create a source node
k = 1; %initialize k, note the starting index is 0 in the algorithm
d(k,1:n) = inf;  %initialize all other distances to infinity  

ResidGraph(s,:) = 1; %add arcs from s to all nodes
ResidGraph(:,s) = 1; %add arcs from all nodes to s
Cost(s,:) = 0; %cost of new arcs is 0
Cost(:,s) = 0; %cost of new arcs is 0
disp(ResidGraph); %check resid matrix
disp(Cost); % check cost matrix
d(k,s) = 0; %Set 's' as source node(distance to 's' to 0)
pred(k,1:n) = 0; %Initialize all Predecessors to 0
k = 2;
while k <= n
d(k,1:n) = inf;  %initialize all other distances to infinity  
    for j = 1:n
        for i = 1:n
            if ResidGraph(i,j)== 1
               if d(k-1,i) + Cost(i,j) < d(k,j) 
                   d(k,j) = d(k-1,i) + Cost(i,j);
                   pred(k,1:n) = i;
               end
            end
        end
    end
    k = k+1;
end
disp(d);
v = min(d,[],1);

for k = 1:n
    for j = 1:n
        w(k,j) = (d(k,j) - v(j))/(n-k);
    end
end

[l, m] = min(w,[],1);
mu = -max(l);

disp(pred);
disp(v);
disp(w);
disp(l);
disp(mu);
disp(find(pred(m)));
