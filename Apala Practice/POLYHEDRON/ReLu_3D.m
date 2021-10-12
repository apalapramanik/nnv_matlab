function R = ReLu_3D(p)
% ReLu function for 3 dimensional matrix

% Construct halfspace for each quadrant

A1=  [-1 0 0; 0 1 0; 0 0 -1];
B1 = [0;0;0];
H1 = Polyhedron('A', A1, 'b', B1);

A2= [1 0 0; 0 1 0; 0 0 1];
B2 = [0;0;0];
H2 = Polyhedron('A', A2, 'b', B2);

A3= [1 0 0; 0 -1 0; 0 0 1];
B3 = [0;0;0];
H3 = Polyhedron('A', A3, 'b', B3);

A4= [-1 0 0; 0 -1 0; 0 0 1];
B4 = [0;0;0];
H4 = Polyhedron('A', A4, 'b', B4);

A5= [-1 0 0; 0 1 0; 0 0 1];
B5 = [0;0;0];
H5 = Polyhedron('A', A4, 'b', B5);

A6 = [1 0 0; 0 1 0; 0 0 -1];
B6 = [0;0;0];
H6 = Polyhedron('A', A6, 'b', B6);

A7 = [1 0 0; 0 -1 0; 0 0 -1];
B7 = [0;0;0];
H7 = Polyhedron('A', A7, 'b', B7);

A8 = [-1 0 0; 0 -1 0; 0 0 -1];
B8 = [0;0;0];
H8 = Polyhedron('A', A8, 'b', B8);




% Find intersection of polyhedron with halfspace

Theta1=p.intersect(H1);
Theta2=p.intersect(H2);
Theta3=p.intersect(H3);
Theta4=p.intersect(H4);
Theta5=p.intersect(H5);
Theta6=p.intersect(H6);
Theta7=p.intersect(H7);
Theta8=p.intersect(H8);


% apply ReLu activation function affine map

R1 =[0 0 0; 0 1 0; 0 0 0]*Theta1;
R2 =Theta2;
R3 =[1 0 0; 0 0 0; 0 0 1]*Theta3;
R4 =[0 0 0; 0 0 0; 0 0 1]*Theta4;
R5 =[0 0 0; 0 1 0; 0 0 1]*Theta5;
R6 =[1 0 0; 0 1 0; 0 0 0]*Theta6;
R7 =[1 0 0; 0 0 0; 0 0 0]*Theta7;
R8 =[0 0 0; 0 0 0; 0 0 0]*Theta8;


R = [R1 R2 R3 R4 R5 R6 R7 R8];
end



