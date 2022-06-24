function yp=func(t,y)
yp=[0,1;-1,1]*y+[0;1]*(3.*cos(t));