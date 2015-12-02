function [ Edist ] = Euclidean_distance(coord1,coord2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Edist=zeros(size(coord1,1),size(coord2,1)); %Initialize the Edist matrix to 0
for i=1:1:size(coord1,1) %For each vertex in Edist calculate the distance between that vertex and all other vertices
    for j=1:1:size(coord2,1)
        for k=1:1:size(coord1,2)
        Edist(i,j)=Edist(i,j)+((coord1(i,k)-coord2(j,k))*(coord1(i,k)-coord2(j,k)));
        end
        Edist(i,j)=sqrt(Edist(i,j));
    end
end

end

