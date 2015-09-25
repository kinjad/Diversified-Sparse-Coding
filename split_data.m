function [train, test] = split_data(fea, ratio) 
  %in this funcion, we split the gross data 'fea' into two different sets: one ...
  %for training, and the other for testing, according to the ratio ...
  %  provided
  [H, W] = size(fea);
  newH = floor(H * ratio);
  train = fea(1 : newH, :);
  test = fea(newH + 1: H, :);
end