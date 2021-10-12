function S = star_relu(I)

n = I.dim;
S = I;
for id = 1:n
    S = Star_relu_multiple_inputs(I,id);
end
end