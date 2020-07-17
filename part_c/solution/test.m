Wstart = [-1180 -260 10 90 0 0].';
Wend = [-471 -782.73 201.03 -179.88 -24.48 -158].';
Qstart = [RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361)].';

% Qstart = backward(Wstart,Qstart);
n = 1000;
simulate(Wstart,Wend,n,Qstart);
% x = linspace(0,1,n);
% A2 = Wstart + x.*(Wend - Wstart);
% 
%     for i = 1:1:n
%         P = A2(:,i);
%         Q = backward(P,Qstart);
%         roboplot(Q);
%         drawnow;
%         Qstart=Q;
%         
%     end