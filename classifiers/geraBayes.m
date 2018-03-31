%
%
function [m] = geraBayes(data, labels)
    disp('entrei geraBayes');
    m = fitNaiveBayes(data, labels,'Distribution', 'mn');
    %m = fitcnb(data, labels);
end
