clc;
clear;
x=linspace(-2,2,100);
y=linspace(-2,2,100);
[x,y]=meshgrid(x,y);
subplot(121)
z=5-x.^2-y.^2;
mesh(x,y,z)
title("曲面与平面",FontSize=16)
hold on
z2=3*ones(size(x));
mesh(x,y,z2)
subplot(122)
rr=abs(z-z2)<=0.04;
plot3(x(rr==1),y(rr==1),z(rr==1),"g*");
title("交线",FontSize=16)
axis([-2,2,-2,2,-2,5])
