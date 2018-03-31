% Exemplo de chamada:
% [dadosX, dadosY] = readDB(5, DBsList);
%
% $Author: Derzu Omaia
function [dadosXraw, dadosYraw] = readDB(indiceDB, DBS_name)
%%%%% SELECIONA O BANCO DE DADOS %%%%%%%

    dadosXraw = 0;
    dadosYraw = 0;
        
    switch indiceDB
        case 1
            [dadosXraw, dadosYraw] = readBalance(DBS_name{indiceDB});
        case 2
            [dadosXraw, dadosYraw] = readBcw(DBS_name{indiceDB});
        case 3
            [dadosXraw, dadosYraw] = readMusk(DBS_name{indiceDB});
        case 4
            [dadosXraw, dadosYraw] = readGlass(DBS_name{indiceDB});
        case 5
            [dadosXraw, dadosYraw] = readIonosphere();
        case 6
            [dadosXraw, dadosYraw] = readIris();
        case {7, 8, 9, 10}
            [dadosXraw, dadosYraw] = readMfeat(DBS_name{indiceDB});
        case 11
            [dadosXraw, dadosYraw] = readOptDigits(DBS_name{indiceDB});
        case 12
            [dadosXraw, dadosYraw] = readPenDigits(DBS_name{indiceDB});
        case 13
            [dadosXraw, dadosYraw] = readDiabetes(DBS_name{indiceDB});
        case {14, 15}
            % le o banco de dados Segmentation
            [dadosXraw, dadosYraw] = readSegmentation(DBS_name{1});
            [dadosX2, dadosY2] = readSegmentation(DBS_name{2});
            % esse banco ja tava separado em teste e treinamento, agora junta os 2.
            dadosXraw = [dadosXraw ; dadosX2];
            dadosYraw = [dadosYraw ; dadosY2];
        case 16
            [dadosXraw, dadosYraw] = readSonar(DBS_name{indiceDB});
        case 17
            [dadosXraw, dadosYraw] = readVowel_n(DBS_name{indiceDB});
 
    end
end

            