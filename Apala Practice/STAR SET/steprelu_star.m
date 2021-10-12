function R = steprelu_star(I, id)
%S = input star set
%id = index at which we perform steprelu operation

n = I.dim;
if id>n || id<1
    error('invalid index');
end

%for dim x[id]>=0
G1 = zeros(1,n);
G1 (1, id) = -1;
I1 = I.intersectHalfSpace(G1,0);


%for dim x[id]<=0
G2 = zeros(1,n);
G2 (1, id) = 1;
I2 = I.intersectHalfSpace(G2,0);

M2 = eye(n);
M2(id,id) = 0;
b2 = zeros(n,1);

R2 = I2.affineMap(M2, b2);

R = [I1, R2];

end
     
