% Exemplo de chamada:
% [dadosX, dadosY] = readIonosphere();
%
% $Author: Derzu Omaia
function [dataX, dataY] = readIonosphere()
    data = load('ionosphere.mat');
    
    dataX = data.X;
    [~, ~, dataY] = unique(data.Y); % converte os labels strings para ints
end