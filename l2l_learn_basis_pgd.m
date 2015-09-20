function B = l2l_learn_basis_pgd(X, S, Bn_1, lambda, eta)
% Yuan added this function
% Here X is the data, S is A, Bn_1 is the dictionary

n = size(X, 1);
k = size(X, 2);


X_new = X';


% The original gradient

D = Bn_1';
S_new = S';
G = S_new' * (X_new - S_new * D) - lambda.* inv(D * D') * D;
par_pro = D + eta .* G;
d = size(par_pro, 1);
% The projected gradient 

for i = 1 : d
  l2 = norm(par_pro(i, :));
  l1 = sum(abs(par_pro(i, :)));
  if l2 > 1
    par_pro(i, :) ./ l1;
  end
end
B = par_pro';

      

  