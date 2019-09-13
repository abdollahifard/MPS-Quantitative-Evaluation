function ci = innovation_measure_2d(ti,Y)

%parameters:
    %default values: alpha=0.8, tdk=max(s)/30, tdes=0.2
alpha=0.8;% maximim fraction of keypoints to be removed,
s=size(Y);s=s([1,2]);
tdk=max(s)/30;% threshold on spatial distance between keypoints
tdes = 0.3;

% keypoint detection and description:
[~, descriptors_ti, locs_ti] = sift(ti);

for i=1:size(Y,3)
    i
    re=Y(:,:,i);
    [~, descriptors_re, locs_re] = sift(re);
    % keypoint matching, removing bad matches, rearranging ti keypoints in
    %     accordance with realization keypoints,
    [Q,P] = mymatch(descriptors_ti,locs_ti,...
        descriptors_re,locs_re,alpha,tdes);
    
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
    
    L=keypoint_clustering(P,V,E,tdk);
    
    % labeling all pixels in the re
    imL=imlabel(P,L,re);
    
    % extracting edges between different regions:
    [B1,B2] = labeledges(imL);
    
    % illustration of segmentation results:
    re1=re;re2=re;
    re1(B1)=0;re2(B1)=255;
    Re=cat(3,re2,re1,re1);
    N=size(P,1);
    ci(i) = segments2innovation(imL,N);
end
