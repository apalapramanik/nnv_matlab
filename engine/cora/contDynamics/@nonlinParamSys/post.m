function [Rnext,options] = post(obj,R,options)
% reach - computes the reachable continuous set for one time step of a
% nonlinear system by overapproximative linearization
%
% Syntax:  
%    [Rnext] = reach(obj,R,options)
%
% Inputs:
%    obj - nonlinearSys object
%    R - reachable set of the previous time step
%    options - options for the computation of the reachable set
%
% Outputs:
%    Rnext - reachable set of the next time step
%    options - options for the computation of the reachable set
%
% Example: 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author:       Matthias Althoff
% Written:      03-January-2008
% Last update:  29-June-2009
%               16-August-2016 (identical to post of @nonlinearSys; solve in the future by inheritance)
% Last revision:---

%------------- BEGIN CODE --------------

%despite the linear system: the nonlinear system has to be constantly
%initialized due to the linearization procedure
[Rnext,options] = initReach(obj,R.tp,options);

%reduce zonotopes
for i=1:length(Rnext.tp)
    Rnext.tp{i}.set=reduce(Rnext.tp{i}.set,options.reductionTechnique,options.zonotopeOrder);
    Rnext.ti{i}=reduce(Rnext.ti{i},options.reductionTechnique,options.zonotopeOrder);
end

%delete redundant reachable sets
Rnext = deleteRedundantSets(Rnext,R,options);

%------------- END OF CODE --------------