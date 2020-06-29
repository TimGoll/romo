%Direkte Kinematik als Funktion

function dk(Q,DH)

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


end