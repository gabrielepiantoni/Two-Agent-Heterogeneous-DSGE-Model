// =====================================================
// 1. DECLARATIONS
// =====================================================

var cSP cSA c y k i w rK lambda g t A gy gc r;
varexo epsA;

parameters beta delta alpha omega ell gamma_y rhoA sigmaA;


// =====================================================
// 2. PARAMETER VALUES
// =====================================================

beta    = 0.96;
delta   = 0.06;
alpha   = 0.33;
omega   = 0.30;
ell     = 1/3;
gamma_y = 1.02;
rhoA    = 0.9;
sigmaA  = 0.01;


// =====================================================
// 3. MODEL
// =====================================================

model;

// ---------- Production and Prices ----------

y  = A * k(-1)^alpha * ell^(1-alpha);
rK = alpha * y / k(-1);
w  = (1-alpha) * y / ell;


// ---------- Government ----------

g = 0.2 * y;
t = g;


// ---------- Households ----------

cSP = w*ell - t;

lambda = 1 / cSA;

1 = beta * (cSA / cSA(+1)) * (rK(+1) + 1 - delta) / gamma_y;


// ---------- Capital Accumulation ----------

k = (1-delta)/gamma_y * k(-1) + i/gamma_y;


// ---------- Aggregation and Market Clearing ----------

c = omega*cSP + (1-omega)*cSA;
y = c + i + g;


// ---------- Technology ----------

log(A) = rhoA * log(A(-1)) + epsA;


// =====================================================
// 4. OBSERVABLES FOR SMM
// =====================================================

// Output growth
gy = log(gamma_y) + log(y) - log(y(-1));

// Consumption growth
gc = log(gamma_y) + log(c) - log(c(-1));

// Net interest rate
r = rK - delta;

end;


// =====================================================
// 5. STEADY STATE
// =====================================================

steady_state_model;

A  = 1;

rK = gamma_y/beta - (1-delta);
k  = (alpha*A*ell^(1-alpha)/rK)^(1/(1-alpha));
y  = A * k^alpha * ell^(1-alpha);

i = (gamma_y - (1-delta)) * k;
g = 0.2 * y;
t = g;

w = (1-alpha) * y / ell;

cSP = w/3 - t;
cSA = (y - i - g - omega*cSP)/(1-omega);
c   = omega*cSP + (1-omega)*cSA;

lambda = 1/cSA;

gy = log(gamma_y);
gc = log(gamma_y);
r  = rK - delta;

end;

steady;
check;


// =====================================================
// 6. SHOCKS
// =====================================================

shocks;
    var epsA; stderr 1;
end;
