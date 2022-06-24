clc
clear
clf

y=0;
judge=0;
for k=1:200
    u=unidrnd(365,1,30);
    for i=1:29
        for j=i+1:30
            if(u(i)==u(j))
                y=y+1;
                judge=1;
            end
            if(judge==1)
                break;
            end
        end
        if(judge==1)
            break;
        end
    end
    judge=0;
    plot(k,y/k,'r*');
    ylim([0,1])
    hold on
end
plot([0,200],[0.7063,0.7063],'g-')
title(['模拟200个班至少有两人生日相同的概率为：',num2str(y/k)])