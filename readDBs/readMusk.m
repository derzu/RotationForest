% Exemplo de chamada:
% [dadosX, dadosY] = readMusk('data/UCI/musk/clean2.data');
%
% $Author: Derzu Omaia
function [dataX, dataY] = readMusk(path)
    file = fopen(path);
    if file<=0
        fprintf('Error file \"%s\" not found\n', path);
        return;
    end
    fclose(file);
    
    data = dlmread(path, ',', 0, 2);
    nAtt = size(data, 2) - 1;

    dataX = data(:, 1:nAtt); % info
    dataY = data(:, nAtt+1); % labels
end