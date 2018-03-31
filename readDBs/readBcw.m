% Exemplo de chamada:
% [dadosX, dadosY] = readBcw('data/UCI/bcw/breast-cancer-wisconsin.data.txt');
function [dataX, dataY] = readBcw(path)
    file = fopen(path);
    if file<=0
         fprintf('Erro arquivo \"%s\" nao encontrado\n', path);
        return;
    end
    fclose(file);
    
    % substitui as ? que haviam em alguns (16) valores por 0. Zero era um valor
    % nao usado.
    data = csvread(path);
    
    % a primeira coluna sao os IDs, a ultima coluna sao os labels
    nAtt = size(data, 2) - 2;

    dataX = data(:, 2:nAtt+1); % info
    dataY = data(:, nAtt+2); % labels, valores 2 ou 4
    [~, ~, dataY] = unique(dataY); % converte os labels strings para ints
end