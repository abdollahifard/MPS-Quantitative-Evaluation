function [ci,cc,c]=mps_quantitative_evaluation3d(ti,Y)
mm(1)=min(ti(:));
mm(2)=max(ti(:));
if mm(2)<100
    ti=255/diff(mm)*(double(ti)-mm(1));
    Y=255/diff(mm)*(double(Y)-mm(1));
end
disp('quantifying innovation factor(s) ....')
ci = innovation_measure_3d(ti,Y);
disp('quantifying consistency factor(s) ....')
cc=consistency_measure_3d(ti,Y);
c=cc.*ci;