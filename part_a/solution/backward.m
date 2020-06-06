tbl = [
    [0 128     0      90 ];   %1
    [0 0       -612   0  ];   %2
    [0 0       -572.3 0  ];   %3
    [0 163.941 0      90 ];   %4
    [0 115.7   0      -90];   %5
    [0 92.2    0      0  ];   %6
];

wtcp = [-471 -782.73 201.03 -179.88 -24.48 -158];

q = [0 0 0 0 0 0];

UpdateQ(q, wtcp);

return;

while(true)
    A01 = TransMatrix(1, q(1), tbl);
    A12 = TransMatrix(2, q(2), tbl);
    A23 = TransMatrix(3, q(3), tbl);
    A34 = TransMatrix(4, q(4), tbl);
    A45 = TransMatrix(5, q(5), tbl);
    A56 = TransMatrix(6, q(6), tbl);

    A06 = A01 * A12 * A23 * A34 * A45 * A56;

    wtcp_new = [GetPos(A06) GetAng(A06)];
    
    if ShouldStop(wtcp_new - wtcp)
        break;
    end
    
    q = UpdateQ(q, (wtcp_new - wtcp));
    
    break;
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

function [qNew] = UpdateQ(q, dif)
    syms q1 q2 q3 q4 q5 q6;
    fq = [ 
        [1 0 0 0 0         0                ];
        [0 1 0 0 0         0                ];
        [0 0 1 0 0         0                ];
        [0 0 0 0 -sind(q6) cosd(q6)*cosd(q5)];
        [0 0 0 0 cosd(q6)  sind(q6)*cosd(q5)];
        [0 0 0 1 0         -sind(q5)        ];
    ] * dif';

    disp(fq);

    dfq = jacobian(fq, [q1, q2, q3, q4, q5, q6]);
    
    disp(dfq);
    disp(inv(dfq));
end
