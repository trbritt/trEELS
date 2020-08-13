[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]
phi110=0.592;
phi110.reldelta = 0.01;

Isol3=922;
Isol3.reldelta=0.01;

sx = 1.21;
sx.reldelta = 0.01;

sy = 1.49;
sy.reldelta = 0.01;

sz = 1.0;
sz.reldelta = 0.01;

sBx = 1.44;
sBx.reldelta = 0.01;

sBy = 1.93;
sBy.reldelta = 0.01;

sBz = 1.0;
sBz.reldelta = 0.01;

[CONSTRAINTS]

avgx = 0;
avgx.position = 2.2;
avgx.abstol = 100e-6;


[OPTIMIZE]
stdx = 0;
stdx.position = 2.2;
stdx.abstol=1e-5;