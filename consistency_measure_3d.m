function cc=consistency_measure_3d(ti,Y)


% LBP of TI:
[Hti8_1,Hti8_2,Hti8_3]=LBP_3d(ti,8);
[Hti12_1,Hti12_2,Hti12_3]=LBP_3d(ti,12);
[Hti16_1,Hti16_2,Hti16_3]=LBP_3d(ti,16);

for i=1:size(Y,4)
    i
    re=Y(:,:,:,i);
    [Hre8_1,Hre8_2,Hre8_3]=LBP_3d(re,8);
    [Hre12_1,Hre12_2,Hre12_3]=LBP_3d(re,12);
    [Hre16_1,Hre16_2,Hre16_3]=LBP_3d(re,16);
    
    d1=JS_divergence(Hti8_1(:) , Hre8_1(:));
    d2=JS_divergence(Hti12_1(:),Hre12_1(:));
    d3=JS_divergence(Hti16_1(:),Hre16_1(:));
    d4=JS_divergence(Hti8_2(:) , Hre8_2(:));
    d5=JS_divergence(Hti12_2(:),Hre12_2(:));
    d6=JS_divergence(Hti16_2(:),Hre16_2(:));
    d7=JS_divergence(Hti8_3(:) , Hre8_3(:));
    d8=JS_divergence(Hti12_3(:),Hre12_3(:));
    d9=JS_divergence(Hti16_3(:),Hre16_3(:));
    d(i)=(d1+d2+d3+d4+d5+d6+d7+d8+d9)/9;
    cc(i) =max(1- 5*d(i),0);
    
end




function [H1,H2,H3]=LBP_3d(im,LBP_type)
% LBP_type should be 8, 12 or 16
im2d=squeeze(im(1,:,:));
H1=LBP_2d(im2d,LBP_type) ;
for i=2:size(im,1)
    im2d=squeeze(im(i,:,:));
    H1=H1+LBP_2d(im2d,LBP_type);
end

im2d=squeeze(im(:,1,:));
H2=LBP_2d(im2d,LBP_type) ;
for i=2:size(im,2)
    im2d=squeeze(im(:,i,:));
    H2=H2+LBP_2d(im2d,LBP_type);
end
im2d=squeeze(im(:,:,1));
H3=LBP_2d(im2d,LBP_type) ;
for i=2:size(im,3)
    im2d=squeeze(im(:,:,i));
    H3=H3+LBP_2d(im2d,LBP_type);
end

function H=LBP_2d(im,LBP_type)
switch LBP_type
    case 8
        [~,H,~,~]=myLBP8(im);
    case 12
        [~,H,~,~]=myLBP12(im);
    case 16
        [~,H,~,~]=myLBP16(im);
end
