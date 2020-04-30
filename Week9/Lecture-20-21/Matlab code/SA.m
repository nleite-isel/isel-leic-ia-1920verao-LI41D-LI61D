function Res = SA(Tmax, Tmin, R, k, ...
    data, getInitialSolution, getRandomNeigh, evalFunc, ...
    isOptimum, sense)
    % Simulated Annealing (algorithm 2 for minimization of f) 
    % 
    % Step 1  Make T = Tmax  and Choose a solution u (at random) 
    % 
    % Step 2  Select a neighbor of u, say v 
    %         If f(v) < f(u) make u = v; 
    %         Else make u = v with probability  
    %              p = exp((fu-fv)/(fu * T))) 
    % 
    %         Repeat Step 2  k times 
    % 
    % Step 3  Make t = t+1; Set T = T(t) 
    %         see Eq.(4) of lecture notes  
    % 
    %         If  T >= Tmin  go to Step 2;    
    %         Else Stop. 
    % 
    
    % Rate increment variable
    t = 0;
    % Step 1  Make T = Tmax and
    T = Tmax;
    % Number of evaluations
    numEvaluations = 0;
    % Variable used to specify stop criteria
    foundOptimum = false;
    
    % Choose a solution u (at random) and compute fu = f(u) 
    u = getInitialSolution(data);
    fu = evalFunc(u, data);
    fprintf('Initial cost: %d\n', fu);
    % Increment number of evaluations
    numEvaluations = numEvaluations + 1;
      
    z = 1;
    F(z) = fu;
    z = z+1; 
    
    while (~foundOptimum)
        % Step 2  Select a neighbor of u, say v 
        %         If f(v) < f(u) make u = v; 
        %         Else make u = v with probability  
        %              p = exp((fu-fv)/(fu * T))) 
        % 
        %         Repeat Step 2   k times 
        i = 0;
        while (i < k && ~foundOptimum)
            % Select a neighbor of u, say v. 
            v = getRandomNeigh(u, data);
            % Evaluate v
            fv = evalFunc(v, data);
            % Increment number of evaluations
            numEvaluations = numEvaluations + 1;
            
            % If f(v) < f(u) (minimization) make u = v; 
            % Else make u = v with probability  
            %   p = exp((fu-fv)/(fu T))) 
            dif = fv-fu;
            if (strcmp(sense, 'maximize'))
                dif = -dif;
            end
                
%             if (fv < fu) % Minimization problem
%             if (fv > fu) % Maximization problem
            if (dif < 0)
                u = v;
                fu = fv;
            else
                prob = p(fu, fv, T, sense)
                x = myRand()
                if (x <= prob)
                    % Accept this solution
                    u = v;
                    fu = fv;
               end
            end
            % Make i = i+1. 
            i = i + 1;
            
            F(z) = fu;
            z = z+1;
            
            % if optimum found then stop.
            if isOptimum(fu, data)
                foundOptimum = true;
            end
        end

        if ~foundOptimum
            % Step 3  Make t = t+1; Set T = T(t) 
            % see Eq.(4) of lecture notes
            t = t + 1;
            T = Temp(t, Tmax, R);
            % If  T < Tmin  Stop.  
            if (T < Tmin)
                break;
            end
        end
    end
    
    disp('BestCost: '); 
    disp(fu);
    
    disp('numEvaluations: '); 
    disp(numEvaluations);
    
    Res = struct('T', T, 'NumEvaluations', numEvaluations, 'Cost', fu, ...
        'Tmax', Tmax, 'Tmin', Tmin, 'R', R, 'k', k, ...
        'u', u.solution, 'F', F, 's', u);
    
    figure(1);
    plot(F);
    %pause
    
end

%/////////////////////////////////////////////////////

% Temperature actualization
function newtemp = Temp(t, Tmax, R)
%Outra hipotese: decrescimento quadratico
% R = ]0,1[, e.g., R = 0.99 (mais lento) ou 0.1 (mais rapido)
% newTemp = R*Tmax;
    newtemp = Tmax * exp(-R * t);
end
    
% Random number generator
function r = myRand()
    r = rand();
end


% Probability function
function x = p(fu, fv, T, sense)
    if strcmp(sense, 'maximize')
        % Maximization problem
        x = exp((fv-fu) / (T*fu));
    elseif strcmp(sense, 'minimize')
        % Minimization problem
        x = exp((fu-fv) / (T*fu));
    end
end























