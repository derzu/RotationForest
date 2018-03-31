% Gera um subconjutos diverso de dados a partir dos dados originais.
%
% @param X conjunto de amostras. Matriz Nxn (linha x coluna). N amostras (instances), n features.
% @param Y (labels - Nx1) vetor com os rotulos dos objetos de X.
% @param K numero de subsets desejados
%
% @return o subconjunto de dados diverso, X, e a matriz de transformacao,
% matrix.
%
% Forma de uso:
% [Ra] = rotationForest(X, Y, K);
function [ Ra ] = rotationForest( X, Y, K, remove)
    % N amostras (instances), n atributos (features).
    [N, n] = size(X);
    
    %
    bootstrap = 0.75;
    %bootstrap = 1; % TODO UNDO
    
    % W - Vetor de todas as classes.
    W = unique(Y);
    % C - quantiade de classes.
    Cclasses = length(W);

    % M_ideal = quantidade features em cada subset.
    resto = mod(n, K);
    M_ideal = (n-resto)/K;
    %fprintf('M = %d, resto=%d\n', M_ideal, resto); 
    %fprintf('testeP\n');
    %fprintf('N=%d, n=%d, K=%d, M=%d, resto=%d\n', N, n, K, M_ideal, resto);
    
    Xnew = 0;
    matrix = 0;

    %fprintf('n=%d, K=%d\n', n, K);
    % usa o crossvalind para gerar subconjuntos de features.
    indFeatures = crossvalind('Kfold', n, double(K));

    C = cell(K,1);
    MAcc = 0;
    MjAcc = 0;
    M = zeros(K, 1); % O M tambem varia de acordo com o J, apenas 1 vez. Nas demais possui o mesmo valor.
    Mj = zeros(K, 1); % Varia de acordo com a PCA, no caso ideal vai ser igual a M, mas pode ser menor, caso haja eingevectors zerados.
    for j=1:K
        %input('comecando j');
        % Fj vetor com os indice das features do split atual
        Fj = (indFeatures==j);
        %fprintf('Cclasses = %d\n', Cclasses);

        %WCj = selectSubclassesVector(Y, remove);
        if Cclasses>1
            % WCj indices das amostras das classes selecionadas no W reduzido.
            WCj = selectSubclassesVector(Y, remove);
        else
            % se so tiver uma classe remove aleatoriamente um subcluseter
            % dessa classe.
            idx = drz_means(X);
            WCj = selectSubclassesVector(idx, 0);
        end
        % se so tiver uma amostra entao pega o oposto.
        if sum(WCj)==1
            WCj = ~WCj;
        end

        
        %Xj1 = X(:, Fj)
        %Xj2 = X(WCj, Fj)

        % Xj fica so com o subconjunto de features e classes.
        % Xj eh Nred x M. Nred amostras (instances), M features. O ultimo
        % split pode ser menor que M.
        Xj = X(WCj, Fj);
        Yj = Y(WCj);

        % Nj - quant amostras depois de remover algumas classes.
        % M - quant features no J-esimo split, a maioria vai ser igual a M, mas 1
        % delas pode nao ser. Isto ocorre quando a divisao de n/K nao tem
        % resto zero.
        [Nj, M(j)] = size(Xj);
        
        % X linha (X_) - bootstrap sample of Xj
        % O '1' eh pq a funcao bagging pode retornar uma matriz com varios
        % bootstraps. Mas nesse caso esta sendo gerada so 1 bootstrap.
        Nred = round(Nj*bootstrap);
        bag = bagging(Xj, 1, Nred);
        X_ = Xj(bag, :);
        %X_
        
        % PCA. Retorna uma matriz MxMj com os principais componentes.
        C{j} = pca(X_);
        
        % Mj <= M. "It's possible that some of the eigenvalues are
        % zero, therefore, we may not have all M vectors."
        Mj(j) = size(C{j}, 2);
        %fprintf('M=%d, Mj=%d\n', M(j), Mj(j));
        
        % incrementa os acumuladores, para saber o tamanho da matriz R.
        MAcc = MAcc + M(j);
        MjAcc = MjAcc + Mj(j);
        
        %break;
    end
    
    %fprintf('MAcc=%d, MjAcc=%d\n', MAcc, MjAcc);
    %input('pause');

    R = zeros(MAcc+1, MjAcc); % +1 pra adicionar os indices de ordenacao.
    lastLine = MAcc+1;
    MAcc = 0;
    MjAcc = 0;
    for j=1:K
        l = MAcc+1;
        c = MjAcc+1;
        % coloca a matriz C{j} (pca(X_)) na posicao correta na matriz R
        R(l:l+M(j)-1, c:c+Mj(j)-1) = C{j};
        R(lastLine, c:c+Mj(j)-1) = 1:Mj(j); % adiciona os indices de ordenacao.
        
        % incrementa os acumuladores.
        MjAcc = MjAcc + Mj(j);
        MAcc = MAcc + M(j);
        
        %fprintf('M(j)=%d, Mj=%d, sum(Fj)=%d\n', M(j), Mj(j), sum(Fj));
        %break
    end
    
    %R
    Ra = sortrows(R', lastLine)';
    %X
    Ra = Ra(1:lastLine-1,:);
    %X*Ra
end

