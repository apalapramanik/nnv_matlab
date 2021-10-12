function R = relu_polyhedron(P)
%P: polyhedron inut set
%R: output set

n = P.Dim;
R =[];
R1 =P;

for i = 1:n
    
   R1 = step_relu_multiple_input(R1,i);
   R = [R R1];
     
   
end
end

