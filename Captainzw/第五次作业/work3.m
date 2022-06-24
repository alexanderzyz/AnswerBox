clc
clear
[t,x]=ode45('func',[0,20],[1.2,0,0,-1.0496]);
plot(x(:,1),x(:,3),'go-')
hold on