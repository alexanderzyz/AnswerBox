clc
clear
x=[10;15;20;25;30];
y=[25.2;29.8;31.2;31.7;29.4];
y1=interp1(x,y,18,'nearest');
y2=interp1(x,y,26,'nearest');
fprintf('nearest方法x=18时的y值为%.2f\nnearest方法x=26时的y值为%.2f\n',y1,y2)
y1=interp1(x,y,18,'linear');
y2=interp1(x,y,26,'linear');
fprintf('linear方法x=18时的y值为%.2f\nlinear方法x=26时的y值为%.2f\n',y1,y2)
y1=interp1(x,y,18,'spline');
y2=interp1(x,y,26,'spline');
fprintf('spline方法x=18时的y值为%.2f\nspline方法x=26时的y值为%.2f\n',y1,y2)
y1=interp1(x,y,18,'pchip');
y2=interp1(x,y,26,'pchip');
fprintf('pchip方法x=18时的y值为%.2f\npchip方法x=26时的y值为%.2f\n',y1,y2)