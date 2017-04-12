function [path, totalCost] = fifo(A, s, t)

% A: the cost matrix for the graph;
% path: the list of nodes in the path from source to destination;
% totalCost: the total cost of the path;
% s: source node index;
% t: destination node index;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(A,1);

d(1:n) = inf;  %Initialize all other distances to infinity;  
d(s) = 0; %Set 's' as source node(distance to 's' to 0);
pred(1:n) = 0; %Initialize all Predecessors to 0;
LIST = [s]; %List of marked nodes contains only 's''
count(1:n) = 0;

while not(isempty(LIST))
    i = LIST(1);
    if (count(i) > (2))
        display(['Negative cycle detected with node '  num2str(i)]);
        break;
    end;
    count(i) = count(i) + 1;
    for j = (1:n)
        if (d(j) > d(i) + A(i,j))
            d(j) = d(i) + A(i,j);
            pred(j) = i;
            if (ismember(j,LIST)==0)
                LIST(end+1) = j;
            end;
        end;
    end;
    LIST(1) = []; 
end;    


path = [];
if pred(t) ~= 0   % if there is a path!
    i = t;
    path = [t];
    while i ~= s
        p = pred(i);
        path = [p path];
        i = p;      
    end;
end;

totalCost = d(t);
display(d(t));
return;
