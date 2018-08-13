function [h,H,LBPCat,StDCat]=myLBP16(im)

stdbins=[5:10:95];% bins considered for standard deviation
im=double(im);
imPat = im2col(im,[7,7]);
% Bilinear interpolation
coef =[1.0000         0         0         0
    0.1946    0.0338    0.6574    0.1142
    0.7721    0.1066    0.1066    0.0147
    0.1946    0.6574    0.0338    0.1142
    1.0000         0         0         0
    0.0338    0.1142    0.1946    0.6574
    0.1066    0.0147    0.7721    0.1066
    0.6574    0.1142    0.1946    0.0338
    1.0000    0.0000         0         0
    0.1142    0.6574    0.0338    0.1946
    0.0147    0.1066    0.1066    0.7721
    0.1142    0.0338    0.6574    0.1946
    0.0000         0    1.0000         0
    0.6574    0.1946    0.1142    0.0338
    0.1066    0.7721    0.0147    0.1066
    0.0338    0.1946    0.1142    0.6574];
NgbGL(1,:) = imPat (46,:);
NgbGL(2,:) = coef(2,:)*[imPat(40,:);imPat(41,:);imPat(47,:);imPat(48,:)];
NgbGL(3,:) = coef(3,:)*[imPat(41,:);imPat(42,:);imPat(48,:);imPat(49,:)];
NgbGL(4,:) = coef(4,:)*[imPat(34,:);imPat(35,:);imPat(41,:);imPat(48,:)];
NgbGL(5,:) = imPat(28,:);
NgbGL(6,:) = coef(6,:)*[imPat(13,:);imPat(14,:);imPat(20,:);imPat(21,:)];
NgbGL(7,:) = coef(7,:)*[imPat(6,:); imPat(6,:); imPat(13,:);imPat(14,:)];
NgbGL(8,:) = coef(8,:)*[imPat(5,:); imPat(6,:); imPat(12,:);imPat(13,:)];
NgbGL(9,:) = imPat(4,:);
NgbGL(10,:) = coef(10,:)*[imPat(2,:); imPat(3,:); imPat(9,:); imPat(10,:)];
NgbGL(11,:) = coef(11,:)*[imPat(1,:); imPat(2,:); imPat(8,:); imPat(9,:) ];
NgbGL(12,:) = coef(12,:)*[imPat(8,:); imPat(9,:);imPat(15,:); imPat(16,:)];
NgbGL(13,:) = imPat(22,:);
NgbGL(14,:) = coef(14,:)*[imPat(29,:);imPat(30,:);imPat(36,:);imPat(37,:)];
NgbGL(15,:) = coef(15,:)*[imPat(36,:);imPat(37,:);imPat(43,:);imPat(44,:)];
NgbGL(16,:) = coef(16,:)*[imPat(37,:);imPat(38,:);imPat(44,:);imPat(45,:)];
NgbStD=sqrt(var(NgbGL));

NgbDifSign = NgbGL>=repmat(imPat(25,:),16,1);
LBPFeat = binaryVectorToDecimal(NgbDifSign')';
load LookUpTable16
LBPFeatRI = LookUpTable(LBPFeat+1);
% for i = 0:15
%     BD(:,i+1)=binaryVectorToDecimal(circshift(B',[0,i]));
% end
% BDM=min(BD');
nMisI=false(size(LBPFeatRI));
LBPCat = zeros(size(LBPFeatRI));% LBP Categories (0 to 16)
for i=0:16
    UniI=LBPFeatRI== 2^i-1;
    LBPCat(UniI) = i+1;
    h(i+1)= sum(UniI);
    H(i+1,:)=hist(NgbStD(UniI),stdbins);
    nMisI=nMisI|UniI;
end
LBPCat(~nMisI)=18;
h(18)= sum(~nMisI);
H(18,:)=hist(NgbStD(~nMisI),stdbins);
H=H/sum(H(:));
[~,StDCat]=min(abs(repmat(NgbStD,numel(stdbins),1)-repmat(stdbins',1,size(NgbStD,2))));





