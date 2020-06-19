[OPTIONS]
backtracking = 0 ;

[VARIABLES]
E0 = 1.5e6;
E0.reldelta = 0.02;
E0.min = 0;
phi=-0.7468;
phi.reldelta = 0.1;
phi.min = -1.5;
phi.max = 0;
Isol2=649.7;
Isol2.reldelta = 0.1;
Isol2.min=500;
Isol3=922.7;
Isol3.reldelta=0.002;
phi110=0.39;
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
