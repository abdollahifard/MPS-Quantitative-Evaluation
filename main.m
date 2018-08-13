ti=imread('D:\Scientific\my_MATLAB_Toolboxes\Qavim\TI.jpg');
re=imread('D:\Scientific\my_MATLAB_Toolboxes\Qavim\simulationm2.jpg');
%re=imread('D:\Scientific\my_MATLAB_Toolboxes\Qavim\simulationm30.jpg');


alpha=0.8;% maximim fraction of keypoints to be removed,

% keypoint detection and description:
[~, descriptors_ti, locs_ti] = sift(ti);
[~, descriptors_re, locs_re] = sift(re);

% LBP of TI:
[~,Hti,~,~]=myLBP8(ti);

% keypoint matching, removing bad matches, rearranging ti keypoints in
%     accordance with realization keypoints,
[Q,P] = mymatch(descriptors_ti,locs_ti,...
    descriptors_re,locs_re,alpha);

% simply removing repeated keypoints:
[~,k]=unique(P(:,1:2),'rows');
Q = Q (k,:);
P = P (k,:);

% removing orientation and scale info from location vectors
Q = Q(:,1:2);
P = P(:,1:2);

% forming translation vectors:
V = Q-P;

% keypoint triangulation:
DT=delaunayTriangulation(P);
E=edges(DT);

% keypoint clustering:
tdk=max(size(re))/30;% threshold on spatial distance between keypoints
L=keypoint_clustering(P,V,E,tdk);

% labeling all pixels in the re
imL=imlabel(P,L,re);

% extracting edges between different regions:
[B1,B2] = labeledges(imL);
re1=re;re2=re;
re1(B1)=0;re2(B1)=255;
Re=cat(3,re2,re1,re1);
subplot(1,3,1)
imshow(uint8(re))
subplot(1,3,2);
imshow(Re)



% creativity measure
N=size(P,1);
cr = creativity_measure(imL,N)



% anomaly detection
[Defmap,Defm]=anomaly_detection(re,Hti,B1,0.02, 0, 'LBP8');
con = 1-Defm
DefmapE=edge(Defmap);
re1=re;
re2=re;
re1(DefmapE)=255;
re2(DefmapE)=0;
subplot(1,3,3);
imshow(cat(3,re1,re2,re2))

final_score = cr*.25+con*.75

