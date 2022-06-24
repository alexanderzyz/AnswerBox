function outGif(index,frame,Delaytime,filename)
[A,map]=rgb2ind(frame2im(getframe(frame)),256);
  if index==1
        imwrite(A,map,filename,'gif','LoopCount',inf,'DelayTime',Delaytime)
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',Delaytime)
  end
end