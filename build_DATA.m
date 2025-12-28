T = readtable('data.xls');

TB3MS = T.TB3MS;
GDP   = T.GDPC1;
PCE   = T.PCE;
PCEPI = T.PCEPI;

C_real = (PCE ./ PCEPI) * 100;

gy = diff(log(GDP));
gc = diff(log(C_real));
r  = TB3MS(2:end) / 100 / 4;

data = [gy gc r];

save DATA1.mat data

load DATA1.mat   % carica data

gy = data(:,1);
gc = data(:,2);
r  = data(:,3);

save DATA1.mat gy gc r


