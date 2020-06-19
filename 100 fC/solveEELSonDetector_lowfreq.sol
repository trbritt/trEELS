[OPTIONS]
backtracking = 0 ;

[VARIABLES]
E0 = 2.93e6;
E0.reldelta = 0.02;
E0.min = 0;
phi=0.36;
phi.reldelta = 0.01;
phi.min = -1.5;
phi.max = 1.5;
Isol2=666.06;
Isol2.reldelta = 0.01;
Isol2.min=500;
Isol3=922.7;
Isol3.reldelta=0.02;
phi110=0.15;
phi110.reldelta = 0.01;

[CONSTRAINTS]
stdt = 60e-15;
stdt.position=1.6;
stdt.abstol=10e-15;
avgx = 0;
avgx.position = 1.6;
avgx.abstol = 100e-6;

[OPTIMIZE]
stdx = 0;
stdx.position = 2.2;
stdx.abstol=1e-5;
