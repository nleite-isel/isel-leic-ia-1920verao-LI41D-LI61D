function Res = GA(data, tmax, popSize, crossProb, ...
                        mutProb, select, cross, mutate, ...
                        getInitialSolution, ...
                        evalFunc, isOptimum, sense)
    % GA Genetic Algorithm
    %   Make t = 0;
    %   Initialize the population P(0), at random.
    %   Evaluate P(0)
    %   Repeat step 1 to 5 (until close to saturation)
    %     Step 1 t = t+1
    %     Step 2 Select the fittest from P(t-1) to build P(t)
    %     Step 3 Cross P(t)
    %     Step 4 Mutate some solution from P(t)
    %     Step 5 Evaluate P(t)
    %

    % Number of evaluations
    numEvaluations = 0;
    % Variable used to specify stop criteria
    foundOptimum = false;
    
    % Initialize the population P(0), at random.
    initialPop = getInitialPopulation(data, popSize, getInitialSolution);
    % Evaluate P(0)
    initialPopFit =  evaluatePopulation(data, initialPop, evalFunc);   
    % Increment number of evaluations
    numEvaluations = numEvaluations + popSize;
    % Current population and evaluation
    pop = initialPop;
    popFit = initialPopFit;
     
    j = 1;
    % Get best fitness
    fu = getBestFitness(popFit, sense);
    Fit(j) = fu;
    % Mean fitness
    MeanFit(j) = mean(popFit);
    j = j+1;
    
    % Iteration index
    t = 0;
    % Repeat step 1 to 5 (until close to saturation)
    while (t < tmax && ~foundOptimum)
        % Step 1 Increment iteration index
        t = t+1;
        % Step 2 Select the fittest from P(t-1) to build P(t)
        %pop = select(pop, popFit, sense);
        pop = select(pop, popFit);
        % Step 3 Cross P(t)
        pop = cross(data, pop, crossProb);
        % Step 4 Mutate some solution from P(t)
        pop = mutate(data, pop, mutProb);
        % Step 5 Evaluate P(t)
        popFit = evaluatePopulation(data, pop, evalFunc);

        % Show first solution
        %pop(1,:)
        
        % Increment number of evaluations
        numEvaluations = numEvaluations + popSize;
        % Get best fitness
        fu = getBestFitness(popFit, sense)
        Fit(j) = fu;
         % Mean fitness
        MeanFit(j) = mean(popFit);
        j = j+1;
        % if optimum found then stop.
        if isOptimum(fu, data)
            foundOptimum = true;
        end
    end

    % Get best solution
    [fu, I] = getBestFitness(popFit, sense);
    u = pop(I(1));
    
    disp('BestCost: '); 
    disp(fu);
    
    disp('numEvaluations: '); 
    disp(numEvaluations);
    
    % Plot
    figure(1)
    plot(Fit);
    i = 1 : t+1; % t reaches tmax if the optimum solution is not found before
    Fit;
    MeanFit;
    t
    figure(2)
    plot(i, Fit / data.optimum * 100, 'k-', i, MeanFit / data.optimum * 100, 'k:');
    xlabel('Generation no.');
    ylabel('Fitness (%)');
    axis([1 t+1 50 110]);
    legend('Pop Max', 'Pop Mean');
    %pause
    
    Res = struct('NumEvaluations', numEvaluations, 'Cost', fu, ...
        'tmax', tmax, 'popSize', popSize, 'crossProb', crossProb, ...
        'mutProb', mutProb, 'u', u, 's', u, 'Fit', Fit);
    
end

%////////////////////////////////////////////////////////////

function [Fit, I] = getBestFitness(popFit, sense)
    if strcmp(sense, 'maximize')
        % Maximization problem
        [Fit, I] = max(popFit);
    elseif strcmp(sense, 'minimize')
        [Fit, I] = min(popFit);
    end
end

% Generate initial population
function P = getInitialPopulation(data, popSize, getInitialSolution)
    for i = 1 : popSize
        P(i,:) = getInitialSolution(data);
    end 
end

% Evaluate population
function FP = evaluatePopulation(data, population, evalFunc)
    popSize = size(population,1);
    for i = 1 : popSize
        FP(i) = evalFunc(population(i,:), data);
    end 
end
































