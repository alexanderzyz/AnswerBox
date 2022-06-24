clc
clear
% 第一问
x=[0.25,0.5,1,1.5,2,3,4,6,8];
plotx=linspace(0,10,100);
y=[19.21,18.15,15.36,14.10,12.89,9.32,7.45,5.24,3.01];
py=log(y);
f=polyfit(x,py,1);
fstr=poly2str(f,'x');
ploty=exp(polyval(f,plotx));
plot(plotx,ploty);
% 第二问
title('血药浓度随时间的变化规律')
xlabel('t/h');
ylabel('c/mg/ml');
legend(fstr)
y1=interp1(y,x,10,'pchip');
time=(log(10)-f(2))/f(1);
fprintf('第一次注射的剂量为：%.2fmg,其余每次注射的剂量为：%.2fmg。\n间隔时间为：%.2fh\n',300*25/exp(f(2)),300*15/exp(f(2)),time);