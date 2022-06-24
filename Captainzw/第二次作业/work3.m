filename = 'WORK3.gif'; % Specify the output file name
x=linspace(-30,30,200);
y=linspace(-30,30,200);
[x,y]=meshgrid(x,y);
z=x.^2-2.*y.^2;
subplot(131)
mesh(x,y,z);
index=1;
for i=-15:2:15
    subplot(131)
    title("马鞍面",FontSize=16);
    z2=x.*0+i*2;
    subplot(132)
    mesh(x,y,z2)
    title("平面",FontSize=16);
    axis([-30,30,-30,30,-100,100])
    rr=abs(z-z2)<=0.5;
    subplot(133)
    plot3(x(rr==1),y(rr==1),z2(rr==1),'r*');
    title("交线",FontSize=16);
    axis([-30,30,-30,30,-60,60])
    pause(0.2)
    outGif(index,gcf,0.2,'test.gif')
    index=index+1;
end