function simulate(Wstart,Wend,n)

%     Pstart = Wstart(1:3);
%     Pend = Wend(1:3);
    
%     Rstart = Wstart(4:6);
%     Rend = Wend(4:6);
    Qstart = [RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361), RandRange(1,361)].';

    x = linspace(0,1,n);
    A2 = Wstart + x.*(Wend - Wstart);

    for i = 1:1:n
        P = A2(:,i);
        Q = backward(P,Qstart);
        roboplot(Q);
        drawnow;
        Qstart=Q;
    end

end