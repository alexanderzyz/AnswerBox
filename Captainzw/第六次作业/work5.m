clc
clear
n=500000;
x=unifrnd(0,1,1,n);
y=unifrnd(0,1,1,n);
z=unifrnd(0,200,1,n);
sum=0;
for i=1:n
    if(z(i)<exp((x(i)+y(i))^2))
        sum=sum+1;
    end
end
fprintf('定积分的结果是：%.5f\n',sum/n*200);