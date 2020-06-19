[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]

phi=1.48;
phi.reldelta = 0.01;
phi.min = -1.5;
phi.max = 1.5;

Isol2=568;
Isol2.reldelta = 0.01;
Isol2.min=500;

E0 = 2.9e6;
E0.reldelta = 0.02;
E0.min = 0;

phi110=0.251;
phi110.reldelta = 0.01;

Isol3=967.21;
Isol3.reldelta=0.02;


[CONSTRAINTS]

avgx = 0;
avgx.position = 1.6;
avgx.abstol = 100e-6;

stdt = 60e-15;
stdt.position=1.6;
stdt.abstol=10e-15;


[OPTIMIZE]
stdx = 0;
stdx.position = 2.2;
stdx.abstol=1e-5;


