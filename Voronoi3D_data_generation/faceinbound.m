% �˺����������λ�ڱ߽����ϵĵ㹹�ɵ���
function [C] = faceinbound(A)
C=cell(1,100); %�����������Ҫ������Ԫ������
bound1=0;
bound2=1; %�߽�Ϊ0��1��������
[n,m]=size(A);
B0=cell(1,m);%���λ��0�߽��ϵĵ�
for i=1:m
    B0{i}=[];
end
B1=cell(1,m);%���λ��1�߽��ϵĵ�
for i=1:m
    B1{i}=[];
end
for i=1:n
    for j=1:m
        if abs(A(i,j)-bound1)<0.00001
            B0{j}=[B0{j};A(i,:)];
        end
        if abs(A(i,j)-bound2)<0.00001
            B1{j}=[B1{j};A(i,:)];
        end
    end
end
k=1;
for i=1:m
    if size(B0{i},1)>=3 %3�����Ϲ���һ����
        C{k}=B0{i};
        k=k+1;
    end
    if size(B1{i},1)>=3
        C{k}=B1{i};
        k=k+1;
    end
end
[n,m]=size(C);
for i=1:m
    if isempty(C(i)) %��ȡC�зǿ�Ԫ������
        break
    end
end
C=C(1:i);
end