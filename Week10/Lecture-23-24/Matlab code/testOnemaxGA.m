function testOnemaxGA()
    %
    % OneMax simple GA (string size = n)
    % 

    clc; % Clear screen
   
    % Maximization problem
    sense = 'maximize';
    
    % String size = N
    N = 200;
    % Optimum = 200 = sum(max number of ones)
    optimum = N;
    % Create struct data that will contain problem data
    data = struct('N', N, 'optimum', optimum);

    % Max number of iterations (generations)
    tmax      = [200];
    % Population size
    popSize   = [100];
    % Cross and mutation probability
    crossProb = [0.7];
    mutProb   = [0.1]; % change

    % Run Tests
    NumbOfTests = length(tmax);  
    for f = 1 : NumbOfTests 
        fprintf('\ntmax=%d', tmax(f));
        fprintf('\npopSize=%d', popSize(f));
        fprintf('\ncrossProb=%.1f', crossProb(f));
        fprintf('\nmutProb=%.1f\n', mutProb(f));
        
        fprintf('\nNumEvaluations\t\tCost\n');
        fprintf('============================\n');
        % GA algorithm
        Results = GA(data, tmax(f), popSize(f), crossProb(f), ...
             mutProb(f), @select, @cross, @mutate, ...
             @getInitialSolution, ...
             @evalFunction, @isOptimum, sense);
        
        
        Res = [[Results.NumEvaluations]; [Results.Cost]];
        fprintf('%d\t\t%d\n', Res);
    end
end



%////////////////////////////////////////////////////////////

% Selection
function newPop = select(pop, f)
    popSize = size(pop,1);
    % Generate vector of size popSize containing random numbers [1,popSize]
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
    % Generate vector of size popSize containing random numbers [1,N]
    crossIdxs = randi([1,N], popSize, 1);
    newPop = pop;
    probs = rand(popSize/2, 1);
    k = 0;
    for j = 1:2:popSize,
        k = k+1;
        if  probs(k) < crossProb
            % Right part of first parent
            aux = newPop(j, crossIdxs(j):N); 
            % First offspring: Replace right part with right part
            % of second parent
            newPop(j, crossIdxs(j):N) = newPop(j+1, crossIdxs(j):N); 
            % Second offspring: Replace right part with right part
            % of first parent
            newPop(j+1, crossIdxs(j):N) = aux;
        end
    end
 end


% Mutation
function newPop = mutate(data, pop, mutProb)
    % N
    N = data.N;
    % one-bit mutation
    % Generate vector of size popSize containing random numbers [1,N]
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
    % Generate a random binary array of length equal to N
    s = randi([0,1], 1, data.N);    
end


% Evaluation function 
% The objective is to maximize the number of ones in a string
% A solution x is represented as a string of N bits.
function f = evalFunction(x, data)
    % Sum of ones in string x
    f = sum(x); 
end
                    






























