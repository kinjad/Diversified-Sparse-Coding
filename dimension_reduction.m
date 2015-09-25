function M = dimension_reduction(Raw_Data, dim)   
  [H, W] = size(Raw_Data);
  col_sum = sum(Raw_Data, 1);
  copy_col_sum = col_sum;
  [copy_col_sum, index] = sort(copy_col_sum, 'descend');
  index = index(1 : dim);
  M = Raw_Data(:, index);
end

    