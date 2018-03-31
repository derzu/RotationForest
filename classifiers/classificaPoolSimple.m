% classifica um conjunto de dados utilizand um POOL de classificadores.
% Funde o resultado utilizando voto majoritario.
% retorna taxa de erro.
%
% $Author: Derzu Omaia
function [ erros ] = classificaPoolSimple( pool , data, labels)
    % T quantidade de classificadores no pool
    T = size(pool, 1);
    
    M = size(data,1); % M amostras no banco de teste
    
    resultados = zeros(M, T);

    for i=1:T
        if isa(pool{i}, 'prmapping')
            resultados(:, i) = labeld(data, pool{i});
        else
            resultados(:, i) = predict(pool{i},data);
        end
    end
    
    
    resultadoFusao1 = majorityVoteSimple(resultados);

    erros = 0;
    for i=1:M
        if resultadoFusao1(i)~=labels(i)
            erros = erros + 1;
        %else
        %    acertos = acertos + 1;
        end 
    end
    %fprintf('classificaPool::erros=%d', erros);
    erros = erros/M;
    %acertos = acertos/M;
end

