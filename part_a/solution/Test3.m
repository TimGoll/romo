clc;
clear;
close all;

tbl = [
    [0 128     0      90 ];   %1
    [0 0       -612   0  ];   %2
    [0 0       -572.3 0  ];   %3
    [0 163.941 0      90 ];   %4
    [0 115.7   0      -90];   %5
    [0 92.2    0      0  ];   %6
];

tbl(:,4) = deg2rad(tbl(:,4));
Qtest = [-109.3, -124.75, -100.81, -14.74, 76.24, -27.91];
Qstart = [-108,-124,-100,-14,76,-27]';
Qstart =deg2rad(Qstart);

disp(Qstart);
wtcptest = [-471 -782.73 201.03 -179.88 -24.48 -158];

Qnew=abs(Qcalc(wtcptest,Qstart,tbl));

disp(Qnew);
while not(isequal(Qstart,Qnew))
Qstart=Qnew;
Qnew=abs(Qcalc(wtcptest,Qstart,tbl));
disp(Qnew);
end
Disp(rad2deg(Qnew));
W=fk(tbl,Qnew);
Disp(W);