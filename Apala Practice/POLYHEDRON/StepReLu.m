function R = StepReLu(P, id)

n = P.Dim;
A1 = zeros (1,n);
A1(1,id) = -1;   
b1 = 0;
H1 = Polyhedron ('A', A1,'b', b1);

A2 = zeros (1,n);
A2(1,id) = 1;
b2 = 0;
H2 = Polyhedron ('A', A2,'b', b2);


Theta_1 = P.intersect(H1);
Theta_2 = P.intersect(H2);

R1 = Theta_1;

W = eye(n);
W(id,id)= 0;

R2 = W*Theta_2;
R= [R1 R2];

end

function R = step_relu_multiple_input(S,id)

%p is array of polyhedrons
%i is the index

n = length(S);
%take number of polyhedron
R =[];
for i=1:n
    R = [R StepReLu(S(i),id)];
    %p(i) is ith polyhedron of array of polyhedrons p
end
end

