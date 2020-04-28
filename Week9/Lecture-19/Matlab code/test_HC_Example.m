function test_HC_Example()
    %
    % Illustration of the HC algorithm. Let us maximize the continuous
    % function f(x) = x^3 − 60 * x^2 + 900 * x + 100. 
    % A solution x is represented as a string of 5 bits. 
    % The neighborhood consists in flipping randomly a bit. 
    % The global maximum of this function is 01010 (x = 10, f(x) = 4100).
    % 

    clc; % Clear screen
   
    % Maximization problem
    sense = 'maximize';
    
    % Max. number of iterations
    %tmax = 50;
    tmax = 10;
    
    % HC algorithm
    Res = HC(tmax, ...
        @getInitialSolution, @getNeighbors, ...
        @costFunction, @evalFunction, @isOptimum, sense);

    Results = [[Res(:).tmax]; [Res(:).NumEvaluations]; [Res(:).Cost]]
    %fprintf('%d\t\t%d\t\t%d\n', Results);
    
    
end

%////////////////////////////////////////////////////////////

% isOptimum
% The global maximum of this function is 01010 (x = 10, f(x) = 4100).
% The parameter fu is the target function (function to be maximized) 
% value 
function res = isOptimum(fu)
    if fu == 4100
        res = true;
    else
        res = false;
    end
end


% Generate initial solution
function s = getInitialSolution()
    % Generate a random binary array of length equal to 5
    x = randi([0,1], 1, 5);    
    s = struct('solution', x);
end

% Generate neighbors
% The global maximum of this function is 01010 (x = 10, f(x) = 4100).
function Neighs = getNeighbors(S)
    % N variables => N neighbors, single bit change
    N = 5;
    Neighs = cell(N, 1);
    for i = 1 : N
        Neighs{i} = S;
        Neighs{i}.solution(i) = ~Neighs{i}.solution(i); % Change it
    end
end

function Costs = costFunction(Neighs)
    N = length(Neighs);
    Costs = zeros(1, N);
    for i = 1 : N
        x = Neighs{i}.solution;
        Costs(i) = evalFunction(x);
    end
end

% Evaluation function 
% The objective is to maximize the continuous
% function f(x) = x^3 − 60 * x^2 + 900 * x + 100. 
% A solution x is represented as a string of 5 bits.
function c = evalFunction(x)
    % Convert x from binary to decimal
    d = binToDec(x);
    % Evaluate
    c = d^3 - 60 * d^2 + 900 * d + 100;
end






















    