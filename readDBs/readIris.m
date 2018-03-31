% Exemplo de chamada:
% [dadosX, dadosY] = readIris();
function [dataX, dataY] = readIris()
    data = load('iris.dat');
    
    dataX = data(:, 1:4); % info
    dataY = data(:, 5); % labels
end