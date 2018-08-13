function [h,H,LBPCat,StDCat]=myLBP12(im)

stdbins=[5:10:95];% bins considered for standard deviation
im=double(im);
imPat = im2col(im,[5,5]); % image patterns in columns
NgbGL = imPat([2,3,4,10,15,20,24,23,22,16,11,6],:);% gray levels of the neighborhood
NgbStD=sqrt(var(NgbGL));% standard deviation of neighborhood

NgbDifSign = NgbGL>=repmat(imPat(13,:),12,1); % the sign of NgbGL-(graylevel of central pixel)
LBPFeat = binaryVectorToDecimal(NgbDifSign')';% LBP Features
load LookUpTable12
LBPFeatRI = LUT(LBPFeat+1);% Rotation Invarient LBP features,
nMisI=false(size(LBPFeatRI));% binary index of not miscellaneous category.
LBPCat = zeros(size(LBPFeatRI));% LBP Categories (0 to 10)
for i=0:12
    UniI= LBPFeatRI== 2^i-1;% binary indices of uniform patches
    LBPCat(UniI) = i+1;
    h(i+1)= sum(UniI);
    H(i+1,:)=hist(NgbStD(UniI),stdbins);
    nMisI=nMisI|UniI;
end
LBPCat(~nMisI)=14;
h(14)= sum(~nMisI);
H(14,:)=hist(NgbStD(~nMisI),stdbins);
H=H/sum(H(:));
[~,StDCat]=min(abs(repmat(NgbStD,numel(stdbins),1)-repmat(stdbins',1,size(NgbStD,2))));





