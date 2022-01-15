center_x=round(size(I_red,1)/2);
center_y=round(size(I_red,2)/2);
gauss_red=zeros(size(I_red,1),size(I_red,2));
gauss_green=zeros(size(I_green,1),size(I_green,2));
A1=1;
A2=0.5;
sigma1=80;
sigma2=200;
for i=1:size(I_rod,1)
    for j=1:size(I_rod,2)
        gauss_red(i,j)= A1*exp(-((i-center_x)^2+(j-center_y)^2)/sigma1^2)-A2*exp(-((i-center_x)^2+(j-center_y)^2)/sigma2^2);
    end
end
gauss_green=-gauss_red;

result_red=gauss_red.*I_red; 
result_red(result_red<0)=0; %Relu
result_green=gauss_green.*I_green; 
result_green(result_green<0)=0; %Relu


figure(1)
subplot(2,2,1);
imshow(I_red);
title('red input')
subplot(2,2,2);
imshow(I_green);
title('green input')
subplot(2,2,3);
imshow(result_red);
title('bipolar output, red channel')
subplot(2,2,4);
imshow(result_green);
title('bipolar output, green channel')

figure(2)
result=result_red+result_green;
imshow(result);
title('intergrated response');

average_red=mean(mean(result_red));
average_green=mean(mean(result_green));
average=mean(mean(result));