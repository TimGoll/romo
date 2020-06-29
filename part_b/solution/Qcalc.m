function [Qcalc] = Qcalc(Wsoll, Qstart, DH)

    %Definieren der Gelenkwinkel als Variabeln

    syms q1 q2 q3 q4 q5 q6 real

    q = [q1 q2 q3 q4 q5 q6].';   
    
    %Erstellen der Transformationsmatrixen in Abhängigkeit der Gelenkwinkel
    
    
    for i = 1:6
            T(:,:,i) = [
                [cos(q(i))  -sin(q(i))*cos(DH(i, 4))  sin(q(i))*sin(DH(i, 4))   DH(i, 3)*cos(q(i))];
                [sin(q(i))  cos(q(i))*cos(DH(i, 4))   -cos(q(i))*sin(DH(i, 4))  DH(i, 3)*sin(q(i))];
                [0          sin(DH(i, 4))             cos(DH(i, 4))             DH(i, 2)          ];
                [0          0                         0                         1                 ];
            ];
                       
    end
        
    A06 = T(:,:,1)*T(:,:,2)*T(:,:,3)*T(:,:,4)*T(:,:,5)*T(:,:,6);
    
    %Erstellen der Positionsgleichungen des Endeffektors in Abhängigkeit
    %der Gelenkwinkel
    
    X = A06(1,4);
    Y = A06(2,4);
    Z = A06(3,4);
    
    %Erstellen der Orientierungsgleichungen des Endeffektors in Abhängigkeit
    %der Gelenkwinkel
    
    theta_x = atan2(A06(3,2),A06(3,3));
    theta_y = asin(-A06(3,1));
    theta_z = atan2(A06(2,1), A06(1,1));

    W = [X Y Z theta_x theta_y theta_z].';
    
    
    %Erstellen der Fehlergleichung in Abhängigkeit der Gelenkwinkel
    
    f = (W - Wsoll).';
    
    disp(f);
    

    f = real(f);
    
    %Erstellen der Jacobi Matrix in Abhängigkeit der Gelenkwinkel
    
    J = real(jacobian(f, q));
   
    while (true)
        
        %Berechnung der Position und der Orientierung des Endeffektors
        
        mod(Qstart, 360)
           
        Wist = double(subs(W, q, Qstart));
        
        %Berechnung des Fehlers

        f = Wist - Wsoll;
        disp(f);
        if ShouldStop(f)          
            Qcalc = Qstart;
            return
        end
        
        %Berechnung der Jacobi Matrix
        
        J = double(subs(J, q, Qstart));
            
       
        Qstart = Qstart - mldivide(J,f); 

    end
end