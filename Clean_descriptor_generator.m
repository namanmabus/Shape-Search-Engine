clc;
clear all;

path='C:/Users/Dishant/Documents/3D Computer Vision/Project 2 Submission/smallTOSCA/';
shapes={'cat','centaur','david','dog','gorilla','horse','lioness','michael','seahorse','victoria','wolf'};
numberofshapes=[11,6,15,11,21,19,17,20,6,26,3];
k=1;
for i=1:1:size((shapes),2)
    for j=1:1:numberofshapes(i)
            if i==1 && j==7
                j=8;
                continue
            end
            if i==1 && j==10
                j=11;
                continue
            end
            if i==6 && j==2
                j=3;
                continue
            end
            if i==6 && j==12
                j=13;
                continue
            end
            if i==7 && j==12
                j=13;
                continue
            end
            if i==7 && j==10
                j=11;
                continue
            end
            if i==10 && j==9
                j=10;
                continue
            end
            if i==10 && j==16
                j=17;
                continue
            end
            inputfile=sprintf('%s%s%d.off',path,shapes{i},j-1);
            
            ED= Euclidian_Descriptor(inputfile);
            GD= Geodesic_Descriptor(inputfile,2);
            AD= Angle_descriptor(inputfile);
            EDMAT_clean(k,:)=ED;
            GDMAT_clean(k,:)=GD;
            ADMAT_clean(k,:)=AD;
            
            k=k+1;
    end
end
