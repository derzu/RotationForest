function displayChart( accRotF1_m, accRotF2_m, Kini, Kp, Kfim, Lini, Lp, Lfim, leg1, leg2)
%EXIBEGRAFICOS Summary of this function goes here
%   Detailed explanation goes here

linhas = [{'--b*'}; {'-ro'}; {':g+'}; {'--r*'}; {'-go'}; {':b+'}; {'--g*'}; {'-bo'}; {':r+'}];
sLinha = size(linhas,1);

if Kfim-Kini > 0
    % Exibicao do grafico
    figure();
    x = [Kini:Kp:Kfim];
    for L=Lini:Lp:Lfim
        plot(x, accRotF1_m(:, floor((L-Lini)/Lp+1)), linhas{1}, 'LineWidth', 2);
        hold on;
        plot(x, accRotF2_m(:, floor((L-Lini)/Lp+1)), linhas{2}, 'LineWidth', 2);
        hold on;
    end
    hold off;
    title('Classificacao utilizando Rotation Forest');
    %xlabel('Quant Classificadores no pool');
    %xlabel('M elementos em cada split');
    xlabel('K splits');
    ylabel('Accurace Rate');
    %legend('Data1(blue)', 'Data2 (red)');
    legend(leg1, leg2);
end

end

