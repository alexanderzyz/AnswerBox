clear;clc;close all;
%列主元消元法
eps=1e-5;
A=[ 14,2,1,5;
    8,17,2,10;
    4,18,3,6;
    12,26,11,20;];
B=[1;2;3;4];
pmax=0;
maxIndex=0;
for i=1:4
    for j=1:4
        A(i,j)>pmax;
        pmax=A(i,j);
    end
end
if abs(pmax)<eps
    fprintf("det(A)<0")
else
    pmax=0;
    for j=1:4
        for i=1:4
           if A(i,j)>pmax
               pmax=A(i,j);
               maxIndex=i;
           end
        end
        temp=A(j,1:4);
        temp2=B(j,1);
        A(j,1:4)=A(maxIndex,1:4);
        B(j,1)=B(maxIndex,1);
        B(maxIndex,1)=temp2;
        A(maxIndex,1:4)=temp;
        for i=j+1:4
            divRes=-A(i,j)/A(j,j);
            A(i,1:4)=A(i,1:4)+A(j,1:4)*divRes;
            B(i,1)=B(i,1)+B(j,1)*divRes;
        end
    end
    C=[0;0;0;0];
    for i=4:-1:1
        for j=i+1:4
            B(i,1)=B(i,1)-(C(j,1)*A(i,j));
        end
        C(i,1)=B(i,1)/A(i,i);
    end
    fprintf("列主元消元法的计算结果为\n")
    for i=1:4
        fprintf("x%d=%d\n",i,C(i,1));
    end
end
%Jacobi迭代
fprintf("Jacobi迭代方法计算结果为\n")
eps=1e-5;
A=[ 14,2,1,5;
    8,17,2,10;
    4,18,3,6;
    12,26,11,20;];
B=[1;2;3;4];
X=[0;0;0;0];
Y=[0;0;0;0];
e=100;
k=0;
M=50;
while e>=eps && k<M
    Y=B;
    for i=1:4
        for j=1:4
            if i==j
                continue;
            end
            Y(i,1)=Y(i,1)-A(i,j)*X(j,1);
            if j==4
                Y(i,1)=Y(i,1)/A(i,i);
            end
        end
    end
    Y(4,1)=Y(4,1)/A(4,4);
    e=max(abs(Y-X));
    X=Y;
    Y=B;
    k=k+1;
end
if k>=M
    fprintf("迭代超过最大次数，Jacobi迭代方法方法可能发散\n")
else
    for i=1:4
        fprintf("x%d=%d\n",i,X(i,1));
    end
end

%GaussSeidel迭代方法
fprintf("GaussSeidel迭代计算结果为\n")
eps=1e-5;
A=[ 14,2,1,5;
    8,17,2,10;
    4,18,3,6;
    12,26,11,20;];
B=[1;2;3;4];
X=[0;0;0;0];
PX=[0;0;0;0];
Y=[0;0;0;0];
e=100;
k=0;
M=50;
while e>=eps && k<M
    Y=B;
    for i=1:4
        for j=1:4
            if i==j
                continue;
            end
            Y(i,1)=Y(i,1)-A(i,j)*PX(j,1);
            if j==4
                Y(i,1)=Y(i,1)/A(i,i);
            end
        end
        PX(i,1)=Y(i,1);
    end
    Y(4,1)=Y(4,1)/A(4,4);
    PX=Y;
    e=max(abs(PX-X));
    X=Y;
    Y=B;
    k=k+1;
end
if k>=M
    fprintf("迭代超过最大次数，Jacobi迭代方法可能发散\n")
else
    for i=1:4
        fprintf("x%d=%d\n",i,X(i,1));
    end
    fprintf("共迭代了%d次\n",k)
end

