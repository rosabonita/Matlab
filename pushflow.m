function [ FlowGraph ] = pushflow( CapGraph, s, t )

n=length(CapGraph); %number of nodes


ResGraph=CapGraph; %residual graph
FlowGraph=zeros(n);%current temporary flow 
DistGraph=spones(transpose(CapGraph));
[dist]=graphshortestpath(DistGraph,t);%initializes distances
FlowAt=zeros(n,1); %shows amount of flowing liquid at each node

s_neighbors=find(ResGraph(s,:)); %this paragraph saturates edges out of s
ResGraph(s_neighbors,s)=CapGraph(s,s_neighbors);
ResGraph(s,s_neighbors)=0;
FlowGraph(s,s_neighbors)=CapGraph(s,s_neighbors);
FlowAt(s_neighbors)=CapGraph(s,s_neighbors);
dist(s)=n;

temp_s=FlowAt(s); %this paragraph finds an active node
temp_t=FlowAt(t);
FlowAt(s)=0;
FlowAt(t)=0;
max_active=max(FlowAt);
index_max_active=find(FlowAt==max_active,1);
FlowAt(s)=temp_s;
FlowAt(t)=temp_t;

while max_active > 0
    max_neighbors=find(ResGraph(index_max_active,:));
    recipient=0;
    min_distance=inf;
    for i = 1:length(max_neighbors) %for loop checks for an admissible edge.
        if dist(max_neighbors(i))==dist(index_max_active)-1
            recipient=max_neighbors(i);   
        end
        if dist(max_neighbors(i))<min_distance
            min_distance=dist(max_neighbors(i));
        end
    end
    if recipient==0  %if there is no admissible edge, update active node's distance,
        dist(index_max_active)=min_distance+1;
    else
                     %otherwise push flow along admissible edge.
    push=min(FlowAt(index_max_active),ResGraph(index_max_active,recipient));
    FlowAt(index_max_active)=FlowAt(index_max_active)-push;
    FlowAt(recipient)=FlowAt(recipient)+push;
    ResGraph(index_max_active,recipient)=ResGraph(index_max_active,recipient)-push;
    ResGraph(recipient,index_max_active)=ResGraph(recipient,index_max_active)+push;
    
    backflow=FlowGraph(recipient,index_max_active);
    FlowGraph(recipient,index_max_active)=backflow-min(backflow,push);
    FlowGraph(index_max_active,recipient)=FlowGraph(index_max_active,recipient)+max(0,push-backflow);
    end
temp_s=FlowAt(s); %Look for a new active node.
temp_t=FlowAt(t);
FlowAt(s)=0;
FlowAt(t)=0;
max_active=max(FlowAt);
index_max_active=find(FlowAt==max_active,1);
FlowAt(s)=temp_s;
FlowAt(t)=temp_t;

end






end

