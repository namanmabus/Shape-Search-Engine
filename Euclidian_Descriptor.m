function [Edis] = Euclidian_Descriptor(input_file)
% Input is the path of the input file
% Output is the Histogram based Euclidean Descriptor

fid=fopen(input_file); % Open the 3D shape file
fgetl(fid); %Read the first line and remove new line characters
nos=fscanf(fid, '%d %d %d',[3 1]); % Read the line to get the number of vertices and number of Triangles
nopts=nos(1); % Number of vertices

coord=fscanf(fid, '%g %g %g',[3 nopts]); % Scan and store all the vertices in coord
coord=coord'; % Transpose

fclose(fid); % Close the file

Edist= Euclidean_distance(coord,coord); % Calculate the euclidean distance between i and j coordinate and store it in the ijth element of the matrix Edist
Edist1=reshape(Edist,nopts*nopts,1); % Reshape Edist to a vector
Edis=hist(Edist1,400); % Generate the histogram based on the frequency of distances
Edis=Edis./sum(Edis); % Normalise the histogram

end

