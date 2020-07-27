function [Zred]=reduceMethB(Z,order,filterLength)
% reduceMethB - prefilters longest generators and use exhaustive search
%
% Syntax:  
%    [Zred]=reduceMethB(Z,order,filterLength)
%
% Inputs:
%    Z - zonotope object
%    order - desired order of the zonotope
%    filterLength - parameter to pre-filter generators
%
% Outputs:
%    Zred - reduced zonotope
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: 

% Author:       Matthias Althoff
% Written:      11-September-2008
% Last update:  06-March-2009
%               28-September-2010
%               27-June-2018
% Last revision:---

%------------- BEGIN CODE --------------

% initialize Z_red
Zred=Z;

% pick generators to reduce
[center, Gunred, Gred] = pickedGenerators(Z,order);

if ~isempty(Gred)
    %Delete zero-generators
    G=nonzeroFilter(Gred);

    %determine filter length
    if filterLength(1)>length(G(1,:))
        filterLength(1)=length(G(1,:));
    end

    %length filter
    G=lengthFilter(G,filterLength(1));

    %reorder generators
    Gcells=reorderingFilter(G);

    %pick generator with the best volume
    Gtemp=volumeFilter(Gcells,Z);
    Gpicked=Gtemp{1};

    %Build transformation matrix P
    for i=1:length(center)
        P(:,i)=Gpicked(:,i);
    end
    
    % map generators
    Gtrans = pinv(P)*Gred;

    % box generators
    Gbox=diag(sum(abs(Gtrans),2));

    % transform generators back
    Gred = P*Gbox;
end

%build reduced zonotope
Zred.Z=[center,Gunred,Gred];


%------------- END OF CODE --------------
