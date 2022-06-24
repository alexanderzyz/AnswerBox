clc
clear
n=[1000,5000,10000,20000,50000];
for j=1:5
x=unifrnd(0,1,1,n(j));
y=unifrnd(0,10,1,n(j));
sum=0;
for i=1:n(j)
    if(y(i)<(4/(1+x(i)^2)))
        sum=sum+1;
    end
end
res=sum/n(j)*10;
fprintf('当n=%d时,定积分的近似值为%.5f,与pi的相对误差为%.4f%%\n',n(j),res,abs(res-pi)/pi*100)
end