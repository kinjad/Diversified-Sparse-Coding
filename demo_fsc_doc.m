function P = demo_fsc_doc()
  load ../data/TDT2.mat 
  % Transform frequency data to tfidf 
  % Reduce dimension  
  fea = dimension_reduction(fea, 5000);
  h_fea = size(fea, 1);
  col_size = floor(h_fea / 10);
  perm = randperm(h_fea);
  fea = fea(perm, :);
  gnd = gnd(perm, :);
  data = tfidf(fea); 
  [train, test] = split_data(data, 0.7);
  [label_train, label_test] = split_data(gnd, 0.7);
  Pre = 0;
  CVPre = [];
  beta_set = [0.2];
  lambda_set = [0.01, 0.03, 0.05, 0.07, 0.11, 0.2, 0.3, 0.4];
  for j = 1 : 5
      CVPre = [];
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
        beta = beta_set(1);
        batch_size = 100;
        num_iters = 100;
  
        Binit = [];
        sparsity_func = 'L1';
        epsilon = [];
  
       fname_save = sprintf('../results/sc_doc_train_%s_b%d_beta%g_%s', ...
       sparsity_func, num_bases, beta, datestr(now, 30));
   
       X = train';
       
       lambda = lambda_set(j);

       [D S_train stat] = sparse_coding(X, num_bases, beta, sparsity_func, ...
       epsilon, num_iters, batch_size, fname_save, Binit, lambda);
  
  
      % parameters for testing
  
      num_bases = 100;
      beta = beta_set(1);
      batch_size = 100;
      num_iters = 100;
  
      Binit = [];
      sparsity_func = 'L1';
      epsilon = [];
  
      fname_save = sprintf('../results/sc_doc_test_%s_b%d_beta%g_%s', ...
      sparsity_func, num_bases, beta, datestr(now, 30));
  
      X = test';

      [D S_test stat] = sparse_coding_test(X, num_bases, beta, sparsity_func, ...
       epsilon, num_iters, batch_size, fname_save, Binit);
      Precision = Retrieve_doc(S_train', S_test', label_train, label_test);
      %if (mean(Precision) > Pre)
       Pre = [Pre; mean(Precision)];
       %index = j;
      %end
      %save('../results/result.mat', 'S_train', 'S_test', 'label_train', 'label_test');
    end
    CVPre = [CVPre; mean(Pre)];
    save('../results/CVPre.mat', 'CVPre', 'lambda_set');
  end
  
  
  