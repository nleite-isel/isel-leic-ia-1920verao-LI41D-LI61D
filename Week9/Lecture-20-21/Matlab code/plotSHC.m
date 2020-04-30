function plotSHC 
    %
    % Minimization problem (in max. problems we should interchange fv with fu)
    %
    clc;
    
    x = -10:0.1:10;
    T = [0.1 0.4 0.8 1.8 4.0 8.0 20.0];
   
    for i = 1 : size(T,2)
        y = prob(x, T(i));
        if (i == 4)
            plot(x, y, '-');
        else
            plot(x, y, '--');
        end
        hold on;
    end
   
    text(0.3,0.9, 'T<<');
    text(-6,0.53, 'T>>');
    xlabel('Relative performance')
    ylabel('Probability')
    % /////////////////////////////////////////
    
    fv = -50:1:91;    
    %fv = 50:1:91;
    fu = 50;
    %T = 10;
    %T = 1;
    T = .1;
    
    for i=1 : length(fv)
        y1(i) = p1(fu, fv(i), T);
        y2(i) = p2(fu, fv(i), T);
    end
   % [fv' y1' y2']
   
   fprintf('%g\n', y2);
   
    
   figure(2)
   plot(fv, y1, '-');
   
   figure(3)
   plot(fv, y2, '-');
    
   pause;
   close all;
end


function v = prob(x, T)
    v = 1 ./ (1 + exp(x/T));
end

function v1 = p1(fu, fv, T)
    v1 = 1 ./ (1 + exp((fv-fu)/(fu*T)));
end


% SA
function v2 = p2(fu, fv, T)
    v2 = exp(-(fv-fu)/(fu*T));
end












