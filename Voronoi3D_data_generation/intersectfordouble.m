%�˺��������������Ԫ��Ϊdouble�͵ľ�����еĽ���
function [C] = intersectfordouble(A,B)
[i1,j1]=size(A);
[i2,j2]=size(B);%j1Ӧ�õ���j2
C=[];
for k=1:i1
    for l=1:i2
        x=0;
        for m=1:j1
            if abs(A(k,m)-B(l,m))<0.00001
                x=x+1;
            end
        end
        if x==j1 %���Ԫ������������������˵��������ͬ
            C=[C;A(k,:)];
        end
    end
end
end