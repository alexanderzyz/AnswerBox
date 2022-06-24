clc
clear
clf
x=[0.10;0.30;0.40;0.55;0.70;0.80;0.95];
y=[15;18;19;21;22.6;23.8;26];
% 一次拟合
subplot(131)
px=linspace(0,1,100)
pf=polyfit(x,y,1);
f=poly2str(pf,'x')
py=polyval(pf,px);
plot(px,py,"-")
legend(f)
title('一次拟合')
% 三次拟合
subplot(132)
pf=polyfit(x,y,3);
f=poly2str(pf,'x');
py=polyval(pf,px);
plot(px,py,"-");
legend(f)
title('三次拟合')
% 五次拟合
subplot(133)
pf=polyfit(x,y,5);
f=poly2str(pf,'x');
py=polyval(pf,px);
plot(px,py,"-");
legend(f)
title('五次拟合')
