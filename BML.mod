var cSP cSA c y k i w rK lambda g t A
    gy gc r;

varexo etaA etaG;

parameters beta delta alpha omega ell gamma_y rhoA rhoG Gbar;

beta    = 0.9959;
delta   = 0.06;
alpha   = 0.33;
omega   = 0.8497;
ell     = 1/3;
gamma_y = 1.0073;
rhoA    = 0.9382;
rhoG    = 0.50;
Gbar    = 0.2;

model;

y = A * k(-1)^alpha * ell^(1-alpha);

rK = alpha * y / k(-1);
w  = (1-alpha) * y / ell;

g = Gbar * y + etaG;
t = g;

cSP = w/3 - t;

cSA + i = rK * k(-1) + w*(2/3) - t;

lambda = 1 / cSA;

1 = beta * (cSA / cSA(+1)) * (rK(+1) + 1 - delta) / gamma_y;

k = (1-delta)/gamma_y * k(-1) + i/gamma_y;

c = omega*cSP + (1-omega)*cSA;

log(A) = rhoA * log(A(-1)) + etaA;

gy = log(y) - log(y(-1));
gc = log(c) - log(c(-1));
r  = rK - delta;

end;

steady_state_model;

A = 1;

rK = gamma_y/beta - (1-delta);
k  = (alpha*A*ell^(1-alpha)/rK)^(1/(1-alpha));
y  = A * k^alpha * ell^(1-alpha);

i = (gamma_y - (1-delta)) * k;
g = Gbar * y;
t = g;

w = (1-alpha) * y / ell;

cSP = w/3 - t;
cSA = rK*k + w*(2/3) - t - i;
c   = omega*cSP + (1-omega)*cSA;

lambda = 1/cSA;

gy = 0;
gc = 0;
r  = rK - delta;

end;

steady;
check;

shocks;
    var etaA; stderr 0.008;
    var etaG; stderr 0.01;
end;

varobs gy gc;

estimated_params;
    rhoA , 0.85 , 0.5 , 0.95 , beta_pdf , 0.85 , 0.05;
    rhoG , 0.50 , 0 , 0.99 , beta_pdf , 0.8 , 0.1;
    stderr etaA , 0.008 , 1e-6 , 0.1 , inv_gamma2_pdf , 0.01 , 0.05;
    stderr etaG , 0.01 , 1e-6 , 0.1 , inv_gamma2_pdf , 0.01 , 0.05;
end;

estimation(
    datafile='DATA1_DT.mat',
    order=1,
    mode_compute=6,
    mh_replic=2000,
    mh_drop=0.3
);

shock_decomposition gy gc;
