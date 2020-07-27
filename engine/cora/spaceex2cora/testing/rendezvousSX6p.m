function HA = rendezvousSX6p(~)


%% Generated on 16-Apr-2018

%----------Automaton created from Component 'ChaserSpacecraft'-------------

%----------------------Component ChaserSpacecraft--------------------------

%--------------------------------State 1-----------------------------------

%% equation:
%   t'==1 & x'==vx & y'==vy & vx'==-0.057599765881773*x+0.00877200894463775*vy-0.002*ux & vy'==-0.00875351105536225*vx-0.002*uy & ux'==28.8286776769430*vx-0.100479948259883*vy+1449.97541985328*(0.0000575894721132*x+0.00876276*vy-0.002*ux)-0.00462447231887482*(-0.00876276*vx-0.002*uy) & uy'==0.0870156786852279*vx+33.2561992450513*vy-0.00462447231887482*(0.0000575894721132*x+0.00876276*vy-0.002*ux)+1451.50134643428*(-0.00876276*vx-0.002*uy)
dynA = ...
[0,0,1,0,0,0,0;0,0,0,1,0,0,0;-0.05759976588,0,0,0.008772008945,-0.002,0,...
0;0,0,-0.008753511055,0,0,-0.002,0;0.08350331901,0,28.8287182,...
12.60530666,-2.89995084,9.248944638E-06,0;-2.663209196E-07,0,...
-12.63214226,33.25615872,9.248944638E-06,-2.903002693,0;0,0,0,0,0,0,0];
dynB = ...
[0;0;0;0;0;0;0];
dync = ...
[0;0;0;0;0;0;1];
dynamics = linearSys("linearSys", dynA, dynB, dync);

%% equation:
%   t<=125&x<=-100
invA = ...
[0,0,0,0,0,0,1;1,0,0,0,0,0,0];
invb = ...
[125;-100];
invOpt = struct('A', invA, 'b', invb);
inv = mptPolytope(invOpt);

trans = {};
%% equation:
%   
resetA = ...
[1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,0,0,0,0;0,0,0,1,0,0,0;0,0,0,0,1,0,0;...
0,0,0,0,0,1,0;0,0,0,0,0,0,1];
resetb = ...
[0;0;0;0;0;0;0];
reset = struct('A', resetA, 'b', resetb);

%% equation:
%   y>=-100 & x+y >=-141.1 & x>=-100 & y-x<=141.1 & y<=100 & x+y<=141.1 & x<=100 & y-x>=-141.1
guardA = ...
[0,-1,0,0,0,0,0;-1,-1,0,0,0,0,0;-1,0,0,0,0,0,0;-1,1,0,0,0,0,0;0,1,0,0,0,...
0,0;1,1,0,0,0,0,0;1,0,0,0,0,0,0;1,-1,0,0,0,0,0];
guardb = ...
[100;141.1;100;141.1;100;141.1;100;141.1];
guardOpt = struct('A', guardA, 'b', guardb);
guard = mptPolytope(guardOpt);

trans{1} = transition(guard, reset, 2, 'dummy', 'names');

%% equation:
%   
resetA = ...
[1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,0,0,0,0;0,0,0,1,0,0,0;0,0,0,0,1,0,0;...
0,0,0,0,0,1,0;0,0,0,0,0,0,1];
resetb = ...
[0;0;0;0;0;0;0];
reset = struct('A', resetA, 'b', resetb);

%% equation:
%   t>=120
guardA = ...
[0,0,0,0,0,0,-1];
guardb = ...
[-120];
guardOpt = struct('A', guardA, 'b', guardb);
guard = mptPolytope(guardOpt);

trans{2} = transition(guard, reset, 3, 'dummy', 'names');

loc{1} = location('S1',1, inv, trans, dynamics);



%--------------------------------State 2-----------------------------------

%% equation:
%   t'==1 & x'==vx & y'==vy & vx'==-0.057599765881773*x+0.00877200894463775*vy-0.002*ux & vy'==-0.00875351105536225*vx-0.002*uy & ux'==288.028766271474*vx-0.131243039715836*vy+9614.98979543236*(0.0000575894721132*x+0.00876276*vy-0.002*ux)+0.000000341199965400404*(-0.00876276*vx-0.002*uy) & uy'==0.131243040368934*vx+287.999970095943*vy+0.000000341199965400404*(0.0000575894721132*x+0.00876276*vy-0.002*ux)+9614.98829796995*(-0.00876276*vx-0.002*uy)
dynA = ...
[0,0,1,0,0,0,0;0,0,0,1,0,0,0;-0.05759976588,0,0,0.008772008945,-0.002,0,...
0;0,0,-0.008753511055,0,0,-0.002,0;0.5537221867,0,288.0287663,...
84.12260494,-19.22997959,-6.823999308E-10,0;1.964952589E-11,0,...
-84.12259182,287.9999701,-6.823999308E-10,-19.2299766,0;0,0,0,0,0,0,0];
dynB = ...
[0;0;0;0;0;0;0];
dync = ...
[0;0;0;0;0;0;1];
dynamics = linearSys("linearSys", dynA, dynB, dync);

%% equation:
%   t<=125& y>=-100 & x+y>=-141.1 & x>=-100 & y-x<=141.1 & y<=100 & x+y<=141.1 & x<=100 & y-x>=-141.1
invA = ...
[0,0,0,0,0,0,1;0,-1,0,0,0,0,0;-1,-1,0,0,0,0,0;-1,0,0,0,0,0,0;-1,1,0,0,0,...
0,0;0,1,0,0,0,0,0;1,1,0,0,0,0,0;1,0,0,0,0,0,0;1,-1,0,0,0,0,0];
invb = ...
[125;100;141.1;100;141.1;100;141.1;100;141.1];
invOpt = struct('A', invA, 'b', invb);
inv = mptPolytope(invOpt);

trans = {};
%% equation:
%   
resetA = ...
[1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,0,0,0,0;0,0,0,1,0,0,0;0,0,0,0,1,0,0;...
0,0,0,0,0,1,0;0,0,0,0,0,0,1];
resetb = ...
[0;0;0;0;0;0;0];
reset = struct('A', resetA, 'b', resetb);

%% equation:
%   t>=120
guardA = ...
[0,0,0,0,0,0,-1];
guardb = ...
[-120];
guardOpt = struct('A', guardA, 'b', guardb);
guard = mptPolytope(guardOpt);

trans{1} = transition(guard, reset, 3, 'dummy', 'names');

loc{2} = location('S2',2, inv, trans, dynamics);



%--------------------------------State 3-----------------------------------

%% equation:
%   t'==1 & x'==vx & y'==vy & vx'==0.0000575894721132000*x+0.00876276*vy & vy'==-0.00876276*vx & ux'==0 & uy'==0
dynA = ...
[0,0,1,0,0,0,0;0,0,0,1,0,0,0;5.758947211E-05,0,0,0.00876276,0,0,0;0,0,...
-0.00876276,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0;0,0,0,0,0,0,0];
dynB = ...
[0;0;0;0;0;0;0];
dync = ...
[0;0;0;0;0;0;1];
dynamics = linearSys("linearSys", dynA, dynB, dync);

%% equation:
%   t>=120
invA = ...
[0,0,0,0,0,0,-1];
invb = ...
[-120];
invOpt = struct('A', invA, 'b', invb);
inv = mptPolytope(invOpt);

trans = {};
loc{3} = location('S3',3, inv, trans, dynamics);



HA = hybridAutomaton(loc);


end