image=imread('2.png');
I_red=imread('red.png');
I_green=imread('green.png');
I_blue=imread('blue.png');
I_rod=imread('rod.png');
I_red=double(I_red)./255;
I_green=double(I_green)./255;
I_blue=double(I_blue)./255;
I_rod=double(I_rod)./255;
width=size(I_red,1);
length=size(I_red,2);
I_rgb=zeros(width,length,3);
I_rgb(:,:,1)=I_red;
I_rgb(:,:,2)=I_green;
I_rgb(:,:,3)=I_blue;
% width=size(I_rgb,1);
% length=size(I_rgb,2);
vm_red=1;
sigma_red=0.1;
v_rgb=vm_red.*I_rgb./(I_rgb+sigma_red);
v_rod=vm_red.*I_rod./(I_rod+sigma_red);
v_shuangji=conv(v_rgb,width/5,length/5,3,5);
v_shuangji_rod=conv(v_rod,width/10,length/10,1,10);
v_shuangji=1*v_shuangji./(v_shuangji+0.1);
v_shuangji_rod=1*v_shuangji_rod./(v_shuangji_rod+0.1);
width1=size(v_shuangji,1);
length1=size(v_shuangji,2);
v_shuangji_rod=imresize(v_shuangji_rod,[width1 length1]);
v_shenjingjie=conv(v_shuangji,width1/2,length1/2,3,2);
v_shenjingjie_rod=conv(v_shuangji_rod,width1/4,length1/4,1,4);
width2=size(v_shenjingjie,1);
length2=size(v_shenjingjie,2);
v_shenjingjie_rod=imresize(v_shenjingjie_rod,[width2 length2]);
Gauss=zeros(width2,length2,3);
sigma1=15;
sigma2=40;
for i=1:width2
    for j=1:length2
        Gauss(i,j,:)=1+(1*exp(-((i-round(width2/2))^2+(j-round(length2/2))^2)/sigma1^2)-0.5*exp(-((i-round(width2/2))^2+(j-round(length2/2))^2)/sigma2^2));
    end
end
Gauss=Gauss./(max(max(Gauss)));
%v_shenjingjie=v_shenjingjie.*Gauss;
v_shenjingjie_rod=v_shenjingjie_rod.*Gauss(:,:,1);
v_shenjingjiehsv=rgb2hsv(v_shenjingjie);
v_shenjingjiehsv(:,:,3)=v_shenjingjie_rod.*v_shenjingjiehsv(:,:,3);
v_shenjingjie=hsv2rgb(v_shenjingjiehsv);
figure(1),imshow(v_shenjingjie_rod);
figure(2),imshow(v_shenjingjie);
%figure(3),imshow(v_rgb);
%figure(4),imshow(I_rgb);
function B=conv(A,w,l,d,size)
B=zeros(ceil(w),ceil(l),d);
for i=1:floor(w)
    for j=1:floor(l)
        B(i,j,:)=sum(sum(A(i*size-(size-1):i*size,j*size-(size-1):j*size,:)))/size^2;
    end
end
if ceil(w)~=floor(w)
    for j=1:floor(l)
        B(end,j,:)=sum(sum(A(floor(w)*size+1:end,j*size-(size-1):j*size,:)))./numel(A(floor(w)*size+1:end,j*size-(size-1):j*size,1));
    end
end
if ceil(l)~=floor(l)
    for i=1:floor(w)
        B(i,end,:)=sum(sum(A(i*size-(size-1):i*size,floor(l)*size+1:end,:)))./numel(A(i*size-(size-1):i*size,floor(l)*size+1:end,1));
    end
end
if ceil(w)~=floor(w) && ceil(l)~=floor(l)
    B(end,end,:)=sum(sum(A(floor(w)*size+1:end,floor(l)*size+1:end,:)))./numel(A(floor(w)*size+1:end,floor(l)*size+1:end,1));
end
end