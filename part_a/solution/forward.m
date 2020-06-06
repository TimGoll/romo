tbl = [
    [0 128     0      pi/2 ];   %1
    [0 0       -612   0    ];   %2
    [0 0       -572.3 0    ];   %3
    [0 163.941 0      pi/2 ];   %4
    [0 115.7   0      -pi/2];   %5
    [0 92.2    0      0    ];   %6
];

A01 = TransMatrix(1, deg2rad(-109.3), tbl);
A12 = TransMatrix(2, deg2rad(-124.75), tbl);
A23 = TransMatrix(3, deg2rad(-100.81), tbl);
A34 = TransMatrix(4, deg2rad(-14.74), tbl);
A45 = TransMatrix(5, deg2rad(76.24), tbl);
A56 = TransMatrix(6, deg2rad(-27.91), tbl);

A06 = A01 * A12 * A23 * A34 * A45 * A56;

POS=GetPos((A06));
ANG=GetAng(A06);
disp("Position:");
disp("X:"+num2str(POS(1),'%.2f')+" mm");
disp("Y:"+num2str(POS(2),'%.2f')+" mm");
disp("Z:"+num2str(POS(3),'%.2f')+" mm");
disp("Rotation:")
disp("α:"+num2str(ANG(1),'%.2f')+"°");
disp("β:"+num2str(ANG(2),'%.2f')+"°");
disp("γ:"+num2str(ANG(3),'%.2f')+"°");
