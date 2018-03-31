%
%
function [t] = geraKNN(data, labels)
    %disp('entrei geraKNN');
    t = fitcknn(data, labels, 'NumNeighbors', 3);
    %view(t, 'mode','graph');
end
