function P = demo_fsc_doc()
  load ../data/TDT2.mat 
  % Transform frequency data to tfidf 
  % Reduce dimension  
  fea = dimension_reduction(fea, 5000);
  h_fea = size(fea, 1);
  perm = randperm(h_fea);
  fea = fea(perm, :);
  gnd = gnd(perm, :);
  data = tfidf(fea);  
  [train, test] = split_data(data, 0.7);
  [label_train, label_test] = split_data(gnd, 0.7);
  
  % Parameters for training
  num_bases = 200;
  beta = 0.05;
  batch_size = 900;
  num_iters = 100;
  
  Binit = [];
  sparsity_func = 'L1';
  epsilon = [];
  
  fname_save = sprintf('../results/sc_doc_train_%s_b%d_beta%g_%s', ...
      sparsity_func, num_bases, beta, datestr(now, 30));
  
  X = train';
   
  [D S_train stat] = sparse_coding(X, num_bases, beta, sparsity_func, ...
      epsilon, num_iters, batch_size, fname_save, Binit);
  
  
  % parameters for testing
  
  num_bases = 200;
  beta = 0.05;
  batch_size = 900;
  num_iters = 100;
  
  Binit = [];
  sparsity_func = 'L1';
  epsilon = [];
  
  fname_save = sprintf('../results/sc_doc_test_%s_b%d_beta%g_%s', ...
      sparsity_func, num_bases, beta, datestr(now, 30));
  
  X = test';

  [D S_test stat] = sparse_coding_test(X, num_bases, beta, sparsity_func, ...
      epsilon, num_iters, batch_size, fname_save, Binit);
  %Precision = Retrieve_doc(S_train', S_test', label_train, ...
     % label_test);
  save('../results/result.mat', 'S_train', 'S_test', 'label_train', 'label_test');