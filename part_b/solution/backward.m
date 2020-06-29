syms q1 q2 q3 q4 q5 q6

tbl = [
    [0 128     0      90 ];   %1
    [0 0       -612   0  ];   %2
    [0 0       -572.3 0  ];   %3
    [0 163.941 0      90 ];   %4
    [0 115.7   0      -90];   %5
    [0 92.2    0      0  ];   %6
];

wtcp = [-471 -782.73 201.03 -179.88 -24.48 -158];

q = [45 45 45 45 45 45];
qtest = [-109.3, -124.75, -100.81, -14.74, 76.24, -27.91];
qsim = [q1, q2, q3, q4, q5, q6];

while(true)
    A01 = TransMatrix(1, qsim(1), tbl);
    A12 = TransMatrix(2, qsim(2), tbl);
    A23 = TransMatrix(3, qsim(3), tbl);
    A34 = TransMatrix(4, qsim(4), tbl);
    A45 = TransMatrix(5, qsim(5), tbl);
    A56 = TransMatrix(6, qsim(6), tbl);

    A06 = A01 * A12 * A23 * A34 * A45 * A56;
    
    wtpc_new_sym = [GetPos(A06) GetAngSym(A06)];
    
    ASubs = double(subs(A06, qsim, q));
    wtcp_new = [GetPos(ASubs) GetAng(ASubs)];

    if ShouldStop(wtcp_new - wtcp)
        break;
    end
    
    q = UpdateQ(q, wtpc_new_sym, (wtpc_new_sym - wtcp));
    
    disp(q);
    
    return;
end

disp("Position:")
disp(q(1:3));

disp("Rotation:")
disp(q(4:6));

%% HELPER FUNCTIONS

function [cancel] = ShouldStop(error)
    for i = 1 : 3
        if error(i) > 3
            cancel = false;
            
            return
        end
    end
    
    for i = 4 : 6
        if error(i) > 3 %3/180*pi
            cancel = false;
            
            return
        end
    end
    
    cancel = true;
end

function [qNew] = UpdateQ(q, wtpc_sym, dif)
    syms q1 q2 q3 q4 q5 q6
    
    qsim = [q1, q2, q3, q4, q5, q6];
    
    fq = [ 
        [1 0 0 0 0                 0                                ];
        [0 1 0 0 0                 0                                ];
        [0 0 1 0 0                 0                                ];
        [0 0 0 0 -sin(wtpc_sym(6)) cos(wtpc_sym(6))*cos(wtpc_sym(5))];
        [0 0 0 0 cos(wtpc_sym(6))  sin(wtpc_sym(6))*cos(wtpc_sym(5))];
        [0 0 0 1 0                 -sin(wtpc_sym(5))                ];
    ] * dif';

    dfq = jacobian(fq, [q1, q2, q3, q4, q5, q6]);
    dfqi = inv(dfq);
    
    part1 = double(subs(dfqi, qsim, q));
    part2 = double(subs(fq, qsim, q));
    
    disp(part1);
    disp(part2);
    
    qNew = q - part1 * part2;
end
