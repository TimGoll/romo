syms f(q1, q2, q3, q4, q5, q6) 6;

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

    A = double(subs(A06, qsim, qtest));

    %disp(A06);

    %A = subs(A06, qsim, qtest);
    %A2 = simplify(A);
    
    wtcp_new = [GetPos(A) GetAng(A)];
    
    disp(wtcp_new);
    
    return;
    
    %if ShouldStop(wtcp_new - wtcp)
    %    break;
    %end
    
    %q = UpdateQ(q, (wtcp_new - wtcp));
end

%disp("Position:")
%disp(q(1:3));

%disp("Rotation:")
%disp(q(4:6));

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
    fq = [ 
        [1 0 0 0 0         0                ];
        [0 1 0 0 0         0                ];
        [0 0 1 0 0         0                ];
        [0 0 0 0 -sind(q6) cosd(q6)*cosd(q5)];
        [0 0 0 0 cosd(q6)  sind(q6)*cosd(q5)];
        [0 0 0 1 0         -sind(q5)        ];
    ] * dif';

    %disp(fq);

    dfq = jacobian(fq, [q1, q2, q3, q4, q5, q6]);
    
    %disp(dfq);
    %disp(inv(dfq));
end
