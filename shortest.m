function [Gdist]=shortest(geodesic,source)

sizeG=size(geodesic,1); % Total number of nodes


Gdist=inf.*ones(1,sizeG); % Initialize distances to all the nodes to 0
Gdist(1,source)=0;  % The distance to the source node is 0


visited_nodes=zeros(1,sizeG);  % Vector Containing visited nodes
visited_nodes(1,source)=1;  % Source node is visited so 1



j=0;

while length(find(visited_nodes==1))<sizeG  %while all the nodes are not visited
     for i=1:sizeG  % Pass through all the nodes
         if visited_nodes(i)==0  %Check if the node is visited
             Gdist(i)=min(Gdist(i),Gdist(source)+geodesic(source,i)); %If not visited update gdist to the minimum of Gdist and sum of Geodesic distance from source to i and the Gdist of the source 
         end
     end
     tempdist=inf; %Initialize the distance to infinity
     for i=1:sizeG
         if visited_nodes(i)==0&&Gdist(i)<tempdist %If the node is not visited and the Geodesic distance is less than the tempdist than update temp dist.
             tempdist=Gdist(i);
         end
     end
     minindex=find(Gdist==tempdist); %Find the index of the node with the minimum distance
     source=minindex(1,1); % Make that the new source 
     visited_nodes(1,source)=1; % Update all the visited nodes from the source
     j=j+1; %Run the loop untill there is no change in weights
     if j>3500
        break;
     end
end