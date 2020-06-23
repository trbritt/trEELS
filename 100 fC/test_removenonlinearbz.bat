mr -o start_test.gdf EELS.mr gpt test_removenonlinearbz.in div=1e5 N=10000
gdfa -o startStds_test.gdf start_test.gdf time avgz stdx stdz avgBz avgG nemixrms nemizrms stdG stdzs

gdfsolve -v -o sol_ideal_test.gdf test_removenonlinearbz.sol mr EELS.mr gpt test_removenonlinearbz.in N=10000 B0=3e-3 outputT=0 outputZ=2.2 sc=1 streak=1
gdf2a -w 16 -v -o sol_ideal_test.txt sol_ideal_test.gdf