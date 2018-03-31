% Exemplo de chamada:
% [dadosX, dadosY] = readSegmentation('data/UCI_segmentation/segmentation.data.txt');
function [dataX, dataY] = readSegmentation(path)
    file = fopen(path);
    if file<=0
        fprintf('Erro arquivo \"%s\" nao encontrado\n', path);
        return;
    end
    
    % ler 5 linhas de cabecalho.
    tline = fgets(file);
    tline = fgets(file);
    tline = fgets(file);
    tline = fgets(file);
    tline = fgets(file);
    
    data = textscan(file,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','Delimiter',',','CollectOutput',1);
    fclose(file);
    
    dataX = data{2}; % info
    dataY = data{1}; % labels
    [~, ~, dataY] = unique(dataY); % converte os labels strings para ints
end