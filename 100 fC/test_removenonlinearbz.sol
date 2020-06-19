[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]
div=1e5;
div.reldelta=0.1;
div.min=1e2;

phi=1.48;
phi.reldelta = 0.1;
phi.min = -1.5;
phi.max = 1.5;

Isol2=568;
Isol2.reldelta = 0.1;
Isol2.min=500;

E0 = 2.9e6;
E0.reldelta = 0.2;
E0.min = 0;




[CONSTRAINTS]

avgx = 0;
avgx.position = 1.6;
avgx.abstol = 100e-6;



[OPTIMIZE]

nemizrms=50e-12;
nemizrms.abstol=20e-12;
nemizrms.position=0.6;


stdt = 60e-15;
stdt.position=1.6;
stdt.abstol=10e-15;