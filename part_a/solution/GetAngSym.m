function [C] = GetAngSym(A)
    C = [atan2(A(2,1), A(1,1)) asin(-A(3,1)) atan2(A(3,2), A(3,3))];
end
