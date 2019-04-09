function [h,H,LBPCat,StDCat]=myLBP8(im)

stdbins=[5:10:95];% bins considered for standard deviation
im=double(im);
imPat = im2col(im,[3,3]); % image patterns in columns
NgbGL = imPat([1:4,6:9],:);% gray levels of the neighborhood
NgbStD=sqrt(var(NgbGL));% standard deviation of neighborhood

NgbDifSign = NgbGL>=repmat(imPat(5,:),8,1); % the sign of NgbGL-(graylevel of central pixel)
LBPFeat = binaryVectorToDecimal(NgbDifSign')';% LBP Features
load LookUpTable8
LBPFeatRI = LUT(LBPFeat+1);% Rotation Invarient LBP features,
nMisI=false(size(LBPFeatRI));% binary index of not miscellaneous category.
LBPCat = zeros(size(LBPFeatRI));% LBP Categories (0 to 10)
for i=0:8
    UniI= LBPFeatRI== 2^i-1;% binary indices of uniform patches
    LBPCat(UniI) = i+1;
    h(i+1)= sum(UniI);
    H(i+1,:)=hist(NgbStD(UniI),stdbins);
    nMisI=nMisI|UniI;
end
LBPCat(~nMisI)=10;
h(10)= sum(~nMisI);
H(10,:)=hist(NgbStD(~nMisI),stdbins);
%H=H+1;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%H=H/sum(H(:));
[~,StDCat]=min(abs(repmat(NgbStD,numel(stdbins),1)-repmat(stdbins',1,size(NgbStD,2))));





