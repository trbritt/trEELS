[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]
E0 = 1.39e6;
E0.reldelta = 0.002;
E0.min = 0;
phi=-0.7268;
phi.reldelta = 0.001;
phi.min = -1.5;
phi.max = 0;
#Isol2=609.7;
Isol2=646.2;
Isol2.reldelta = 0.001;
Isol2.min=500;
Isol3=802.1;
Isol3.reldelta=0.0002;
Isol3.max=803.0;
phi110=0.3139;
phi110.reldelta = 0.001;

[CONSTRAINTS]
#stdt = 50e-15;
#stdt.position=1.6;
#stdt.abstol=10e-15;

CSalphaz = 0;
CSalphaz.position=1.6;
CSalphaz.abstol = 0.1;

avgx = 0;
avgx.position = 1.6;
avgx.abstol = 100e-6;

[OPTIMIZE]
#stdx = 0;
#stdx.position = 2.2;
#stdx.abstol=1e-5;
CSalphax = 0;
CSalphax.position=2.2;
CSalphax.abstol=0.1;
