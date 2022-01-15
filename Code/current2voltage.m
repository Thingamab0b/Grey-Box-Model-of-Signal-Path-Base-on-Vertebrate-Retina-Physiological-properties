%I_blue, I_green, I_red, I_rod 
sample_Num=9;
delta_t=0.05;
tau=50;
a=1;%R的稳定值等于amp*I
tspan=[0:1:sample_Num]*delta_t;


video_rod=zeros(size(I_rod,1),size(I_rod,2),sample_Num);
video_red=zeros(size(I_red,1),size(I_red,2),sample_Num);
video_green=zeros(size(I_green,1),size(I_green,2),sample_Num);
video_blue=zeros(size(I_blue,1),size(I_blue,2),sample_Num);


for j=1:size(I_rod,2)
I_rod_temp=I_rod(:,j);%按照列来求解R和V
I_red_temp=I_red(:,j);
I_green_temp=I_green(:,j);
I_blue_temp=I_blue(:,j);

R0_rod=zeros(size(I_rod_temp,1),size(I_rod_temp,2));%可以random
R0_red=zeros(size(I_red_temp,1),size(I_red_temp,2));%可以random
R0_green=zeros(size(I_green_temp,1),size(I_green_temp,2));%可以random
R0_blue=zeros(size(I_blue_temp,1),size(I_blue_temp,2));%可以random


[t_rod,R_rod]=ode23(@(t,R)R_I(R,I_rod_temp,t,a,tau),tspan,R0_rod);
[t_red,R_red]=ode23(@(t,R)R_I(R,I_red_temp,t,a,tau),tspan,R0_red);
[t_green,R_green]=ode23(@(t,R)R_I(R,I_green_temp,t,a,tau),tspan,R0_green);
[t_blue,R_blue]=ode23(@(t,R)R_I(R,I_blue_temp,t,a,tau),tspan,R0_blue);

R_k=0.8*ones(size(R_rod),'like',R_rod); %Rk前面的系数和对比度有关 和细胞种类有关

V_rod=R_rod./(R_rod+R_k);
V_red=R_red./(R_red+R_k);
V_green=R_green./(R_green+R_k);
V_blue=R_blue./(R_blue+R_k);


for k=1:sample_Num+1
video_rod(:,j,k)=V_rod(k,:);
video_red(:,j,k)=V_red(k,:);
video_green(:,j,k)=V_green(k,:);
video_blue(:,j,k)=V_blue(k,:);

end
end

for i=1:sample_Num
figure(1)
subplot(ceil(sqrt(sample_Num)),ceil(sqrt(sample_Num)),i);
imshow(video_rod(:,:,i));
title('rod channel')

figure(2)
subplot(ceil(sqrt(sample_Num)),ceil(sqrt(sample_Num)),i);
imshow(video_red(:,:,i));
title('red channel')

figure(3)
subplot(ceil(sqrt(sample_Num)),ceil(sqrt(sample_Num)),i);
imshow(video_green(:,:,i));
title('green channel')

figure(4)
subplot(ceil(sqrt(sample_Num)),ceil(sqrt(sample_Num)),i);
imshow(video_blue(:,:,i));
title('blue channel')
end
