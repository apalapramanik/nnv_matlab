function R = layer_reach_polyhedron(W, b, P)
%W: affine mapping matrix
%b:bias vector of layer
%P :polyhedron input set

%affine mapping

I = (W*P) + b;
R = relu_polyhedron(I);

end

