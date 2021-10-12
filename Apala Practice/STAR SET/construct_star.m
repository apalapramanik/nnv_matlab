%% Star function

lb = [1;1];
ub = [2;2];

S = Star(lb,ub);

%% MANUALLY 
V = S.V;
C = S.C;
d = S.d;
predicate_lb = [-1;-1];
predicate_ub = [1;1];

S2= Star(V,C,d);

%% poly to star

P = ExamplePoly.randHrep;
S3 = Star(P);

%% random star

S4 = Star.rand(5);