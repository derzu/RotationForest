% Exemplo de chamada:
% [dadosX, dadosY] = readVowel_n('data/UCI/vowel/vowel-context.data.txt');
%
% $Author: Derzu Omaia
function [dataX, dataY] = readVowel_n(path)
    file = fopen(path);
    if file<=0
        fprintf('Error file \"%s\" not found\n', path);
        return;
    end
    
    % descarta o 1 primeiros (Train or Test)
    %data = textscan(file,'%d %f %f %f %f %f %f %f %f %f %f %f %f %d','Delimiter',',','CollectOutput',1);
    
    % descarta os 3 primeiros (Train or Test, Speaker Number, Sex)
    %data = textscan(file,'%d %d %d %f %f %f %f %f %f %f %f %f %f %d','Delimiter',',','CollectOutput',1);
    
    % descarta os 2 primeiros (Train or Test, Speaker Number)
    data = textscan(file,'%d %d %f %f %f %f %f %f %f %f %f %f %f %d','Delimiter',',','CollectOutput',1);
    
    fclose(file);
    
    %data{1} eh descaratado;
    dataX = data{2}; % info
    dataY = data{3}; % labels
    [~, ~, dataY] = unique(dataY); % converte os labels strings para ints
end