function [ri,rc,r]=relative_quantitative_evaluation(ti,Y1,Y2)
mm(1)=min(ti(:));
mm(2)=max(ti(:));
if mm<100
    ti=255/diff(mm)*(double(ti)-mm(1));
    Y1=255/diff(mm)*(double(Y1)-mm(1));
    Y2=255/diff(mm)*(double(Y2)-mm(1));
end
disp('quantifying innovation factor(s) ....')
ci1 = innovation_measure_2d(ti,Y1);
di1=1-ci1;
ci2 = innovation_measure_2d(ti,Y2);
di2=1-ci2;
disp('quantifying consistency factor(s) ....')
[~,dc1]=consistency_measure_2d(ti,Y1);
[~,dc2]=consistency_measure_2d(ti,Y2);
ri = mean(di2)/mean(di1);
rc = mean(dc2)/mean(dc1);
r = ri*rc;