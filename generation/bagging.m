% Bootstrap AGGregatING algorithm from BREIMAN, 1996
% Gera T subconjutos de dados
%
% @param dados matriz MxD (linha x coluna). M amostras (instances), D atributos (features).
% @param T quantidade de subconjutos
% @param m tamanho (quantidade de amostras) do subconjuto gerado. Opcional,
% caso seja omitido eh gerado um subconjunto com a mesma quantida de
% amostras de dados.
%
% @return os indices das amostras de dados a serem usadas. Cada indice
% representa uma amostra com seus varios atributos.
%
% Exemplo de uso:
% bag = bagging(data, 10);
%
% $Author: Derzu Omaia
function [bag] = bagging(dados, T, varargin) % varargin eh uma lista de parametros.
    [M,D] = size(dados); % M amostras, D atributos.

    % trata se tem o parametro do tamanho do subconjunto, se nao tiver usa o default.
    if (length(varargin)==1)
        m = varargin{1};
    else
        m = M;
    end
    
    % inicializa seed do gerador de numeros aleatorios.
    rng('shuffle','twister'); % TODO descomentar, a versao 2009 nao tem essa funcao.
    
    bag = zeros(T, m);
    for i=1:T
        % gera um vetor 1xm com os indices das amostras que devem ser utilizadas
        r = randi([1 M],1,m);
        bag(i,:) = r;
    end
end