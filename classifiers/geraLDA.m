%
%
function [m] = geraLDA(data, labels)
    %disp('entrei geraLDA');
    m = fitcdiscr(data, labels, 'DiscrimType', 'pseudoLinear');
    %m = fitcnb(data, labels);
end
