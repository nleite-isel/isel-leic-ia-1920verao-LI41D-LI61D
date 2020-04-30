function test_SA_Example()
    %
    % Illustration of the SA algorithm. Let us maximize the continuous
    % function f(x) = x^3 − 60 * x^2 + 900 * x + 100. 
    % A solution x is represented as a string of 5 bits. 
    % The neighborhood consists in flipping randomly a bit. 
    % The global maximum of this function is 01010 (x = 10, f(x) = 4100).
    % 

    clc; % Clear screen
   
    % Maximization problem
    sense = 'maximize';
    
    % N - Number of bits of bitstring used to represent variable x
    N = 5;
    % Optimum value for the example problem
    optimum = 4100;
    % Create struct data that will contain problem data
    data = struct('N', N, 'optimum', optimum);
    %
    % SA parameters
    %
    % Temperature bounds
    %Tmax = 0.05; % Worse results
    Tmax = 0.5; % Good results
    Tmin = 0.0001;
    % Rate
    %R =    0.00001;
    %R =    0.0001;
    R =    0.001; % Good results
    %R = 0.1; % Worse results
    % Max. number of iterations per temperature
    k =    5;
    
    % SA algorithm
    Results = SA(Tmax, Tmin, R, k, ...
        data, @getInitialSolution, @getRandomNeigh, ...
                @evalFunction, @isOptimum, sense);

    Res = [[Results(:).T]; [Results(:).NumEvaluations]; [Results(:).Cost]];
    fprintf('Final Temp\t\tNum Evaluations\t\tBest Cost\n');
    fprintf('%.7f\t\t%d\t\t%d\n', Res);
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


% Generate initial solution
function s = getInitialSolution(data)
    % Generate a random binary array of length equal to 5
    x = randi([0,1], 1, data.N);    
    s = struct('solution', x);
end


% Generate random neighbor
function RandomNeigh = getRandomNeigh(S, data)
    RandomNeigh = S;
    i = randi(data.N); % Choose one bit randomly
    RandomNeigh.solution(i) = ~RandomNeigh.solution(i); % Change it
end


% Evaluation function 
% The objective is to maximize the continuous
% function f(x) = x^3 − 60 * x^2 + 900 * x + 100. 
% A solution sol is represented internally as a string of 5 bits.
function c = evalFunction(sol, data)
    % Get bitstring
    x = sol.solution;
    % Convert x from binary to decimal
    d = binToDec(x);
    % Evaluate
    c = d^3 - 60 * d^2 + 900 * d + 100;
end






















    