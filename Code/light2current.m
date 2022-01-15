%set the light bounds
low=400;
high=700;
%read the target image
img_name='red_on.png';
img_rgb=imread(img_name);
%turn the rgb to hsv
img_hsv=rgb2hsv(img_rgb);
hue=img_hsv(:,:,1); %mean
saturation=img_hsv(:,:,2); %1/saturation ->sigma
brightness=double(rgb2gray(img_rgb))/255; %amplitude

%correlate the hsv parameters with guass function
avg=high-(high-low)*hue;
sig=1./saturation;
amp=brightness;

%set parameters of photoreceptors (tunable)
sig_cone=60;
sig_rod=250;
avg_rod=500;
avg_red=720;
avg_green=600;
avg_blue=520;

%caculate the light intensity
I_red=2*amp.*sqrt(1./(1/sig_cone^2+1./sig.^2)).*exp(-(avg-avg_red).^2./(sig_cone^2+sig.^2));
I_blue=2*amp.*sqrt(1./(1/sig_cone^2+1./sig.^2)).*exp(-(avg-avg_blue).^2./(sig_cone^2+sig.^2));
I_green=2*amp.*sqrt(1./(1/sig_cone^2+1./sig.^2)).*exp(-(avg-avg_green).^2./(sig_cone^2+sig.^2));
I_rod=2*amp.*sqrt(1./(1/sig_rod^2+1./sig.^2)).*exp(-(avg-avg_rod).^2./(sig_rod^2+sig.^2));

%需要加一个因子弥补？
figure(1)
subplot(2,3,1)
imshow(I_red)
title('red channel')
subplot(2,3,2)
imshow(I_green)
title('green channel')
subplot(2,3,3)
imshow(I_blue)
title('blue channel')
subplot(2,3,4)
imshow(I_rod)
title('rod channel')
subplot(2,3,5)
imshow(img_name)
title('original image')

