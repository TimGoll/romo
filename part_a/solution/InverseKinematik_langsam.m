clc;
clear;
close all;

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
%Startbedingungen
% Qtest = [-109.3, -124.75, -100.81, -14.74, 76.24, -27.91];
% Qtest = deg2rad(Qtest);

Qstart = [RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361)].';
Qstart = deg2rad(Qstart);           %Umrechnung in rad

Wsoll = [-471 -782.73 201.03 -158 -24.48 -179.88].';
Wsoll(1:3) = Wsoll(1:3)./1000;      %Umrechnung in m
Wsoll(4:6) = deg2rad(Wsoll(4:6));   %Umrechnung in rad

Qnew=(Qcalc(Wsoll, Qstart, DH));

W = dk(Qnew,DH);

disp("Gelenkwinkel:")
disp("q1:"+num2str(rad2deg(Qstart(1)),'%.2f')+"°");
disp("q2:"+num2str(rad2deg(Qstart(2)),'%.2f')+"°");
disp("q3:"+num2str(rad2deg(Qstart(3)),'%.2f')+"°");
disp("q4:"+num2str(rad2deg(Qstart(4)),'%.2f')+"°");
disp("q5:"+num2str(rad2deg(Qstart(5)),'%.2f')+"°");
disp("q6:"+num2str(rad2deg(Qstart(6)),'%.2f')+"°");