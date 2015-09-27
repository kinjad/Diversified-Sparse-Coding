%function Pre = Retrieve_doc(S_train, S_test, label_train, label_test) ...
      
function Pre = Retrieve_doc()
      
  load '../results/result.mat';  
  [dim1, dim2] = size(S_train);
  [dim3, dim4] = size(S_test);
  Pre =[];
  for i = 1 : dim3
    temp = [];
    for j = 1 : dim1
      temp = [temp; norm(S_test(i, :) - S_train(j, :))];
    end
    sort_temp = temp;
    [sort_temp, index] = sort(sort_temp);
    temp_label = label_train(index(1 : 100), :);
    
    %Compare labels
    precision = temp_label - label_test(i, 1);    
    Pre = [Pre; sum(precision(:) == 0) / 100];
    Pre = mean(Pre);
  end
  save('../results/Precision.mat', 'Pre');
end

      
      
  