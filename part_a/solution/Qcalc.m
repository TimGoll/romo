function [Qcalc] = Qcalc(Wsoll, Qstart, tbl)
    Wsoll(4:6) = [deg2rad(Wsoll(4)) deg2rad(Wsoll(5)) deg2rad(Wsoll(6))];

    syms q1 q2 q3 q4 q5 q6 real

    q = [q1 q2 q3 q4 q5 q6];   
    for i = 1:6
            A = [
                [cos(q(i))  -sin(q(i))*cos(tbl(i, 4))  sin(q(i))*sin(tbl(i, 4))   tbl(i, 3)*cos(q(i))];
                [sin(q(i))  cos(q(i))*cos(tbl(i, 4))   -cos(q(i))*sin(tbl(i, 4))  tbl(i, 3)*sin(q(i))];
                [0          sin(tbl(i, 4))             cos(tbl(i, 4))             tbl(i, 2)          ];
                [0          0                          0                          1                  ];
            ];

            T(:,:,i) = A;
    end
        
    A06 = T(:,:,1)*T(:,:,2)*T(:,:,3)*T(:,:,4)*T(:,:,5)*T(:,:,6);
    
    X = A06(1,4);
    Y = A06(2,4);
    Z = A06(3,4);

    Phi = atan2(A06(2,1), A06(1,1));
    Theta = asin(-A06(3,1));
    Gamma =  atan2(A06(3,2), A06(3,3));

    W = [X Y Z Phi Theta Gamma];
    
    diff = W - Wsoll;
    diff3 = diff.';
    
    fq = [ 
            [1 0 0 0 0              0                  ];
            [0 1 0 0 0              0                  ];
            [0 0 1 0 0              0                  ];
            [0 0 0 0 -sin(W(6))     cos(W(6))*cos(W(5))];
            [0 0 0 0 cos(W(6))      sin(W(6))*cos(W(5))];
            [0 0 0 1 0              -sin(W(5))         ];
        ];

    fq2 = real(fq * diff3);
    J = real(jacobian(fq2, q));
   
    while (true)
        

        
        %A062 = double(subs(A06,q,Qstart.'));
   
        Wist = double(subs(W, q, Qstart.'));

        disp("Wist");
        disp(Wist);
        
        disp("Wsoll");
        disp(Wsoll);
        
        diff2 = Wist - Wsoll;

        if ShouldStop(diff2)
            disp("Shouldstop")
            
            Qcalc = Qstart;
            
            return
        end
        
        disp("diff2");
        disp(diff2);

        J2 = double(subs(J, q, Qstart.'));
        fq3 = double(subs(fq2, q, Qstart.'));
       
        x = mldivide(J2,fq3);

         disp(x);

        Qstart = -x + Qstart;

        disp("Qcalc");
        disp(Qstart);
    end
end