function cc=consistency_measure_2d(ti,Y)


% LBP of TI:
[~,Hti8,~,~]=myLBP8(ti);
[~,Hti12,~,~]=myLBP12(ti);
[~,Hti16,~,~]=myLBP16(ti);


for i=1:size(Y,3)
    i
    re=Y(:,:,i);
    [~,Hre8,~,~]=myLBP8(re);
    [~,Hre12,~,~]=myLBP12(re);
    [~,Hre16,~,~]=myLBP16(re);
    d1(i)=JS_divergence(Hti8(:) , Hre8(:));
    d2(i)=JS_divergence(Hti12(:),Hre12(:));
    d3(i)=JS_divergence(Hti16(:),Hre16(:));
    d(i)=(d1(i)+d2(i)+d3(i))/3;
    cc(i) =max(1- 5*d(i),0);
    
end
