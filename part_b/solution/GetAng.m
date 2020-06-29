%Berechnen der Orientierung des Endeffektors

function [C] = GetAng(A)
    C = [rad2deg(atan2(A(3,2), A(3,3))) rad2deg(asin(-A(3,1))) rad2deg(atan2(A(2,1), A(1,1)))];
end
