% It's an implementation of the Rotation Forest Algorithm from paper from Kuncheva and Rodr?guez, 2016.
% It's a MCS (Multiple Classifier Systems) and it's result is compared with the bagging MCS.
%
% The training an classification stages are run. It's tested using an 10-fold cross validation process.
%
% $Author: Derzu Omaia

close all;

% remove prtools warnings
prwarning(0);

% teste index
indiceDB = 6;
        
DBS_name = [{'data/UCI/balance-scale/balance-scale.data.txt'} ;...%01  % 3 different classes 
            {'data/UCI/bcw/breast-cancer-wisconsin.data.txt'} ;...%02 
            {'data/UCI/musk/clean2.data'} ;...%03
            {'data/UCI/glass/glass.data.txt'} ;...%04 
            {'ionosphere.mat'} ;...%05 
            {'iris.dat'} ;...%06
            {'data/UCI/mfeat/mfeat-fac.txt'} ;...%07
            {'data/UCI/mfeat/mfeat-kar.txt'} ;...%08
            {'data/UCI/mfeat/mfeat-mor.txt'} ;...%09
            {'data/UCI/mfeat/mfeat-zer.txt'} ;...%10
            {'data/UCI/optdigits/optdigits.all'} ;...%11
            {'data/UCI/pendigits/pendigits.all'} ;...%12
            {'data/UCI/diabetes/pima-indians-diabetes.data.txt'} ;...%13
            {'data/UCI/segmentation/segmentation.data.txt'} ;...%14 % 7 different classes 
            {'data/UCI/segmentation/segmentation.test.txt'} ;...%15
            {'data/UCI/sonar/sonar.all-data.txt'} ;...%16 
            {'data/UCI/vowel/vowel-context.data.txt'} ;...%17  % 10 different classes
            ];

[dadosX, dadosY] = readDB(indiceDB, DBS_name);

fprintf('Testing DB %s\n', DBS_name{indiceDB});
Nfolds = 10;
ratio=0.75;
indices = crossvalind('Kfold', size(dadosX, 1), Nfolds);

accRotF_m=0;

for Kfold=1:Nfolds
    % cross validation, separa os 2 grupos de treino e teste.
    test = (indices == Kfold); train = ~test;
    testX = dadosX(test, :); % testX is de test set
    testY = dadosY(test, :); % Y vector is a label vector
    trainX = dadosX(train, :); % trainX is the training set
    trainY = dadosY(train, :); % Y vector is a label vector
    
    numberfeature=size(trainX,2);

    % NUMBER OF CLASSIFIERS INSIDE THE ENSEMBLE.
    % NUMERO CLASSIFICADORES NO ENSEMBLE.
    % VALOR USADO NO ARTIGO FOI 10
    % L=10; %% number of ensemble individuals;
    % try diferentes L's
    Lini = 10;
    Lp   = 10;
    Lfim = 20;

    % SUGESTAO DO ARTIGO EH QUE CADA SUBSET TENHA TAMANHO 3, OU SEJA,
    % K = numberfeature/3;
    K = floor(numberfeature/3);
    Kp = int8(numberfeature/20);
    if Kp==0
        Kp=1;
    end
    Kini = K-Kp;
    Kfim = K+Kp*2;
    
    M = floor(numberfeature/K);

    if Kfim > numberfeature
        Kfim = numberfeature;
    end
    if Kini > numberfeature || Kini < 1
        Kini = 1;
    end
    
%fprintf('M=%d, K=%d, Kini = %d, Kp=%d, Kfim = %d\n', M, K, Kini, Kp, Kfim);

    if mod(Kfim-Kini,Kp)==0
        d1=floor((Kfim-Kini)/Kp+1);
    else
        d1=floor((Kfim-Kini)/Kp);
    end
    if mod(Lfim-Lini,Lp)==0
        d2=floor((Lfim-Lini)/Lp+1);
    else
        d2=floor((Lfim-Lini)/Lp);
    end
    accBagg = zeros(d1, d2);
    
    if accRotF_m==0
        accRotF_m=zeros(d1, d2);
        accBagg_m=zeros(d1, d2);
    end

    fprintf('Kfold=%d ', Kfold);

    for L=Lini:Lp:Lfim
        for K=Kini:Kp:Kfim
            % Creat and classify a pool of classifing using just bagging, for comparation with the Rotation Forest.
            pool = baggingPool(trainX, trainY, L, 't');
            accBagg(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1)) = 1-classificaPoolSimple(pool, testX, testY);
            accBagg_m(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1)) = accBagg_m(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1)) + accBagg(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1));
            % end of just bagging algorithm
            
            prelabeltest = zeros(size(testX, 1), L);
            
            % Now starting Rotation Forest Algorithm
            % Create L classifiers, and do the classification for each one.
            for l=1:L
                %%% obtain the new samples by rotation forest %%%
                Ra=rotationForest(trainX, trainY, K, 0);

                % Treina usando arvore de decisao. Last param is the type of the tree.
                arvore = geraDecisionTree(trainX*Ra, trainY, 0); 
                
                % Classify using decision tree
                if isa(arvore, 'prmapping')
                    prelabeltest(:,l) = labeld(testX*Ra, arvore);
                else
                    prelabeltest(:,l) = predict(arvore,testX*Ra);
                end
            end
            
            % Majority vote for result fusion.
            [~, r] = majorityVoteSimpleTx(prelabeltest, testY);
            
            M = floor(numberfeature/K);

            %%% compute the accuracy rate of ensemble %%%
            accRotF_m(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1)) = accRotF_m(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1)) + r;
        end
    end
end % Kfold

%Faz a media
% Avarage accurace
accRotF_m = accRotF_m./Nfolds;
accBagg_m = accBagg_m./Nfolds;

fprintf('\n%s:\n', DBS_name{indiceDB});
for L=Lini:Lp:Lfim
    for K=Kini:Kp:Kfim
        M = floor(numberfeature/K);
        fprintf('L=%3d::K=%3d::M=%d::', L, K, M);
        fprintf('RotF = %f,', accRotF_m(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1)) );
        fprintf(' bagging = %f\n', accBagg_m(floor((K-Kini)/Kp+1), floor((L-Lini)/Lp+1)) );
    end
end

displayChart( accRotF_m, accBagg_m, Kini, Kp, Kfim, Lini, Lp, Lfim, 'RotF', 'bagging');