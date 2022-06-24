clc
clear
clf;
y=0;
for n=1:500
    u=unidrnd(6,1,1);
    if(u(1)==5)
        y=y+1;
    end
    plot(n,y/n,'r*')
    hold on
end
plot([0,500],[1/6,1/6],'g-')
ylim([0,1])
legend(['5点出现的概率为：',num2str(y/500)])
title('试验次数与概率的关系图')