%此函数用来输出两个元素为double型的矩阵的行的交集
function [C] = intersectfordouble(A,B)
[i1,j1]=size(A);
[i2,j2]=size(B);%j1应该等于j2
C=[];
for k=1:i1
    for l=1:i2
        x=0;
        for m=1:j1
            if abs(A(k,m)-B(l,m))<0.00001
                x=x+1;
            end
        end
        if x==j1 %相等元素数量与矩阵列数相等说明此行相同
            C=[C;A(k,:)];
        end
    end
end
end