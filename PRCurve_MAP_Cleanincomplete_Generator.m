
clc;
clear all;

load('EDMAT_cleanincomplete.mat');
load('shapeindexnoise.mat');

numberofshapes=size(EDMAT_cleanincomplete,1);
Adist=zeros(numberofshapes,numberofshapes);
sortEdist=zeros(numberofshapes,numberofshapes);
index=zeros(numberofshapes,numberofshapes);

for i=1:1:numberofshapes
    for j=1:1:numberofshapes
        Adist(i,j)=Euclidean_distance(EDMAT_cleanincomplete(i,:),EDMAT_cleanincomplete(j,:));
    end
    [sortEdist(i,:),index(i,:)]=sort(Adist(i,:));
end

retrieval=cell(numberofshapes,numberofshapes);

for i=1:1:numberofshapes
    for j=1:1:numberofshapes
retrieval{i,j}=shapeindexnoise{index(i,j)};
    end
end


k=0;
avpre=(zeros(numberofshapes));
for i=1:1:numberofshapes
    for j=1:1:(numberofshapes-1)
    if(strcmp(retrieval(i,1),retrieval(i,j+1)))
        k=k+1;
        avpre(i)=avpre(i)+(k/j);
    end
    pre(i,j)=k/j;
    rec(i,j)=k/(sum(ismember(shapeindexnoise,retrieval(i,1)))-1);
    end
    avpre(i)=avpre(i)/k;
    k=0;
end

map=mean(avpre);
for i=1:1:numberofshapes-1
    mepre(i)=mean(pre(:,i));
    merec(i)=mean(rec(:,i));
end
fprintf('Mean Average Precision for clean and incomplete dataset with Euclidean descriptor: %g\n',map(1));
plot(merec,mepre,'linewidth',2)

hold on;

load('GDMAT_cleanincomplete.mat');
load('shapeindexnoise.mat');


numberofshapes=size(GDMAT_cleanincomplete,1);
Gdist=zeros(numberofshapes,numberofshapes);
sortGdist=zeros(numberofshapes,numberofshapes);
index=zeros(numberofshapes,numberofshapes);

for i=1:1:numberofshapes
    for j=1:1:numberofshapes
        Gdist(i,j)=Euclidean_distance(GDMAT_cleanincomplete(i,:),GDMAT_cleanincomplete(j,:));
    end
    
    [sortGdist(i,:),index(i,:)]=sort(Gdist(i,:));
end
retrieval=cell(numberofshapes,numberofshapes);
for i=1:1:numberofshapes
    for j=1:1:numberofshapes
retrieval{i,j}=shapeindexnoise{index(i,j)};
    end
end


k=0;
avpre=(zeros(numberofshapes));
for i=1:1:numberofshapes
    for j=1:1:(numberofshapes-1)
    if(strcmp(retrieval(i,1),retrieval(i,j+1)))
        k=k+1;
        avpre(i)=avpre(i)+(k/j);
    end
    pre(i,j)=k/j;
    rec(i,j)=k/(sum(ismember(shapeindexnoise,retrieval(i,1)))-1);
    end
    avpre(i)=avpre(i)/k;
    k=0;
end

map=mean(avpre);
for i=1:1:numberofshapes-1
    mepre(i)=mean(pre(:,i));
    merec(i)=mean(rec(:,i));
end
fprintf('Mean Average Precision for clean and incomplete dataset with Geodesic Descriptor: %g\n',map(1));
plot(merec,mepre,'r','linewidth',2)
xlabel('Recall');
ylabel('Precision');

hold on;

load('ADMAT_cleanincomplete.mat');
load('shapeindexnoise.mat');

numberofshapes=size(ADMAT_cleanincomplete,1);
Adist=zeros(numberofshapes,numberofshapes);
sortEdist=zeros(numberofshapes,numberofshapes);
index=zeros(numberofshapes,numberofshapes);

for i=1:1:numberofshapes
    for j=1:1:numberofshapes
        Adist(i,j)=Euclidean_distance(ADMAT_cleanincomplete(i,:),ADMAT_cleanincomplete(j,:));
    end
    [sortEdist(i,:),index(i,:)]=sort(Adist(i,:));
end

retrieval=cell(numberofshapes,numberofshapes);

for i=1:1:numberofshapes
    for j=1:1:numberofshapes
retrieval{i,j}=shapeindexnoise{index(i,j)};
    end
end


k=0;
avpre=(zeros(numberofshapes));
for i=1:1:numberofshapes
    for j=1:1:(numberofshapes-1)
    if(strcmp(retrieval(i,1),retrieval(i,j+1)))
        k=k+1;
        avpre(i)=avpre(i)+(k/j);
    end
    pre(i,j)=k/j;
    rec(i,j)=k/(sum(ismember(shapeindexnoise,retrieval(i,1)))-1);
    end
    avpre(i)=avpre(i)/k;
    k=0;
end

map=mean(avpre);
for i=1:1:numberofshapes-1
    mepre(i)=mean(pre(:,i));
    merec(i)=mean(rec(:,i));
end
fprintf('Mean Average Precision for clean and incomplete dataset with Angle descriptor: %g\n',map(1));
plot(merec,mepre,'g','linewidth',2)
