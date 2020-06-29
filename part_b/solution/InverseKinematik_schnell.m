%Inverse Kinematik

clc;
clear;
close all;

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
%Startbedingungen
% Qtest = [-109.3, -124.75, -100.81, -14.74, 76.24, -27.91];
% Qtest = deg2rad(Qtest);

Qstart = [RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361)].';
Qstart = deg2rad(Qstart);           %Umrechnung in rad

Wsoll = [-471 -782.73 201.03 -158 -24.48 -179.88].';
Wsoll(1:3) = Wsoll(1:3)./1000;      %Umrechnung in m
Wsoll(4:6) = deg2rad(Wsoll(4:6));   %Umrechnung in rad


while(true)
    
    %Berechnung der Transformationsmatrizen
  
    A01 = TransMatrix(1, Qstart(1), DH);
    A12 = TransMatrix(2, Qstart(2), DH);
    A23 = TransMatrix(3, Qstart(3), DH);
    A34 = TransMatrix(4, Qstart(4), DH);
    A45 = TransMatrix(5, Qstart(5), DH);
    A56 = TransMatrix(6, Qstart(6), DH);
    
    A02 = A01 * A12;
    A03 = A01 * A12 * A23;
    A04 = A01 * A12 * A23 * A34;
    A05 = A01 * A12 * A23 * A34 * A45;
    A06 = A01 * A12 * A23 * A34 * A45 * A56;
    
    %Berechnen der Endefektor Position
            
    X = A06(1,4);
    Y = A06(2,4);
    Z = A06(3,4);
    
    %Berechnen der Endefektor Orientierung

    theta_x = atan2(A06(3,2),A06(3,3));
    theta_y = asin(-A06(3,1));
    theta_z = atan2(A06(2,1), A06(1,1));

    Wist = [X Y Z theta_x theta_y theta_z].';
    
    %Berechnung des Fehlers
    
    f = Wist-Wsoll;
    
    if ShouldStop((f))            
            break
    end
    
    %Berechnung der Korrekturmatrix
    
    T_korr=eye(3);    
    T_korr(1,1)=cos(theta_z)*cos(theta_y);
    T_korr(1,2)=-sin(theta_z);
    T_korr(2,1)=sin(theta_z)*cos(theta_y);
    T_korr(2,2)=cos(theta_z);
    T_korr(3,1)=-sin(theta_y);
       
    H1=eye(6);
    H1(4:6,4:6)=T_korr;  
    
    %Berechnung der Jacobi Matrix
        
    J_v = [cross([0;0;1],A06(1:3,4)) cross(A01(1:3,3),A06(1:3,4)-A01(1:3,4)) cross(A02(1:3,3),A06(1:3,4)-A02(1:3,4)) cross(A03(1:3,3),A06(1:3,4)-A03(1:3,4)) cross(A04(1:3,3),A06(1:3,4)-A04(1:3,4)) cross(A05(1:3,3),A06(1:3,4)-A05(1:3,4))];
    J_w = [[0;0;1] A01(1:3,3) A02(1:3,3) A03(1:3,3) A04(1:3,3) A05(1:3,3)];
    J = [ J_v ; J_w];
        
    %Berechnung der neuen Gelenkwinkel
    
%     Qstart = Qstart - inv(J)*H1*f;
    Qstart = Qstart - mldivide(J,H1*f);
%     roboplot(Qstart);
%     pause(.1)
end

disp("Position:");
disp("X:"+num2str(Wist(1)*1000,'%.2f')+" mm");
disp("Y:"+num2str(Wist(2)*1000,'%.2f')+" mm");
disp("Z:"+num2str(Wist(3)*1000,'%.2f')+" mm");
disp("Rotation:")
disp("theta_x:"+num2str(rad2deg(Wist(4)),'%.2f')+"°");
disp("theta_y:"+num2str(rad2deg(Wist(5)),'%.2f')+"°");
disp("theta_z:"+num2str(rad2deg(Wist(6)),'%.2f')+"°");

disp("Gelenkwinkel:")
disp("q1:"+num2str(mod(rad2deg(Qstart(1)),360),'%.2f')+"°");
disp("q2:"+num2str(mod(rad2deg(Qstart(2)),360),'%.2f')+"°");
disp("q3:"+num2str(mod(rad2deg(Qstart(3)),360),'%.2f')+"°");
disp("q4:"+num2str(mod(rad2deg(Qstart(4)),360),'%.2f')+"°");
disp("q5:"+num2str(mod(rad2deg(Qstart(5)),360),'%.2f')+"°");
disp("q6:"+num2str(mod(rad2deg(Qstart(6)),360),'%.2f')+"°");
        