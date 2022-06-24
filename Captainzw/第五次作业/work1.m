clc
clear
% 矩形公式
h=0.01;
x=0:h:pi/4;
y=1./(1-sin(x));
res1=sum(y(1:length(y)-1))*h;
dev1=abs(res1-sqrt(2))/sqrt(2);
% 复合梯形公式
res2=trapz(x,y);
dev2=abs(res2-sqrt(2))/sqrt(2);
% 复合辛普森公式
res3=quad('1./(1-sin(x))',0,pi/4,0.01);
dev3=abs(res3-sqrt(2))/sqrt(2);

fprintf('矩形公式的结果为：%.5f,相对误差为:%.4f%%\n',res1,dev1*100)
fprintf('矩形公式的结果为：%.5f,相对误差为:%.4f%%\n',res2,dev2*100)
fprintf('矩形公式的结果为：%.5f,相对误差为:%.4f%%\n',res3,dev3*100)