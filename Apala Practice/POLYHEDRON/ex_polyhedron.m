%% create a new polyhedron object using H-representation

A = [1 0; -1 0; 0 1; 0 -1];
B = [1; 1; 1; 1];

% p = {x | Ax <= b, Aex = be}

P1 = Polyhedron ('A', A, 'b', B);

%% using lower bound and upper bound

lb = [-1; -1];
ub = [1; 1];

P2 = Polyhedron ('lb' , lb , 'ub', ub);

%% create random polyhedron for testing

P3 = ExamplePoly.randHrep;

%affine mapping of a polyhedron
%P <- P' = W*P + b

W = rand(3, 2);
b = rand(3, 1);

P3_map =  W*P3 + b;

%% Intersection of two polyhedron
P41 = ExamplePoly.randHrep;
P42 = ExamplePoly.randHrep;

P4 = P41.intersect(P42);
fig = figure;
P41.plot('color','yellow');
hold on;
P42.plot ('color','red');
hold on;
P4.plot('color','blue');



