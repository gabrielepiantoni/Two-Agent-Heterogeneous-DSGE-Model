load DATA1.mat

figure
subplot(3,1,1)
plot(r)
title('r')

subplot(3,1,2)
plot(gy)
hold on
yline(mean(gy),'--')
title('gy')

subplot(3,1,3)
plot(gc)
hold on
yline(mean(gc),'--')
title('gc')