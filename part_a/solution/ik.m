function [ik] = ik(q, dif)
    syms q1 q2 q3 q4 q5 q6
    
    qsim = [q1, q2, q3, q4, q5, q6];
        
    fq = [ 
        [1 0 0 0 0                  0                                ];
        [0 1 0 0 0                  0                                ];
        [0 0 1 0 0                  0                                ];
        [0 0 0 0 -sin(q6)           cos(q6)*cos(q5)                  ];
        [0 0 0 0 cos(q6)            sin(q6)*cos(q5)                  ];
        [0 0 0 1 0                 -sin(q5)                          ];
    ] * dif';

    dfq = jacobian(fq, [q1, q2, q3, q4, q5, q6]);
    
    dfqi = inv(dfq);
    
    part1 = double(subs(dfqi, qsim, q));
    part2 = double(subs(fq, qsim, q));
    
    disp(part1);
    disp(part2);
    disp(fq);
    disp(dfqi);
    ik = q - part1 * part2;
end