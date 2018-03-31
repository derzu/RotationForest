% Exemplo de chamada:
% [dadosX, dadosY] = readIonosphere();
function [dataX, dataY] = readIonosphere()
    data = load('ionosphere.mat');
    
    dataX = data.X;
    [~, ~, dataY] = unique(data.Y); % converte os labels strings para ints
end