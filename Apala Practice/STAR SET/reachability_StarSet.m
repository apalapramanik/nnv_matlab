%% compute exact-reachability using star set 

% generate a random polyhedron
P = ExamplePoly.randHrep('d',2);
%convert poly to star
I = Star(P);

n = [2 3 2];
% 2 input neurons, 3 in hidden layer, 2 outputs
l = length(n)-1;

W = cell(1,l);%array of weight matrices
b = cell(1,l);%array if bias matrices

for i = 1:l
    W{i} = rand(n(i+1),n(i));
    b{i} = rand(n(i+1), 1);
end

%compute reachability
S = I;
for i = 1:l
    S = reach_relu_layer_multiple_inputs(W{i},b{i},S);
end

%plot figures
figure;
subplot(1,2,1);
Star.plots(I,'r');
subplot(1,2,2);
Star.plots(S,'y');

%functions
function S = reach_relu_layer_multiple_inputs(W,b,I)
n = length(I);
S = [];
for i = 1:n
   S = [S reach_relu_layer(W, b,I(i))];
end
end

function S = reach_relu_layer(W, b, I)

I1 = I.affineMap(W,b);
S = star_relu(I1);
end

function S = star_relu(I)

n = I.dim;
S = I;
for id = 1:n
    S = Star_relu_multiple_inputs(I,id);
end
end

function S = Star_relu_multiple_inputs(I, id)
n = length(I);
S =[];
for i = 1:n
    S = [S stepReLU_star(I(i),id)];
end
end 

function R = stepReLU_star(I, id)
%S = input star set
%id = index at which we perform steprelu operation

n = I.dim;

if id>n || id<1
    error('invalid index');
end

%for dim x[id]>=0
G1 = zeros(1,n);
G1(1, id) = -1;
I1 = I.intersectHalfSpace(G1,0);


%for dim x[id]<=0
G2 = zeros(1,n);
G1(1, id) = 1;
I2 = I.intersectHalfSpace(G2,0);
class(I2);
M2 = eye(n);
M2(id,id) = 0;
b2 = zeros(n,1);

class(I2);
R2 = I2.affineMap(M2, b2);

R = [I1 R2];

end





