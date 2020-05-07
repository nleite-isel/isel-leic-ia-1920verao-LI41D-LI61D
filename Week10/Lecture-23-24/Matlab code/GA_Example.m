function Res = GA_Example(tmax, popSize, crossProb, mutProb, data)
    %
    % Genetic algorithm
    % Make t = 0;
    % Initialize the population P(0), at random.
    % Evaluate P(0)
    % Repeat step 1 to 5 (until close to saturation)
    %   Step 1 t = t+1
    %   Step 2 Select the fittest from P(t-1) to build P(t)
    %   Step 3 Cross P(t)
    %   Step 4 Mutate some solution from P(t)
    %   Step 5 Evaluate P(t)
    %
    %
    
    % Maximization problem
    sense = 'maximize';

    Res = GA(data, tmax, popSize, crossProb, ...
             mutProb, @select, @cross, @mutate, ...
             @getInitialSolution, ...
             @evalFunction, @isOptimum, sense);
    
end


%////////////////////////////////////////////////////////////

% Selection
function newPop = select(pop, f)
    popSize = length(pop);
    popRandIdxs = randi([1, popSize], 1, popSize);
    % Binary tournament selection
    for i = 1 : popSize
        if f(i) > f(popRandIdxs(i))
            newPop(i, :) = pop(i, :);
        else
            newPop(i, :) = pop(popRandIdxs(i), :);
        end
    end 
end

% Crossing
function newPop = cross(data, pop, crossProb)
    % one-point crossover
     newPop = onePointCrossover(data, pop, crossProb);

    % two-point crossover
%    newPop = twoPointCrossover(data, pop, crossProb);
end


function newPop = twoPointCrossover(data, pop, crossProb)
    % N
    N = data.N;
    popSize = size(pop, 1);
    crossIdxs = randi([1,N], popSize/2, 2); % Two indexes
    % Sort indexes
    crossIdxs = sort(crossIdxs')';
    newPop = pop;
    probs = rand(popSize/2, 1);
    k = 0;
    for j = 1:2:popSize,
        k = k+1;
        if  probs(k) < crossProb
            middleIdxs = crossIdxs(k,1)+1:crossIdxs(k,2);
            middle1 = newPop(j, middleIdxs); % Middle of first parent
            middle2 = newPop(j+1, middleIdxs); % Middle of second parent
            % Exchange info            
            newPop(j, middleIdxs) = middle2; 
            newPop(j+1, middleIdxs) = middle1;
        end
    end
 end


function newPop = onePointCrossover(data, pop, crossProb)
    % N
    N = data.N;
    popSize = size(pop, 1);
    crossIdxs = randi([1,N], popSize, 1);
    newPop = pop;
    probs = rand(popSize/2, 1);
    k = 0;
    for j = 1:2:popSize,
        k = k+1;
        if  probs(k) < crossProb
            aux = newPop(j, crossIdxs(j):N); % Right part
            newPop(j, crossIdxs(j):N) = newPop(j+1, crossIdxs(j):N); % Right part
            newPop(j+1, crossIdxs(j):N) = aux;
        end
    end
 end


% Mutation
function newPop = mutate(data, pop, mutProb)
    % N
    N = data.N;
    % one-bit mutation
    popSize = size(pop, 1);
    mutIdxs = randi([1,N], popSize, 1);
    newPop = pop;
    probs = rand(popSize, 1);
    for j = 1:popSize,
        if probs(j) < mutProb
            if newPop(j, mutIdxs(j)) == 0
                newPop(j, mutIdxs(j)) = 1;
            else
                newPop(j, mutIdxs(j)) = 0;
            end
        end
    end
end

% mutProb = 0.10
% 
% probs = [0.01,
%  0.25,
%  0.3,
%  0.78,
%  0.09
%  0.65
%  ]
% 
% It will mutate solutions at indices j = 1  (probs[1]=0.01),
% and j = 5  (probs[5]=0.09)


%////////////////////////////////////////////////////////////

% isOptimum
% The global maximum of this function is 01010 (x = 10, f(x) = 4100).
% The parameter fu is the target function (function to be maximized) 
% value 
function res = isOptimum(fu, data)
    if fu == data.optimum
        res = true;
    else
        res = false;
    end
end

% Generate initial population
function P = getInitialPopulation(data, popSize)
    for i = 1 : popSize
        P(i,:) = getInitialSolution(data);
    end 
end

% Generate initial solution
function s = getInitialSolution(data)
    % Generate a random binary array of length equal to N = 5
    %x = randi([0,1], 1, data.N);    
    %s = struct('solution', x);
    s = randi([0,1], 1, data.N);    
end


% Evaluation function 
% The objective is to maximize the continuous
% function f(x) = x^3 − 60 * x^2 + 900 * x + 100. 
% A solution x is represented as a string of 5 bits.
function c = evalFunction(x, data)
    % Convert x from binary to decimal
    d = binToDec(x);
    % Evaluate
    c = d^3 - 60 * d^2 + 900 * d + 100;
end
                    