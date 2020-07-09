[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]

Isol3=924;
Isol3.reldelta=0.01;

phi110=1.16;
phi110.reldelta = 0.01;

phi=0.65;
phi.reldelta = 0.01;
phi.min = -1.5;
phi.max = 1.5;

E0 = 2.929e6;
E0.reldelta = 0.01;
E0.min = 0;

Isol2=570;
Isol2.reldelta = 0.01;
Isol2.min=550;


[CONSTRAINTS]

avgx = 0;
avgx.position = 2.2;
avgx.abstol = 100e-6;

stdt = 60e-15;
stdt.position=1.6;
stdt.abstol=10e-15;

[OPTIMIZE]
stdx = 0;
stdx.position = 2.2;
stdx.abstol=1e-5;
