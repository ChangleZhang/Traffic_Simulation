%%%file open test
%%%changle zhang :zhangchanglehit@163.com
clear all;clc;close all;

dirs=dir;
dircell=struct2cell(dirs)';
filenames=dircell(:,1);

count = 0;

for j=1:length(filenames)
        ind=strfind(filenames(j),'rsr');       
        if isempty(ind{1})==0             
           count=count+1;       %count the number of rsr files
        end
end

car_info=zeros(30,2);            %初始化

flag=1;
for j=1:length(filenames)
        ind=strfind(filenames(j),'rsr');       
        if isempty(ind{1})==0
           nname = char(filenames(j));
           D = importdata(nname) ;
           datafiles = D.data;
           car_info(flag,2) = mean(datafiles(:,5));   %cal the mean time
           shape = size (datafiles);
           car_info(flag,1) = shape(1);             %count the car number
           flag=flag+1;
        end
end
up_car_info = sort(car_info);                       %sort the information by car number
plot(up_car_info(:,1),up_car_info(:,2),'+');
hold on;

x1=polyfit(up_car_info(:,1),up_car_info(:,2),1);
plot(up_car_info(:,1),x1(1)*up_car_info(:,1)+x1(2),'r');%1-order
hold on;

x2=polyfit(up_car_info(:,1),up_car_info(:,2),2);
plot(up_car_info(:,1),x2(1)*up_car_info(:,1).^2+x2(2)*up_car_info(:,1)+x2(3),'g');%2-order

hold on;
x3=polyfit(up_car_info(:,1),up_car_info(:,2),3);
plot(up_car_info(:,1),x3(1)*up_car_info(:,1).^3+x3(2)*up_car_info(:,1).^2+x3(3)*up_car_info(:,1)+x3(4),'k');

ylabel('行程时间/t');
xlabel('车辆数目/N');
legend('原始数据点','一阶拟合','二阶拟合','三阶拟合','Location','NorthWest');
title('一车道行程时间随车辆数目的拟合曲线');