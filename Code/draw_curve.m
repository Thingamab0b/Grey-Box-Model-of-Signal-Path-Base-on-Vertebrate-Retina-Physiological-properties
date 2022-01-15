lambda=390:780;
sig=60;
sig_rod=200;
rod=500;
blue=450;
green=530;
red=560;
hold on
plot(lambda,exp(-((lambda-rod).^2)/sig_rod.^2),'k','LineWidth',3);
plot(lambda,exp(-((lambda-red).^2)/sig.^2),'r','LineWidth',3);
plot(lambda,exp(-((lambda-green).^2)/sig.^2),'g','LineWidth',3);
plot(lambda,exp(-((lambda-blue).^2)/sig.^2),'b','LineWidth',3);
legend('rod','L cone','M cone','S cone');

