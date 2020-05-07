function test_GA_Example()
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
    
    % N - Number of bits of bitstring used to represent variable x
    N = 5;
    % Optimum value for the example problem
    optimum = 4100;
    % Create struct data that will contain problem data
    data = struct('N', N, 'optimum', optimum);

    % Max number of iterations
    tmax      = [100];
    % Population size
    popSize   = [10];
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
        Results = GA_Example(tmax(f), popSize(f), crossProb(f), ...
            mutProb(f), data);

        Res = [[Results.NumEvaluations]; [Results.Cost]];
        fprintf('%d\t\t%d\n', Res);
    end
end




















