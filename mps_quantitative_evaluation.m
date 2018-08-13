function [ci,cc,c]=mps_quantitative_evaluation(ti,Y)
% this function compares th realizations in Y with ti and returns there innovation factor, ci, 
%    their consistecny factor, cc, and their product c=ci*cc
mm(1)=min(ti(:));
mm(2)=max(ti(:));
if mm<100
    ti=255/diff(mm)*(double(ti)-mm(1));
    Y=255/diff(mm)*(double(Y)-mm(1));
end


alpha=0.8;% maximim fraction of keypoints to be removed,

% keypoint detection and description:
[~, descriptors_ti, locs_ti] = sift(ti);


% LBP of TI:
[~,Hti8,~,~]=myLBP8(ti);
[~,Hti12,~,~]=myLBP12(ti);
[~,Hti16,~,~]=myLBP16(ti);


for i=1:size(Y,3)
    re=Y(:,:,i);
    [~, descriptors_re, locs_re] = sift(re);
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
    
    % illustration of segmentation results:
    re1=re;re2=re;
    re1(B1)=0;re2(B1)=255;
    Re=cat(3,re2,re1,re1);
    subplot(1,2,1)
    imshow(uint8(re))
    subplot(1,2,2);
    imshow(uint8(Re))
    
    
    
    % creativity measure
    N=size(P,1);
    ci(i) = creativity_measure(imL,N);
    
    
    
    % anomaly detection
%     [Defmap,Defm,Hre]=anomaly_detection(re,Hti,B1,0.02, 0, 'LBP8');
%     con1(i) = 1-Defm;
%     DefmapE=edge(Defmap);
%     re1=re;
%     re2=re;
%     re1(DefmapE)=255;
%     re2(DefmapE)=0;
%     subplot(1,3,3);
%     imshow(uint8(cat(3,re1,re2,re2)))

    [~,Hre8,~,~]=myLBP8(re);
    [~,Hre12,~,~]=myLBP12(re);
    [~,Hre16,~,~]=myLBP16(re);
    d1(i)=JS_divergence(Hti8(:) , Hre8(:));
    d2(i)=JS_divergence(Hti12(:),Hre12(:));
    d3(i)=JS_divergence(Hti16(:),Hre16(:));
    d(i)=(d1(i)+d2(i)+d3(i))/3;
    cc(i) =max(1- 5*d(i),0);
    
end
c=cc.*ci;
