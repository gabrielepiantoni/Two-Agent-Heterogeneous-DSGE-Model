@#include "two_agent_stationary_SMM.inc"


// =====================================================
// PARAMETERS TO ESTIMATE (SMM)
// =====================================================

estimated_params;
beta     , 0.96 ;
gamma_y , 1.02 ;
stderr epsA , 0.01 ;
rhoA    , 0.9 , 0 , 1 ;
omega   , 0.30 , 0 , 1 ;
end;

estimated_params_init(use_calibration);
end;


// =====================================================
// OBSERVED VARIABLES
// =====================================================

varobs
gy
gc
r
;


// =====================================================
// MOMENTS TO MATCH
// =====================================================

matched_moments;

gy;
gc;

gy*gy;
gc*gc;

r;

end;


// =====================================================
// METHOD OF SIMULATED MOMENTS
// =====================================================

method_of_moments(
      mom_method = SMM
    , datafile = 'DATA1.mat'

    , order      = 2
    , pruning

    , weighting_matrix = ['DIAGONAL','OPTIMAL']
    , simulation_multiple = 5

    , mode_compute = 4
    , additional_optimizer_steps = [13]

    , optim = ('TolFun',1e-6,'TolX',1e-6)

    , mode_check
);
