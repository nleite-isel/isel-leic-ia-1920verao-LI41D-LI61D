function Res = HC(tmax, getInitialSolution, getNeighbors, ...
    costFunction, evalFunction, isOptimum, sense)
    % HC Hill climber
    %     
    % Hill climber (steepest ascent) 
    %  
    % Step 1 Choose a solution (any) 
    % Step 2 Define its neighbors and evaluate them 
    % Step 3 Move to the best neighbor and go to step 2 while some 
    % criteria is not met 
   
    % Number of evaluations
    numEvaluations = 0;
    % Variable used to specify stop criteria
    foundOptimum = false;
    % Choose a solution u (at random) and compute fu = f(u) 
    S = getInitialSolution();
    Cost = evalFunction(S.solution);
    fprintf('Initial Cost: %d\n', Cost);
    % Increment number of evaluations
    numEvaluations = numEvaluations + 1;
    % Repeat step 1 to 3 (until t = tmax) 
    t = 1;
    % Cost array
    Z = zeros(tmax,1);
    % Number of neighbors
    N = 5;
    
    while (t <= tmax && ~foundOptimum)
        % Actualize cost
        Z(t) = Cost;
        % Step 2 Define its neighbors and evaluate them 
        Neighs = getNeighbors(S);
        % Add S to neighbors
        Neighs{N + 1} = S;
        % Calculate cost function
        CostNeighs = costFunction(Neighs)
        % Increment number of evaluations
        numEvaluations = numEvaluations + N;
        % Step 3 Move to the best neighbor and go to step 2 while some 
        % criteria is not met 
        % Best solutions
        [C, I] = max(CostNeighs);
        % Find all the best
        I = find (CostNeighs == C);
        % Choose one of the best randomly
        idx = randi(size(I));
        % New solution
        S = Neighs{I(idx)};
        % New cost
        Cost = C
        % if optimum found then stop.
        if isOptimum(Cost)
            foundOptimum = true;
        end
        % Make t = t+1. 
        t = t + 1;
    end
    % Actualize cost
    Z(t) = Cost;

    fprintf('\nNumber of iterations: %d\n', t);
    
    fprintf('\nNumber of evaluations: %d\n', numEvaluations);
    fprintf('BestCost: %d\n', Cost);
    
    plot(Z);
    %pause
    
    Res = struct('tmax', tmax, 'NumEvaluations', ...
                 numEvaluations, 'Cost', Cost);
end
    
    
 










