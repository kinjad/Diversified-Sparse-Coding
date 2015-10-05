function PreProcess()
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
   save('../data/data.mat', 'train', 'test', 'label_train', 'label_test');
end