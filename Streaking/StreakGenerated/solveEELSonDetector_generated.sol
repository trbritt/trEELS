[OPTIONS]
backtracking = 0 ;
forcejacobian = 1 ;

[VARIABLES]
stdGBx = 8e-4;
stdGBx.reldelta = 0.01;
stdGBx.min = 7e-4;
stdGBx.max = 2.15e-3;

zdiv = 2e7;
zdiv.reldelta = 0.01;
zdiv.min = 1e4;

scalex = 1.2;
scalex.reldelta = 0.01;
scalex.min = 1.0;

stdr = 5.96e-4;
stdr.reldelta = 0.01;
stdr.min = 0;

xydiv = 15;
xydiv.reldelta = 0.01;
xydiv.min = 5;

phi110=1.46;
phi110.reldelta = 0.01;

Isol3=922;
Isol3.reldelta=0.01;


[OPTIMIZE]
stdx = 0;
stdx.position = 2.2;
stdx.abstol=1e-5;