%RANDOMBINARYVECTOR gera um vetor binario aleat?rio de tamanho C.
% Nao permite que o vetor seja todo de zeros ou todo de uns.
%   C - tamanho do vetor a ser gerado.
%
% $Author: Derzu Omaia
function [ vec ] = randomBinaryVector( C )
    if C==1
        vec = [1];
    else
        s = 0;
        vec = 0;
        % while para garantir que o vetor nao seja todo zerado nem todo de 1's.
        while s==0 || s==C
            vec = rand(C,1) > 0.5;
            s = sum(vec);
            % se 
            if C<=1
                break;
            end
        end
    end
end

