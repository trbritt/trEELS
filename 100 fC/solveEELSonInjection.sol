[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]


div = 8e5;
div.reldelta=0.2;
div.min = 0;
div.max = 2e6;

mx = 2.25;
mx.reldelta=0.02;
mx.min = 2.20;
mx.max = 3.00;

mz = 2.75;
mz.reldelta=0.02;
mz.min=2.70;
mz.max=3.5;


[OPTIMIZE]

stdx = 6.079e-4;
stdx.position = 0.6;
stdx.abstol = 1e-5;

stdz = 9.9148e-4;
stdz.position = 0.6;
stdz.abstol = 1e-5;





