function plotKS(A)
    O = [0  ;0  ;0  ];
    X = [0.1;0  ;0  ];
    Y = [0  ;0.1;0  ];
    Z = [0  ;0  ;0.1];
    
    O=A(1:3,1:3)*O+A(1:3,4);
    X=A(1:3,1:3)*X+A(1:3,4);
    Y=A(1:3,1:3)*Y+A(1:3,4);
    Z=A(1:3,1:3)*Z+A(1:3,4);
    
    plot3([O(1),X(1)],[O(2),X(2)],[O(3),X(3)],'r');
    plot3([O(1),Y(1)],[O(2),Y(2)],[O(3),Y(3)],'g');
    plot3([O(1),Z(1)],[O(2),Z(2)],[O(3),Z(3)],'b');
end