function ci = segments2innovation(imL,N)
% given the labeled image, imL, and the number of keypoints in the image,
%    N, the function returns the creativity measure, cr.

p=1.3;

a = regionprops(imL,'area');
s = struct2array(a);
s = s/sum(s);

% ci = 1 / ( N^(p-1) * sum(s.^p) )^ (1/p);
ci = (( sum(s.^p) )^ (-1/p)-1)/(N^((p-1)/p)-1);