function R = step_relu_multiple_input(P,id)

%p is array of polyhedrons
%i is the index

n = length(P);
%take number of polyhedron
R =[];
for i=1:n
    R = [R StepReLu(P(i),id)];
    %p(i) is ith polyhedron of array of polyhedrons p
end
end

