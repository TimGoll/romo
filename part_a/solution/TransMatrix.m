function [A] = TransMatrix(j, ang, tbl)
    A = [
        [cos(ang + tbl(j, 1))  -sin(ang + tbl(j, 1))*cos(tbl(j, 4))  sin(ang + tbl(j, 1))*sin(tbl(j, 4))   tbl(j, 3)*cos(ang + tbl(j, 1))];
        [sin(ang + tbl(j, 1))  cos(ang + tbl(j, 1))*cos(tbl(j, 4))   -cos(ang + tbl(j, 1))*sin(tbl(j, 4))  tbl(j, 3)*sin(ang + tbl(j, 1))];
        [0                     sin(tbl(j, 4))                        cos(tbl(j, 4))                        tbl(j, 2)                     ];
        [0                     0                                     0                                     1                             ];
    ];
end
