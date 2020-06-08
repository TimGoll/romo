function [C] = fk(DH,q)

A01 = TransMatrix(1, q(1), DH);
A12 = TransMatrix(2, q(2), DH);
A23 = TransMatrix(3, q(3), DH);
A34 = TransMatrix(4, q(4), DH);
A45 = TransMatrix(5, q(5), DH);
A56 = TransMatrix(6, q(6), DH);

A06 = A01 * A12 * A23 * A34 * A45 * A56;

C = [GetPos(A06) GetAng(A06)];

end