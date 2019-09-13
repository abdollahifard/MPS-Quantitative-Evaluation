function [B1,B2] = labeledges(imL)
% given a labeled image, imL, the function returns a binary image, B1,
%    determining the 1-pixel wide edges between regions in white. 
% B2 gives wider borders,
I1=circshift(imL,[1,0]);
I2=circshift(imL,[-1,0]);
I3=circshift(imL,[0,1]);
I4=circshift(imL,[0,-1]);
B1=(imL>I1)|(imL>I2)|(imL>I3)|(imL>I4);
B1(1,:)=0;
B1(end,:)=0;
B1(:,1)=0;
B1(:,end)=0;

B2=(imL~=I1)|(imL~=I2)|(imL~=I3)|(imL~=I4);
B2(1,:)=0;
B2(end,:)=0;
B2(:,1)=0;
B2(:,end)=0;