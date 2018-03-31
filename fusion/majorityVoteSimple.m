function [ resultadoFusao ] = majorityVoteSimple( resultados )

    M = size(resultados, 1);

    resultadoFusao = zeros(M, 1); % primeiro lugar do voto majoritario
    
    %majority vote
    % Para cada amostra (de M) olha todos os resultados dos T classificadores
    for i=1:M
        [unique_strings, ~, string_map]=unique(resultados(i, :));
        
        most_common_string=unique_strings(mode(string_map));
        resultadoFusao(i) = most_common_string;
    end
end

