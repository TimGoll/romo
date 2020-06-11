%Berechnen der Transformationsmatrix am Gelenk j mit den Gelenkwinkeln ang
%und den Denavit-Hartenberg Parametern DH

function [A] = TransMatrix(j, ang, DH)
    A = [
        [cos(ang + DH(j, 1))  -sin(ang + DH(j, 1))*cos(DH(j, 4))  sin(ang + DH(j, 1))*sin(DH(j, 4))   DH(j, 3)*cos(ang + DH(j, 1))];
        [sin(ang + DH(j, 1))  cos(ang + DH(j, 1))*cos(DH(j, 4))   -cos(ang + DH(j, 1))*sin(DH(j, 4))  DH(j, 3)*sin(ang + DH(j, 1))];
        [0                    sin(DH(j, 4))                       cos(DH(j, 4))                       DH(j, 2)                    ];
        [0                    0                                   0                                   1                           ];
    ];
end
