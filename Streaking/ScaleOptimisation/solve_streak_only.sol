[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]
phi110=-0.146;
phi110.reldelta = 0.01;

Isol3=922;
Isol3.reldelta=0.01;


#[CONSTRAINTS]

#avgx = 0;
#avgx.position = 2.2;
#avgx.abstol = 100e-6;


[OPTIMIZE]
stdx = 0;
stdx.position = 2.2;
stdx.abstol=1e-5;