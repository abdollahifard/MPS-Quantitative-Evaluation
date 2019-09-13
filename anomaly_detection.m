function [Defectmap,DefectMeasure,Hre]=anomaly_detection(re,Hti,Edges,thE, thnE, LBPType)
switch LBPType
    case 'LBP16'
        [h,Hre,LBPCat,StDCat]=myLBP16(re);
        ws=3;% window size = 7*7
    case 'LBP12'
        [h,Hre,LBPCat,StDCat]=myLBP12(re);
        ws=2;% window size = 5*5
    case 'LBP8'
        [h,Hre,LBPCat,StDCat]=myLBP8(re);
        ws=1;% window size = 3*3
    otherwise
        disp('error: LBPType must be one of the followings: LBP16, LBP12, LBP8')
        return 
end

ind = sub2ind(size(Hti),LBPCat,StDCat);
% probability map (showing the probability of occurance of each pixel of the
   % realization based on Histogram of the TI. 
Pmap = Hti(ind); 
Pmap = reshape(Pmap,size(re)-2*ws);
Pmap = padarray(Pmap,ws*ones(1,2),1);
Distmap=bwdist(Edges);
thresholdmap = ones(size(Distmap))*(thnE/numel(Hti));
thresholdmap(Distmap<=10) = thE/numel(Hti);
Defectmap = Pmap<=thresholdmap;
se=strel('disk',6);
Defectmap = imdilate(Defectmap,se);
DefectMeasure = sum(Defectmap(:))/numel(Defectmap);



