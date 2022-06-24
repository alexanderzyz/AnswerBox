clc
clear
px=linspace(-2,2,100);
[x,y]=meshgrid(px,px);
z=3.*(1-x).^2.*exp(-(x.^2)-(y+1).^2)-10*(x./5-x.^3-y.^5).*exp(-x.^2-y.^2)-1/3.*exp(-(x+1).^2-y.^2);
mesh(x,y,z,'EdgeAlpha',0.35)
hold on
contour(x,y,z,50,'EdgeColor','b')
xlabel('x')
ylabel('y')
zlabel('z')
[x_1,min_f1]=fminunc('func2',[0,-2]);
[x_2,min_f2]=fminunc('func2',[-2,0]);
fprintf('peaks函数的最小值为%f',min([min_f1,min_f2]));