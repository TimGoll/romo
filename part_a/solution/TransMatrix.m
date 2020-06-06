function [A] = TransMatrix(j, ang, tbl)
    A = [
        [cosd(ang + tbl(j, 1))  -sind(ang + tbl(j, 1))*cosd(tbl(j, 4))  sind(ang + tbl(j, 1))*sind(tbl(j, 4))   tbl(j, 3)*cosd(ang + tbl(j, 1))];
        [sind(ang + tbl(j, 1))  cosd(ang + tbl(j, 1))*cosd(tbl(j, 4))   -cosd(ang + tbl(j, 1))*sind(tbl(j, 4))  tbl(j, 3)*sind(ang + tbl(j, 1))];
        [0                      sind(tbl(j, 4))                         cosd(tbl(j, 4))                         tbl(j, 2)                      ];
        [0                      0                                      0                                        1                              ];
    ];
end
