%
%
function [m] = geraDecisionTree(data, labels, tipo)

    %m = ClassificationTree.fit(data, labels);
    
    % Matlab (metodo CART)
    %m = fitctree(data, labels);
    
    % PRTools
    A = prdataset(data, labels);
    %A.prior = 0.1;
    %s = size(unique(labels), 1);
    %A = setprior(A, (1/s)*ones(1,s))
    
    %CRIT   Splitting citerion name.  ('igr', 'gini', 'miscls')
    if tipo==1
        m = dtc( A , 'igr'); % PRTools (metodo C4.5)
    else
        m = dtc( A , 'gini'); % PRTools (metodo C4.5)
    end
    %m = treec( A ); % PRTools (metodo ?)


end

% 'igr' Information Gain Ratio (default): 
% As defined by Quinlan. The penalty on the number of the distinct 
% values of the continues feature is used. If the gain is zero or 
% negative due to such penalization, the split is not performed. 
% This leads to smaller trees and may give non-zero training error. 
% This criterion does not use costs. (Costs are used only at the classification step).
% 
% 'gini' Gini impurity index. More precisely, the change in this 
% index. GINI index can be interpreted as a misclassification rate 
% for the stochastic prior based classifier, so costs are 
% naturally embedded. If the change in the (absolute) error less  
% or equal to 0.1 (change in the cost less or equal to 0.1 of minimal  
% absolute value of non-zero costs) the split is not performed. 
% This leads to smaller trees and may give non-zero training error. 
% 
% 'miscls' Classification error criterion. 
% To be used only for educational puposes because   
% it gives rather inferior results. Costs are naturally embedded.