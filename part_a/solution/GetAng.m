function [C] = GetAng(A)
    C = [rad2deg(A(3, 1)) rad2deg(A(2, 2)) rad2deg(A(3, 1))];
end
