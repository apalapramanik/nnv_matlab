%% constructing an FFNN network

n = [2 5 5 5 2]; 
% 2 inputs, 3 hidden layers, 2 output
%length of n = no of layers in ffnn = 5
W = cell(1,length(n)-1);
%W is cell array of weight matrices
b = cell(1,length(n)-1);
%b is cell array of bias matrices

%% generate random weight and bias matrices

for i=1:length(n)-1
    W{i} = rand(n(i+1),n(i));
    %assign random values as weights
    b{i} = rand(n(i+1),1);
    %assign random values as biases
end

%% construct layer object

Layers = [];
for i = 1:length(n)-1
    L = LayerS(W{i},b{i},'poslin');
    Layers = [Layers L];
end

%% construct network

network = FFNNS(Layers);

%% compute reachable set
numCores = 4;
P = ExamplePoly.randHrep('d' ,2);
[R, t] = network.reach(P, 'exact-polyhedron', numCores);










