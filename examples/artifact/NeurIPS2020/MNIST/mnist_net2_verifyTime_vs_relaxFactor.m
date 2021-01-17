
clc; clear;

%% Load and parse networks into NNV
Nets = [];
% load('net_mnist_3_relu.mat');
% net1 = SEGNET.parse(net, 'net_mnist_3_relu_avgpool');
% Nets = [Nets net1];
load('net_mnist_3_relu_maxpool.mat');
net2 = SEGNET.parse(net, 'net_mnist_3_relu_maxpool');
% Nets = [Nets net2];
% load('mnist_dilated_net_21_later_83iou');
% net3 = SEGNET.parse(net, 'mnist_dilated_net_21_later_83iou');
% Nets = [Nets net3];
load('test_images.mat');


Nmax = 50; % maximum allowable number of attacked pixels
de = [0.005; 0.01; 0.02]	; % size of input set
%de = [0.001; 0.0015; 0.002];
%de = 0.005;
Nt = 150;

%% create input set
N1 = length(de);  

IS(N1) = ImageStar;
GrTruth = cell(1,N1);
for l=1:N1
    ct = 0;
    flag = 0;
    im = im_data(:,:,1);
    at_im = im;
    for i=1:28
        for j=1:28
            if im(i,j) > Nt
                at_im(i,j) = 0;
                ct = ct + 1;
                if ct == Nmax
                    flag = 1;
                    break;
                end
            end
        end
        if flag == 1
            break;
        end
    end

    dif_im = im - at_im;
    noise = -dif_im;
    % Perform robustness analysis
    V(:,:,:,1) = double(im);
    V(:,:,:,2) = double(noise);
    C = [1; -1];
    d = [1; de(l)-1];
    S = ImageStar(V, C, d, 1-de(l), 1);
    IS(l) = S; 
    GrTruth{l} = {im};
end

%%


Methods = ["relax-star-random", "relax-star-area", "relax-star-range", "relax-star-bound"];
% Methods = ["relax-star-random"];
N2 = length(Methods);
RFs = [0; 0.25; 0.5; 0.75; 1]; % relaxation factor
N3 = length(RFs);

% relax-star results
RIoU = zeros(N1, N2, N3); % average robust IoU
RV = zeros(N1, N2, N3); % average robustness value for N images
RS = zeros(N1, N2, N3); % average robustness sensitivity for N images
VT = zeros(N1, N2, N3);
% original approx-star results (no relaxation)

%% Verify networks

c = parcluster('local');
numCores = 1;
%RVnumCores = c.NumWorkers;

% verify N1 networks in the Nets array using the relax-star approach
t2 = tic;
parfor i=1:N1
    for j=1:N2
        for k=1:N3
            t = tic;
            [riou, rv, rs, ~, ~, ~, ~, ~] = net2.verify(IS(i), GrTruth{1,i}, Methods(j), numCores, RFs(k));
            RIoU(i, j, k) = sum(riou)/length(riou);
            RV(i, j, k) = sum(rv)/length(rv); 
            RS(i, j, k) = sum(rs)/length(rv);
            VT(i,j,k) = toc(t);
        end
    end
end
total_VT = toc(t2);

%% print results
fprintf("======================== VERIFICATION TIME IMPROVEMENT FOR NETWORK N1 ============================")
   
N2_verifyTime = table; 
N2_verifyTime.RelaxFactor = RFs;
vt = [];
for i=1:N2
    vt1 = VT(1, i, :);
    vt1 = reshape(vt1, [N3, 1]);
    vt = [vt vt1];
end
N2_verifyTime.de_005 = vt;

vt = [];
for i=1:N2
    vt1 = VT(2, i, :);
    vt1 = reshape(vt1, [N3, 1]);
    vt = [vt vt1];
end
N2_verifyTime.de_01 = vt;

vt = [];
for i=1:N2
    vt1 = VT(3, i, :);
    vt1 = reshape(vt1, [N3, 1]);
    vt = [vt vt1];
end
N2_verifyTime.de_02 = vt;

N2_verifyTime

fprintf("*** NOTE FOR EACH DELTA (de) ***\n");
fprintf("The firt column is the verification time of the relax-star-random method \n")
fprintf("The second column is the verification time of the relax-star-area method \n");
fprintf("The third column is the verification time of the relax-star-range method \n");
fprintf("The last column is the verification time of the relax-star-bound method \n");
writetable(N2_verifyTime);


N2_verifyTime_improve = table;
N2_verifyTime_improve.RelaxFactor = RFs;
impr = [];
for i=1:N2
    vt1 = VT(1, i, :);
    vt1 = reshape(vt1, [N3, 1]);
    impr1 = (-100)*(vt1 - vt1(1))/(vt1(1));
    impr = [impr impr1];
end
N2_verifyTime_improve.de_005 = impr;

impr = [];
for i=1:N2
    vt1 = VT(2, i, :);
    vt1 = reshape(vt1, [N3, 1]);
    impr1 = (-100)*(vt1 - vt1(1))/(vt1(1));
    impr = [impr impr1];
end
N2_verifyTime_improve.de_01 = impr;

impr = [];
for i=1:N2
    vt1 = VT(3, i, :);
    vt1 = reshape(vt1, [N3, 1]);
    impr1 = (-100)*(vt1 - vt1(1))/(vt1(1));
    impr = [impr impr1];
end
N2_verifyTime_improve.de_02 = impr;

N2_verifyTime_improve
writetable(N2_verifyTime_improve);

%% Print latex table1

fileID = fopen('N2_verifyTime_vs_relaxFactor.tex', 'w');

N = size(N2_verifyTime, 1);
for i=1:N
    [rf, a11, a12, a21, a22, a31, a32, a41, a42, b11, b12, b21, b22, b31, b32, b41, b42, c11, c12, c21, c22, c31, c32, c41, c42] = get_verifyTime(N2_verifyTime, N2_verifyTime_improve, i);
    if i== 1
        str = sprintf('\\\\multirow{5}{*}{$\\\\mathbf{N_2}$} & $%2.2f$ & %2.2f &  $%2.2f$  &  $%2.2f$ &  $%2.2f$  & $%2.2f$  &  $%2.2f$  &  $%2.2f$  &  $%2.2f$  &  $%2.2f$ &  $%2.2f$  &  $%2.2f$  &  $%2.2f$ \\\\\\\\ ', rf, a11, a21, a31, a41, b11, b21, b31, b41, c11, c21, c31, c41); 
    else
        str = sprintf(' & $%2.2f$ & $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$ &  $%2.1f (\\\\color{blue}{\\\\downarrow %2.0f\\\\%%%%})$   \\\\\\\\ ', rf, a11, a12, a21, a22, a31, a32, a41, a42, b11, b12, b21, b22, b31, b32, b41, b42, c11, c12, c21, c22, c31, c32, c41, c42); 
    end
    
    fprintf(fileID, str);
    fprintf(fileID, '\n');
    
end
fclose(fileID);

function [rf, a11, a12, a21, a22, a31, a32, a41, a42, b11, b12, b21, b22, b31, b32, b41, b42, c11, c12, c21, c22, c31, c32, c41, c42] = get_verifyTime(VT, VT_impr, i)
    % vt: verification results
    % i : row index  
    vt = VT(i,:);
    vt_impr = VT_impr(i, :);
    rf = vt.RelaxFactor;
    a11 = vt.de_005(1);
    a21 = vt.de_005(2);
    a31 = vt.de_005(3);
    a41 = vt.de_005(4);
    b11 = vt.de_01(1);
    b21 = vt.de_01(2);
    b31 = vt.de_01(3);
    b41 = vt.de_01(4);
    c11 = vt.de_02(1);
    c21 = vt.de_02(2);
    c31 = vt.de_02(3);
    c41 = vt.de_02(4);
    
    a12 = vt_impr.de_005(1);
    a22 = vt_impr.de_005(2);
    a32 = vt_impr.de_005(3);
    a42 = vt_impr.de_005(4);
    b12 = vt_impr.de_01(1);
    b22 = vt_impr.de_01(2);
    b32 = vt_impr.de_01(3);
    b42 = vt_impr.de_01(4);
    c12 = vt_impr.de_02(1);
    c22 = vt_impr.de_02(2);
    c32 = vt_impr.de_02(3);
    c42 = vt_impr.de_02(4);
end