clc
clear
x=linspace(-8,8,100);
y=-1./((x-2).^2+3)-1./(3.*(x-5).^2+4)-1./(2.*(x-1).^2+1);
plot(x,y)
[~,y0,~,~]=fminbnd('func',-8,2);
[~,y1,~,~]=fminbnd('func',2,8);
y2=func(-8);
y3=func(8);
ymin=min([y0,y1,y2,y3]);
[~,py0,~,~]=fminbnd('1/((x-2)^2+3)+1/(3*(x-5)^2+4)+1/(2*(x-1)^2+1)',-8,8);
py1=-func(-8);
py2=-func(8);
ymax=-min([py0,py1,py2]);
fprintf('fminbnd求出的最小值为:%f 最大值为:%f',ymin,ymax);
[~,y0]=fminunc('func',-8);
ymin=min([y0,y2,y3]);
[~,py0]=fminunc('1/((x-2)^2+3)+1/(3*(x-5)^2+4)+1/(2*(x-1)^2+1)',-8);
[~,py1]=fminunc('1/((x-2)^2+3)+1/(3*(x-5)^2+4)+1/(2*(x-1)^2+1)',8);
ymax=-min([py0,py1]);
fprintf('fminunc求出的最小值为:%f 最大值为:%f',ymin,ymax);