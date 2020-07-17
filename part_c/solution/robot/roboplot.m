function roboplot(Q)

%Denavit-Hartenberg Parameter

DH = [
    [0 128     0      90 ];   %1
    [0 0       -612   0  ];   %2
    [0 0       -572.3 0  ];   %3
    [0 163.941 0      90 ];   %4
    [0 115.7   0      -90];   %5
    [0 92.2    0      0  ];   %6
];
DH(:,[1 4]) = deg2rad(DH(:,[1 4])); %Umrechnung in rad
DH(:,[2 3]) = DH(:,[2 3])./1000;    %Umrechnung in m


Q = deg2rad(Q);                     %Umrechnung in rad

A01 = TransMatrix(1, Q(1), DH);
A12 = TransMatrix(2, Q(2), DH);
A23 = TransMatrix(3, Q(3), DH);
A34 = TransMatrix(4, Q(4), DH);
A45 = TransMatrix(5, Q(5), DH);
A56 = TransMatrix(6, Q(6), DH);

A02 = A01 * A12;
A03 = A01 * A12 * A23;
A04 = A01 * A12 * A23 * A34;
A05 = A01 * A12 * A23 * A34 * A45;
A06 = A01 * A12 * A23 * A34 * A45 * A56;

O = [0  ;0  ;0  ];

P0 = O;
P1 = GetPos(A01);
P2 = GetPos(A02);
P3 = GetPos(A03);
P4 = GetPos(A04);
P5 = GetPos(A05);
P6 = GetPos(A06);


plot3([P0(1) P1(1) P2(1) P3(1) P4(1) P5(1) P6(1)],[P0(2) P1(2) P2(2) P3(2) P4(2) P5(2) P6(2)],[P0(3) P1(3) P2(3) P3(3) P4(3) P5(3) P6(3)]);
hold on;
grid on

plotKS([1 0 0 0; 0 1 0 0; 0 0 1 0]);
text(0,0,0,'KS0');

plotKS(A01);
text(P1(1),P1(2),P1(3),'KS1');

plotKS(A02);
text(P2(1),P2(2),P2(3),'KS2');

plotKS(A03);
text(P3(1),P3(2),P3(3),'KS3');

plotKS(A04);
text(P4(1),P4(2),P4(3),'KS4');

plotKS(A05);
text(P5(1),P5(2),P5(3),'KS5');

plotKS(A06);
text(P6(1),P6(2),P6(3),'KS6');
hold off;
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
end