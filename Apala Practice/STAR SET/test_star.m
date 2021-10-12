I = Star.rand(2);
R = steprelu_star(I,1);

figure;
I.plot;
%hold on;

figure;
Star.plots(R,'yellow');

