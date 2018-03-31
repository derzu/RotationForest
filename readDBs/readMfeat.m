% Exemplo de chamada:
% [dadosX, dadosY] = readMfeat('data/UCI/mfeat/mfeat-fac.txt');
function [dataX, dataY] = readMfeat(path)
    file = fopen(path);
    if file<=0
        fprintf('Erro arquivo \"%s\" nao encontrado\n', path);
        return;
    end
    fclose(file);
    
    dataX = dlmread(path);
    dataY = zeros(2000, 1);
    p = 200;
    for i=1:10
        dataY(p*(i-1)+1:p*i) = i-1; 
    end
end