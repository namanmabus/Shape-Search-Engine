function [angledis] = Angle_descriptor(input_file)
fid=fopen(input_file); % Open the 3D shape file
fgetl(fid); %Read the first line and remove new line characters
nos=fscanf(fid, '%d %d %d',[3 1]); % Read the line to get the number of vertices and number of Triangles
nopts=nos(1); % Number of vertices

coord=fscanf(fid, '%g %g %g',[3 nopts]); % Scan and store all the vertices in coord
coord=coord';
fclose(fid); % Close the file

centroid=mean(coord);
centroid=centroid';
coord=coord';
angledist=zeros(nopts,1);
for i=1:1:nopts
    angledist(i,1)= atan2(norm(cross(coord(:,i),centroid(:,1))),dot(coord(:,i),centroid(:,1)));
end

angledis=hist(angledist,400);
angledis=angledis./sum(angledis);

end
