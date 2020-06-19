[OPTIONS]
backtracking = 0 ;

[VARIABLES]
sigma = 0.05e-3;
sigma.reldelta=0.02;
sigma.min = 0.02e-3;
sigma.max = 0.07e-3;
Isol = 3800;
Isol.reldelta = 0.02;
Isol.min = 3500;
Isol.max = 4500;

[OPTIMIZE]
CSgammaz = 0;
CSgammaz.position = 0.25;
CSgammaz.abstol = .02;
#zBz_100 = 0;
#zBz_100.position = 0.25;
#zBz_100.abstol=1e-3;

