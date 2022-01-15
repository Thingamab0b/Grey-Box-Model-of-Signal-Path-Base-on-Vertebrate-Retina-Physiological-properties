%三维图像
X = -100 : 1 : 100;
Y = -100 : 1 : 100;

sigma1 = 10;
[ XX, YY ] = meshgrid( X, Y );
Z1 = ( XX ).^2 + ( YY ).^2; 
Z1 = -Z1 / ( 2 * sigma1^2 );
Z1 = exp(Z1) / ( 2 * pi * sigma1^2 );

sigma2 = 20;
Z2 = ( XX ).^2 + ( YY ).^2;
Z2 = -Z2 / ( 2 * sigma2^2 );
Z2 = 0.8.*exp(Z2) / ( 2 * pi * sigma2^2 );

Z=Z1-Z2;
mesh(X, Y, Z); 


%二维图
x=-100:100
sigma1 = 10;
sigma2 = 20;
plot(x,exp(-(x.^2)/sigma1.^2),'r','LineWidth',3);
hold on
plot(x,0.5*exp(-(x.^2)/sigma2.^2),'b','LineWidth',3);
plot(x,exp(-(x.^2)/sigma1.^2)-0.5*exp(-(x.^2)/sigma2.^2),'k','LineWidth',3);
legend('+','-','sum')

%颜色拮抗
hold off
plot(x,exp(-(x.^2)/sigma1.^2)-0.5*exp(-(x.^2)/sigma2.^2),'r','LineWidth',3);
hold on
plot(x,-exp(-(x.^2)/sigma1.^2)+0.5*exp(-(x.^2)/sigma2.^2),'g','LineWidth',3);
legend('red','green')
