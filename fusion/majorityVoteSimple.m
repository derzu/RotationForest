% Fusion results using majority vote rule.
%
% @param results list of results
%
% @return fusionResult
%
% $Author: Derzu Omaia
function [ fusionResult ] = majorityVoteSimple( results )

    M = size(results, 1);

    fusionResult = zeros(M, 1); % primeiro lugar do voto majoritario
    
    %majority vote
    % Para cada amostra (de M) olha todos os resultados dos T classificadores
    for i=1:M
        [unique_strings, ~, string_map]=unique(results(i, :));
        
        most_common_string=unique_strings(mode(string_map));
        fusionResult(i) = most_common_string;
    end
end

