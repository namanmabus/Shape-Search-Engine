function [Gdis] = Geodesic_Descriptor(input_file,option)

fid=fopen(input_file);  %Open the input file
fgetl(fid);             %Read the first line and remove \n in the files
nos=fscanf(fid, '%d %d %d',[3 1]); %Scan the second line for getting the number of vertices, triangles and connections

nopts=nos(1); %Number of points
notrg=nos(2); %Number of triangles

coord=fscanf(fid, '%g %g %g',[3 nopts]); %Store all the vertices in coord
coord=coord';

triang=fscanf(fid, '%d %d %d %d',[4 notrg]); %Store all the points that form triangle in triang
triang=triang';
triang=triang(:,2:4)+1; %Only have the triangle points in triang and adjust the bias

fclose(fid); %Close the file
Edist= Euclidean_distance(coord,coord); %Calculate the Euclidean distance between each vertex

switch option      %Dijkstra, Johnson's algorithm
    case 1            
        G=inf(nopts,nopts);  %Initialize the distance matrix to infinity
        
        for i=1:notrg  %If the vertices form a triangle, then store the euclidean distance between them in G and update G
    p1=triang(i,1);
    p2=triang(i,2);
    p3=triang(i,3);
    G(p1,p2)= Edist(p1,p2);
    G(p2,p1)= Edist(p2,p1);
    G(p1,p3)= Edist(p1,p3);
    G(p3,p1)= Edist(p3,p1);
    G(p2,p3)= Edist(p2,p3);
    G(p3,p2)= Edist(p3,p2);
        end
        
        Gdist=zeros(nopts,nopts); %Initialize Geodesic distance matrix

        for i=1:nopts %Applt the shortest path algorithm for all the vertices
            Gdist(i,:)=shortest(G,i);
        end
        
    case 2  %Matlab Johnson's algorithm
        G=sparse(nopts,nopts);  %Initialize a sparse matrix G
        
        for i=1:notrg %If the vertices form a triangle, then store the euclidean distance between them in G and update G
    p1=triang(i,1);
    p2=triang(i,2);
    p3=triang(i,3);
    G(p1,p2)= Edist(p1,p2);
    G(p2,p1)= Edist(p2,p1);
    G(p1,p3)= Edist(p1,p3);
    G(p3,p1)= Edist(p3,p1);
    G(p2,p3)= Edist(p2,p3);
    G(p3,p2)= Edist(p3,p2);
        end
        
       Gdist= graphallshortestpaths(G); %Caluclates the shortest path for all vertices.

end


Gdist1=reshape(Gdist,nopts*nopts,1); %Reshape the Geodesic distance matrix to have only one column
Gdis=hist(Gdist1,400); %Take a histogram for the frequency of distances 
Gdis=Gdis./sum(Gdis); %Normalize the histogram

end

