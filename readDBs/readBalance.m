% Exemplo de chamada:
% [dadosX, dadosY] = readBalance('data/UCI/balance-scale/balance-scale.data.txt');
%
% $Author: Derzu Omaia
function [dataX, dataY] = readBalance(path)
    file = fopen(path);
    if file<=0
        fprintf('Erro arquivo \"%s\" nao encontrado\n', path);
        return;
    end
    
    data = textscan(file,'%s %f %f %f %f','Delimiter',',','CollectOutput',1);
    fclose(file);
    %data
    
    dataX = data{2}; % info
    dataY = data{1}; % labels
    [~, ~, dataY] = unique(dataY); % converte os labels strings para ints
end