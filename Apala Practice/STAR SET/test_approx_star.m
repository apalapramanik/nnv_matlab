I = Star.rand(2);
R1 = approx_steprelu(I,1);
R2 = approx_steprelu(R1,2);
    
%R3 = PosLin.stepReLUStarApprox(I,1);
figure;
Star.plots(R1,'yellow');
hold on;
Star.plots(R2,'red');