% Exemplo de chamada:
% [dadosX, dadosY] = readOptDigits('data/UCI/optdigits/optdigits.all');
function [dataX, dataY] = readOptDigits(path)
    file = fopen(path);
    if file<=0
        fprintf('Erro arquivo \"%s\" nao encontrado\n', path);
        return;
    end
    fclose(file);
    
    data = csvread(path);
    nAtt = size(data, 2) - 1;

    dataX = data(:, 1:nAtt); % info
    dataY = data(:, nAtt+1); % labels
end