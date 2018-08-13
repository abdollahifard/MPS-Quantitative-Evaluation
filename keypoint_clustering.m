function L=keypoint_clustering(P,V,E,th)
% given a set of keypoints, P, and their translation vectors, V, and the
%   edges of the triangulation of points, E, the function computes the
%   difference between translation vectors of endpoints of each edge and if
%   the length of the difference vector is higher than a threshold, th, the
%   edge is removed. 
%   Finally the connected components of the remiaining graph is formed and
%   keypoints of each component are given separate labels. all labels are
%   returned in L
% th is assumed to be 1/20 to 1/10 of max(size(im))


dV = V(E(:,1),:)-V(E(:,2),:);
dV_len = sqrt(sum(dV.^2,2));
ind = find(dV_len>th);
   E1=E(ind,:);
E(ind,:) = [];
G = graph(E(:,1),E(:,2));
L = conncomp(G);
mL=max(L);
L(end+1:size(P,1))=mL+1:mL+size(P,1)-length(L);




% imshow(re)
% hold on
% for i=1:size(E,1)
%     line(P(E(i,:),2),P(E(i,:),1));
% end
% for i=1:size(E1,1)
%     line(P(E1(i,:),2),P(E1(i,:),1),'Color',[0,1,0]);
% end
% 
