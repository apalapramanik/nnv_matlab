function S = Star_relu_multiple_inputs(I, id)
n = length(I);
S =[];
for i = 1:n
    S = [S steprelu_star(I(i),id)];
end
end 