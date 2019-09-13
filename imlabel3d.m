function imL=imlabel3d(P,L,im)
% given keypoints, P, of the image, im, and their Labels, L, the function
%    returns a label image, imL, with all pixels labeled according to its
%    nearest keypoint. 
x=1:size(im,1);
y=1:size(im,2);
z=1:size(im,3);
[y,x,z]=meshgrid(y,x,z);
Pim=[x(:),y(:),z(:)];
ind = dsearchn(P,Pim);%%%%%%%%%%%%%%
imL=L(ind);
imL=reshape(imL,size(im));
% imshow(label2rgb(imL))


