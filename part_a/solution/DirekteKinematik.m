%Direkte Kinematik

clc
clear
close all

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

%Gelenkwinkel

Q = [-109.3, -124.75, -100.81, -14.74, 76.24, -27.91];
Q = deg2rad(Q);                     %Umrechnung in rad

%Berechnung der Transformationsmatrix

A01 = TransMatrix(1, Q(1), DH);
A12 = TransMatrix(2, Q(2), DH);
A23 = TransMatrix(3, Q(3), DH);
A34 = TransMatrix(4, Q(4), DH);
A45 = TransMatrix(5, Q(5), DH);
A56 = TransMatrix(6, Q(6), DH);

A06 = A01 * A12 * A23 * A34 * A45 * A56;

%Berechnung der Position des Endeffektors

POS=GetPos((A06));

%Berechnung der Orientierung des Endeffektors

ANG=GetAng(A06);

%Ausgabe der Ergebnisse

disp("Position:");
disp("X:"+num2str(POS(1)*1000,'%.2f')+" mm");
disp("Y:"+num2str(POS(2)*1000,'%.2f')+" mm");
disp("Z:"+num2str(POS(3)*1000,'%.2f')+" mm");

disp("Rotation:")
disp("theta_x:"+num2str(ANG(1),'%.2f')+"°");
disp("theta_y:"+num2str(ANG(2),'%.2f')+"°");
disp("theta_z:"+num2str(ANG(3),'%.2f')+"°");
