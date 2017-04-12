function [path, totalCost] = dijkstra(A, s, t)
% path: the list of nodes in the path from source to destination;
% totalCost: the total cost of the path;
% s: source node index;
% t: destination node index;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(A,1);
T = 1:n;

d(1:n) = inf;    
pred(1:n) = 0;

d(s) = 0;

while not(isempty(T)) 
     [dmin, ind] = min(d(T)); 
     i = T(ind(1)); % i is an index that attains the minimum d(j)-value (over all j in T)      
     T(ind(1))=[]; % i is removed from T
     for j = T         
         if ( ( A(i, j) + d(i)) < d(j) )
             d(j) = d(i) + A(i, j);  
             pred(j) = i;                                    
         end;             
     end;
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

return;
