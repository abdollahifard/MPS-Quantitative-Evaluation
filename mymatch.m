function [locs_ti,locs_re] = mymatch(des_ti,locs_ti,des_re,locs_re,alpha)
% the function takes the locations and descriptors of keypoints in both 
%    realization and TI and finds the best match of realization keypoints
%    in the TI. 
% alpha (0<alpha<1) determines the fraction of keypoints to be removed from
%    the worst matches.
% keypoints whose distance with their matches is higher than th will be
%    removed. if more than alpha fraction of keypoints are to be removed,
%    we only remove the wosrt alpha fraction. 
% the output return the locations of realization keypoints after removing
%    the worst matches.
% the location of ti keypoints are also rearranged in accordance to
%    realization keypoints (so that the keypoints in the same rows are
%    matches)

 
% [match_inds,dist] = dsearchn(des_ti,des_re);
% locs_ti = locs_ti(match_inds,:);
% [~,sdind] = sort(dist);
% n = round(alpha*numel(dist));
% locs_ti(sdind(end-n+1:end),:) = [];
% locs_re(sdind(end-n+1:end),:) = [];
tdes = 0.2;

[match_inds,dist] = dsearchn(des_ti,des_re);
locs_ti = locs_ti(match_inds,:);
ind=find(dist>tdes);%%%%%%%%%%%%%%%
if length(ind)/size(locs_re,1)>alpha
    [~,sdind] = sort(dist);
    n = round(alpha*numel(dist));
    locs_ti(sdind(end-n+1:end),:) = [];
    locs_re(sdind(end-n+1:end),:) = [];
else
    locs_ti(ind,:)=[];
    locs_re(ind,:)=[];
end

