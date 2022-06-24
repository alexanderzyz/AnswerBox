clc
clear
[t,x]=ode45('func2',[0,2*pi],[0,0]);
plot(t,x(:,1),'go-')
hold on
plot(t,x(:,2),'bx-');
legend('y',"y'") 
hold on