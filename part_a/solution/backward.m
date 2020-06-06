tbl = [
    [0 128     0      pi/2 ];   %1
    [0 0       -612   0    ];   %2
    [0 0       -572.3 0    ];   %3
    [0 163.941 0      pi/2 ];   %4
    [0 115.7   0      -pi/2];   %5
    [0 92.2    0      0    ];   %6
];

wtcp = [-471 -782.73 201.03 -179.88 -24.48 -158];

q = [0 0 0 0 0 0];

while(true)
    A01 = TransMatrix(1, deg2rad(q(1)), tbl);
    A12 = TransMatrix(2, deg2rad(q(2)), tbl);
    A23 = TransMatrix(3, deg2rad(q(3)), tbl);
    A34 = TransMatrix(4, deg2rad(q(4)), tbl);
    A45 = TransMatrix(5, deg2rad(q(5)), tbl);
    A56 = TransMatrix(6, deg2rad(q(6)), tbl);

    A06 = A01 * A12 * A23 * A34 * A45 * A56;

    wtcp_new = [GetPos(A06) GetAng(A06)];
    
    if ShouldStop(wtcp_new - wtcp)
        break;
    end
end

disp("Position:")
disp(q(1:3));

disp("Rotation:")
disp(q(4:6));

%% HELPER FUNCTIONS

function [cancel] = ShouldStop(error)
    for i = 1, size(error, 2)
        if error(i) > 3
            cancel = false;
            
            return
        end
    end
    
    cancel = true;
end

