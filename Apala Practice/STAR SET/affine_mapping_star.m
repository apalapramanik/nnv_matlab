
%random star set
S = Star.rand(3);


%affine mapping method

W = rand(2,3);
b = rand (2,1);

S2 = S.affineMap(W,b);
figure;
subplot(1,2,1);
S.plot;

subplot(1,2,2);
S2.plot;

%intersection

%x1 + x2 >= 0;
%Hx =<=g

G = [-1 -1];
g = 0;

S3= HalfSpace(G,g);

S3 = S2.intersectHalfSpace(G,g);

figure;
S2.plot('red');
hold on;
S3.plot('yellow');


