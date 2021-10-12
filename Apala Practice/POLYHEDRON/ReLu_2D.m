function R = ReLu_2D(p)

A1=[1 0; 0 -1];
B1=[0;0];
H1= Polyhedron('A', A1, 'b', B1);

A2=[-1 0; 0 -1];
B2=[0;0];
H2= Polyhedron('A', A2, 'b', B2);

A3=[-1 0; 0 1];
B3=[0;0];
H3= Polyhedron('A', A3, 'b', B3);

A4= [1 0; 0 1];
B4=[0;0];
H4= Polyhedron('A', A4, 'b', B4);

theta1=p.intersect(H1);
theta2=p.intersect(H2);
theta3=p.intersect(H3);
theta4=p.intersect(H4);

R1= [0 0; 0 1]*theta1;
R2= theta2;
R3= [1 0; 0 0]*theta1;
R4= [0 0;0 0]*theta1;

R= [R1 R2 R3 R4];
