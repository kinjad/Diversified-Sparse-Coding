function P = demo_fsc_doc()
  load ../data/data.mat 
  % Transform frequency data to tfidf 
  % Reduce dimension  
  
  Pre = [];
  CVPre = [];
  beta_set = [0.04];
  %lambda_set = [0.01, 0.03, 0.05, 0.07, 0.11, 0.2, 0.3, 0.4];
   CVPre = [];
  for j = 1 : 1
     
    %for i = 1 : 10      
          %test = data((i - 1) * col_size + 1 : i * col_size, :);
        %label_test = gnd((i - 1) * col_size + 1 : i * col_size, :);
        %train1 = data(1 : (i - 1) * col_size, :);
        %l1 = gnd(1 : (i - 1) * col_size, :);
        %train2 = data(i * col_size + 1 : h_fea,  :);
        %l2 = gnd(i * col_size + 1 : h_fea,  :);
        %train = [train1; train2];
        %label_train = [l1; l2];
      
  
  
      % Parameters for training
        num_bases = 100;
        beta = beta_set(j);
        batch_size = 100;
        num_iters = 100;
  
        Binit = [];
        sparsity_func = 'L1';
        epsilon = [];
  
       fname_save = sprintf('../results/sc_doc_train_%s_b%d_beta%g_%s', ...
       sparsity_func, num_bases, beta, datestr(now, 30));
   
       X = train';
       
       %lambda = lambda_set(j);
       lambda = 0;

       [D S_train stat] = sparse_coding(X, num_bases, beta, sparsity_func, ...
       epsilon, num_iters, batch_size, fname_save, Binit, lambda);
  
  
      % parameters for testing
  
      num_bases = 100;
      beta = beta_set(j);
      batch_size = 100;
      num_iters = 100;
      sparsity_func = 'L1';
      epsilon = [];
      fname_save = sprintf('../results/sc_doc_test_%s_b%d_beta%g_%s', ...
      sparsity_func, num_bases, beta, datestr(now, 30));
  
      X = test';

      [D S_test stat] = sparse_coding_test(X, num_bases, beta, sparsity_func, ...
       epsilon, num_iters, batch_size, fname_save, Binit, D);
      Precision = Retrieve_doc(S_train', S_test', label_train, label_test);
      Pre = [Pre; Precision];
  end
    save('../results/Pre.mat', 'Pre');
  end
  
  
  