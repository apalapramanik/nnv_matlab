%% random 2D Polyhedron
I = ExamplePoly.randHrep('d', 2); 
% input polyhedron set

n = [2 5 5 5 2]; 
% neurons array 2x5x5x5x2 : 2 inputs, 3 hidden layers, 2 outputs

weights = cell(1, length(n) - 1);
% weight matrices
bias = cell(1, length(n) - 1); 
% bias vectors

% generate random weight matrices and bias vectors
for i=1:length(n)-1
    weights{i} = rand(n(i+1), n(i));
    bias{i} = rand(n(i+1), 1);
end

% compute reachable set of the generated network
R = I;
Rn = cell(1, length(n)-1);
Rn{1} = I;
for i=1:length(n) - 1
    R = relu_layer_reach_multiple_inputs(weights{i}, bias{i}, R);
    Rn{i+1} = R;
end

%% Figures
figure;
subplot(1,2,1);
plot(I, 'color', 'r');
subplot(1,2,2);
plot(Rn{5}, 'color' , 'y');

%% Functions

function R = relu_layer_reach_multiple_inputs(W, b, I)
    % @W; weight matrix of the layer
    % @b: bias of the layer
    % @I: polyhedron input set to the layer
    
    n = length(I);
    R = [];
    for i=1:n
        R = [R relu_layer_reach(W, b, I(i))];
    end
    
end

function R = relu_layer_reach(W, b, I)
    % @W; weight matrix of the layer
    % @b: bias of the layer
    % @I; polyhedron input tset to the layer
    
    I1 = W*I + b; % step 1
    R = ReLU(I1); % step 2
end

function R = ReLU(P)
    % P: polyhedron input set
    % R: input set
    
    n = P.Dim;
    R = [];
    R1 = P;
    
    for i = 1:n
        R = stepReLU_multiple_inputs(R, i);
        R = [R R1];
    end

end

function R = stepReLU_multiple_inputs(P, id)
    % P: array of polyhedrons
    % id: index
    n = length(P);
    R = [];
    
    for i = 1:n
        R = [R stepReLU_polyhedron(P(i), id)];
    end
end

function R = stepReLU_polyhedron(P, id)
    % stepReLU operation on an polyhedron at a specific index

    n = P.Dim; % dimension of the polyhedron

    % H1 : x[id] >= 0
    A1 = zeros(1, n);
    A1(1, id) = -1;
    b1 = 0;
    H1 = Polyhedron('A', A1, 'b', b1);

    % H2 : x[id] <= 0
    A2 = zeros(1, n);
    A2(1, id) = 1;
    b2 = 0;
    H2 = Polyhedron('A', A2, 'b', b2);

    %compute Theta

    Theta_1 = P.intersect(H1);
    Theta_2 = P.intersect(H2);

    % compute the intermediate reachable set
    R1 = Theta_1;
    W = eye(n);
    W(id, id) = 0;

    R2 = W*Theta_2;
    R = [R1, R2]; % intermediate reachable set
end

