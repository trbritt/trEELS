[OPTIONS]
backtracking = 0 ;

[VARIABLES]
E0 = 1.5e6;
E0.reldelta = 0.002;
E0.min = 0;
phi=-0.7621;
phi.reldelta = 0.01;
phi.min = -1.5;
phi.max = 0;
Isol2=649.7;
Isol2.reldelta = 0.01;
Isol2.min=500;


[OPTIMIZE]
stdt = 100e-15;
#stdt = 60e-15;
stdt.position=1.6;
#stdt.abstol=5e-15;
stdt.abstol=10e-15;

#[CONSTRAINTS]
#avgx = 0;
#avgx.position = 1.6;
#avgx.abstol = 50e-6;

