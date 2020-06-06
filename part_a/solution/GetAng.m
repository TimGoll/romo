function [C] = GetAng(A)
    C = [
        rad2deg(atan2(deg2rad(A(2,1)), deg2rad(A(1,1))))
        rad2deg(asin(deg2rad(-A(3,1))))
        rad2deg(atan2(deg2rad(A(3,2)), deg2rad(A(3,3))))
    ];
end
