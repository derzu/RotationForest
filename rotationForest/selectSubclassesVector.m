function [ vec ] = selectSubclassesVector( Y, remove )
%SELECTSUBCLASSESVECTOR Aleatoriamente seleciona um um subconjunto de
% classes de Y. Retorna o vetor com 1's nos indices das amostras das classes
% selecionadas.
    % N - quantiade de amostras.
    N = length(Y);
    % W - Vetor de todas as classes.
    W = unique(Y);
    % C - quantiade de classes.
    C = length(W);
    
    if remove==1
        per = 0.75;
    else
        per = 1;
    end
    % AQUI COMO SO TEM UMA CLASSE ELE NAO EXCLUI NADA. FAZER PARA EXCLUIR
    % AS AMOSTRAS ALETAORIAMENTE. TALVEZ LIMITAR A EXCLUIR NO MAXIMO 50%
    
    
    % se C for 1, entao nao da para excluir classes. Serao excluidas
    % amostras aletaorias
    if C==1
        N_1s = round(N*per);
        N_0s = N - N_1s;
    
        vec = [ones(1,N_1s), zeros(1,N_0s)]; 
        vec = vec(randperm(N));
        
        vec = logical(vec);
        return;
    end

    
    
    % gera um vetor binario aleatorio, com valor 1 na posicao correspondente
    % aos indies das classes que serao selecionadas.
    v = randomBinaryVector(C);
    
    
    % W reduzido, com apenas algumas classes.
    Wred = W(v);
    Cred = size(Wred, 1);
    vec = zeros(N, 1);
    % percorre o vetor Y e verifica quais rotulos estao em Wred. Os que
    % estiverem recebem 1 em vec.
    for k=1:N
        for l=1:Cred
            % se a classe da amostra K estiver entre o conjunto (Wred) de
            % classes permitidas.
            if Y(k)==Wred(l)
                vec(k) = 1;
            end
        end
    end
    
    % converte para um vetor boolean
    vec = logical(vec);
end

