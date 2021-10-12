%% random 3d poly

P1 = ExamplePoly.randHrep ('d',3);
figure;
P1.plot;


R1 = ReLu_3D(P1);
figure;
R1.plot;
