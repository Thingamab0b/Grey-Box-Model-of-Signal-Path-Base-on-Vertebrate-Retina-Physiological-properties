center_x=round(size(I_rod,1)/2);
center_y=round(size(I_rod,2)/2);
gauss=zeros(size(I_rod,1),size(I_rod,2));
A1=1;
A2=0.5;
sigma1=80;
sigma2=200;
for i=1:size(I_rod,1)
    for j=1:size(I_rod,2)
        gauss(i,j)= A1*exp(-((i-center_x)^2+(j-center_y)^2)/sigma1^2)-A2*exp(-((i-center_x)^2+(j-center_y)^2)/sigma2^2);
    end
end


result=gauss.*I_rod; 
result(result<0)=0; %Relu
average=mean(mean(result));
subplot(2,1,1);
imshow(I_rod);
title('rod input')
subplot(2,1,2);
imshow(result);
title('bipolar output')


