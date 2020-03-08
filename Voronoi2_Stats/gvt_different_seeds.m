clear;clc;
% q=100;
% w=400;
% h=1600;
% m=2500;
% rec=50*rand(2500,1);   
% red=50*rand(2500,1); 
% qx=50*rand(100,1);
% qy=50*rand(100,1);  
% wx=50*rand(400,1);   
% wy=50*rand(400,1);   
% hx=50*rand(1600,1);   
for k = 1:49
    ax(k) = subplot(7,7,k);
end

for lambda=100:200:9900;
    rec=50*rand(lambda,1);   
    red=50*rand(lambda,1); 
%     figure
%     voronoi(rec,red);   % 绘制voronoi多边形
     axis([0,3,0,1000]);
    grid on;

    e=[rec red];
   [v,c]=voronoin(e);% v是所有的voronoi边的顶点坐标，c{i}就是第i个点周围的voronoi边的顶点下标
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   for p=1:lambda
    t=[v(c{p},1),v(c{p},2)];
    [r,s]=size(t);
    a=0;
       for q=2:r-1
           a1=1/2*abs((t(q,1)-t(1,1))*(t(q+1,2)-t(1,2))-(t(q+1,1)-t(1,1))*(t(q,2)-t(1,2)));   % S=1/2[(x1*y2-x2*y1)+(x2*y3-x3*y2)+...+(xn-1*yn-xn*yn-1)+(xn*y1-x1*yn)]
           a=a+a1;
       end
 
            Area(p)=a;
    
   end
   
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind_inf=isinf(Area);
[inf_r inf_c]=find(ind_inf==1);
Area(inf_c)=[];
ind_nan=isnan(Area);
Area(ind_nan)=[];
Area(Area>5000/lambda)=[];
n=15;
x=linspace(min(Area),max(Area),n);

y=zeros(1,n);
for i=1:length(Area)

for j=1:n-1
  if Area(i)>x(j)&&Area(i)<=x(j+1)
    y(j)=y(j)+1;
  else
    y(j)=y(j)+0;
  end

end
end

z=(lambda+100)/200;
subplot(ax(z))

bar(x,y)
end
