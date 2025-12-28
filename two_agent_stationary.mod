// ======================================================
// Variables and Shocks
// ======================================================

var cSP cSA c y k i w rK lambda g t A;
varexo epsA;


// ======================================================
// Parameters
// ======================================================

parameters beta delta alpha omega ell gamma_y rhoA sigmaA;

beta    = 0.96;
delta   = 0.06;
alpha   = 0.33;
omega   = 0.30;
ell     = 1/3;
gamma_y = 1.02;
rhoA    = 0.9;
sigmaA  = 0.01;


// ======================================================
// Model
// ======================================================

model;

// Production
y = A * k(-1)^alpha * ell^(1-alpha);

// Factor prices
rK = alpha * y / k(-1);
w  = (1-alpha) * y / ell;

// Fiscal policy
g = 0.2 * y;
t = g;

// Hand-to-mouth households
cSP = w/3 - t;

// Saver households
lambda = 1 / cSA;
1 = beta * (cSA / cSA(+1)) * (rK(+1) + 1 - delta) / gamma_y;

// Capital accumulation (detrended)
k = (1-delta)/gamma_y * k(-1) + i/gamma_y;

// Aggregation
c = omega*cSP + (1-omega)*cSA;

// Resource constraint
y = c + i + g;

// Technology process
log(A) = rhoA*log(A(-1)) + epsA;

end;


// ======================================================
// Steady State
// ======================================================

steady_state_model;

// Technology
A = 1;

// Capital return
rK = gamma_y/beta - (1-delta);

// Capital stock
k  = (alpha*A*ell^(1-alpha)/rK)^(1/(1-alpha));

// Output
y  = A * k^alpha * ell^(1-alpha);

// Investment
i = (gamma_y - (1-delta)) * k;

// Fiscal variables
g = 0.2 * y;
t = g;

// Wage
w = (1-alpha) * y / ell;

// Consumption
cSP = w*ell - t;
cSA = (y - i - g - omega*cSP)/(1-omega);
c   = omega*cSP + (1-omega)*cSA;

// Multiplier
lambda = 1/cSA;

end;


// ======================================================
// Computation
// ======================================================

steady;
check;


// ======================================================
// Shocks
// ======================================================

shocks;
var epsA; stderr sigmaA;
end;


// ======================================================
// Simulation
// ======================================================

stoch_simul(order=2, irf=100, graph_format=pdf);

