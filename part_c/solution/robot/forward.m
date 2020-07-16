function p = forward(q)

    %Denavit-Hartenberg Parameter
    DH = [
        [0 128     0      90 ];   %1
        [0 0       -612   0  ];   %2
        [0 0       -572.3 0  ];   %3
        [0 163.941 0      90 ];   %4
        [0 115.7   0      -90];   %5
        [0 92.2    0      0  ];   %6
    ];

    DH(:, [1 4]) = deg2rad(DH(:, [1 4])); %Umrechnung in rad
    DH(:, [2 3]) = DH(:,[2 3]) ./ 1000;    %Umrechnung in m

    q = deg2rad(q);

    %Berechnung der Transformationsmatrix
    A01 = TransMatrix(1, q(1), DH);
    A12 = TransMatrix(2, q(2), DH);
    A23 = TransMatrix(3, q(3), DH);
    A34 = TransMatrix(4, q(4), DH);
    A45 = TransMatrix(5, q(5), DH);
    A56 = TransMatrix(6, q(6), DH);

    A06 = A01 * A12 * A23 * A34 * A45 * A56;
    
    p(1:3,1) = GetPos(A06)';
    p(4:6,1) = GetAng(A06)';
    
end
