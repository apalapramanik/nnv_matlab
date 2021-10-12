%% random 3d poly

P1 = ExamplePoly.randHrep ('d',3);
figure;
P1.plot;


R1 = ReLu_3D(P1);
figure;
R1.plot;

%% random 2d poly

P2 = ExamplePoly.randHrep('d' ,3);
%figure;
%P2.plot;
n = P2.Dim;
%R2 = ReLu_2D(P2);
for i = 1:n
    R2 = StepReLu(P2,n);
   
end
figure
R2.plot;









