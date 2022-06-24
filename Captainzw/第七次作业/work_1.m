clc
clear
dt=0.05;
vp=300;
vd=500;
p0=[0,0,0];
p2=[3000,0,2000];
xd=p0(1);
yd=p0(2);
zd=p0(3);
xp=p2(1);
yp=p2(2);
zp=p2(3);
times=0;
thr=10;
dis=sqrt(abs(xd-xp)^2+abs(yd-yp)^2+abs(zd-zp)^2);
while(dis>thr)
    cos_x=(xp-xd)/dis;
    cos_y=(yp-yd)/dis;
    cos_z=(zp-zd)/dis;
    times=times+1;
    yp1=yp+vp*dt;
    xd1=xd+vd*cos_x*dt;
    yd1=yd+vd*cos_y*dt;
    zd1=zd+vd*cos_z*dt;
    dis=sqrt(abs(xd-xp)^2+abs(yd-yp)^2+abs(zd-zp)^2);
    plot3([xd,xd1],[yd,yd1],[zd,zd1],'r.-',[xp,xp],[yp,yp1],[zp,zp],'g.-');
    hold on
    yp=yp1;
    xd=xd1;yd=yd1;zd=zd1;
end
title(['用时为',num2str(times*dt),'秒'])
