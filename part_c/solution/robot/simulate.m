function simulate(Wstart,Wend,n,Qstart)





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