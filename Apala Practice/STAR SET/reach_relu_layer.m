function S = reach_relu_layer(W, b, I)

I1 = I.affineMap(W,b);
S = star_relu(I1);
end
