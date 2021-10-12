function S = reach_relu_layer_multiple_inputs(W,b,I)
n = length(I);
S = [];
for i = 1:n
   S = [S reach_relu_layer(W, b,I(i))];
end
end

