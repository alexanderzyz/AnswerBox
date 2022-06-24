function s=fact(n)
s=1;    
if n>=0
    for i=1:n
        s=s*i;
    end
else 
    s=0;
end
end
