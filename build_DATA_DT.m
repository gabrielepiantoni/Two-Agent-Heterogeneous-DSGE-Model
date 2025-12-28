T = readtable('data.xls');

TB3MS = T.TB3MS;
GDP   = T.GDPC1;
PCE   = T.PCE;
PCEPI = T.PCEPI;

% --------------------
% REAL VARIABLES
% --------------------

C_real = (PCE ./ PCEPI) * 100;

y = log(GDP);
c = log(C_real);

time = (1:length(y))';

% --------------------
% LINEAR DETRENDING
% --------------------

y_trend = [ones(size(time)) time] \ y;
c_trend = [ones(size(time)) time] \ c;

y_dt = y - (y_trend(1) + y_trend(2)*time);
c_dt = c - (c_trend(1) + c_trend(2)*time);

% mean zero (numerical)
y_dt = y_dt - mean(y_dt);
c_dt = c_dt - mean(c_dt);

% --------------------
% INTEREST RATE
% --------------------

r = TB3MS / 100 / 4;
r = r - mean(r);

% align sample
y_dt = y_dt(2:end);
c_dt = c_dt(2:end);
r    = r(2:end);

% --------------------
% SAVE DATA
% --------------------

save DATA1_DT.mat y_dt c_dt r
gy = y_dt;
gc = c_dt;

save DATA1_DT.mat gy gc r