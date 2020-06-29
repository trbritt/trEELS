[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]
Isol2=600;
Isol2.reldelta = 0.01;
Isol2.min=600;

phi=0.65;
phi.reldelta = 0.01;
phi.min = -1.5;
phi.max = 1.5;

E0 = 2.93e6;
E0.reldelta = 0.01;
E0.min = 0;

Isol3=915;
Isol3.reldelta=0.01;

phi110=1.16;
phi110.reldelta = 0.01;

[CONSTRAINTS]

avgx = 0;
avgx.position = 2.2;
avgx.abstol = 100e-6;


[OPTIMIZE]
stdx = 0;
stdx.position = 2.2;
stdx.abstol=1e-5;

stdt = 60e-15;
stdt.position=1.6;
stdt.abstol=10e-15;