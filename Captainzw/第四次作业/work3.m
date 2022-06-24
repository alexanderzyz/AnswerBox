clear
clc
x=linspace(-3,3,7);
y=linspace(-3,3,7);
x2=linspace(-3,3,20);
y2=linspace(-3,3,20);
[x,y]=meshgrid(x,y);
[x2,y2]=meshgrid(x2,y2);

subplot(221)
z=x.^2/16-y.^2/9;
mesh(x,y,z);
title('原图像')

subplot(222)
z2=interp2(x,y,z,x2,y2,'nearest');
mesh(x2,y2,z2)
title('最近点插值')

subplot(223)
z2=interp2(x,y,z,x2,y2,'linear');
mesh(x2,y2,z2)
title('线性插值')

subplot(224)
z2=interp2(x,y,z,x2,y2,'spline');
mesh(x2,y2,z2)
title('样条插值')