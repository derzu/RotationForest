% Exemplo de chamada:
% [dadosX, dadosY] = readGlass('data/UCI/glass/glass.data.txt');
function [dataX, dataY] = readGlass(path)
    file = fopen(path);
    if file<=0
        fprintf('Erro arquivo \"%s\" nao encontrado\n', path);
        return;
    end
    fclose(file);
    
    data = csvread(path);
    
    % a primeira coluna sao os indices, a ultima coluna sao os labels
    nAtt = size(data, 2) - 2;

    dataX = data(:, 2:nAtt+1); % info
    dataY = data(:, nAtt+2); % labels
end