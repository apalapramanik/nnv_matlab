function R = approx_steprelu(I, id)

n = I.dim;
if id <1 || id>n
    print("error")
end

[lb,ub] = I.getRange(id);
%get lower bound and upper bound

if lb >= 0 
    R = I;
    
elseif ub<=0
   R = I.resetRow(id);
   
elseif lb<0 && ub>0
    %% use triangle approximation rule
    
    %first constraint : y= ReLu(x) = beta >=0
    %second constraint : y = ReLu(x) = beta >=x
    %third constraint : y = ReLu(x) = beta <= (ub/ub-lb)*(x-lb)
    %lower and upper bound of beta: [0,ub]
    
    %y[id] = ReLu(x[id]) = beta
    
    %construct new center and basic verctor
    v= I.V;
    %first column is centre vector and others are basic verctors    
    %new v = [v v_beta]
 
    v_beta = zeros(n,1);
    v_beta(id) = 1;
   
    v(id,:) = 0;
    new_v = [v v_beta];
   
   %new constraints P' = old_p & new constraint of beta
   %old_p = old_c *x <= old_d
   
    C = I.C; %new constraint matrix
    d = I.d; %new constraint vector
   
   %% 1) beta>=0 <=> C1 * X <= d1
   
    m = I.nVar;
    C1= zeros (1, m+1);
    C1(m+1) = -1;
    d1 = 0;
   
   %% 2) beta>= x <=> C2* alpha<= d2, alpha = [a1, a2.....am, a[m+1]}
   % a[m+1] = beta
   
    d2 = -I.V(id,1);
    C2= [I.V(id, 2:m+1) -1];
   
   %% 3) beta <= (ub/(ub-lb))* (x-lb)  <=> C3*alpha <= d3
   
    a = ub/(ub-lb);
    d3 = a*I.V(id,1) - a *lb;
    C3= [ -a*I.V(id,2:m+1) 1];
    new_c_beta = [C1;C2;C3];
    new_d_beta = [d1; d2; d3];
   
   %% new consraint
    Z1 = zeros(size(C,1),1);
    new_c = [[C,Z1]; new_c_beta];
    new_d = [d; new_d_beta];   
    new_predicate_lb = [I.predicate_lb; 0];
    new_predicate_ub = [I.predicate_ub; ub];
   
    R = Star(new_v, new_c, new_d, new_predicate_lb, new_predicate_ub);   
end 
end