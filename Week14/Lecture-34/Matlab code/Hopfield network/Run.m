function output = Run(Result, MaxIteration, Weight)
    Iteration = 0;
    energy1 =  Energy(Result, Weight);
    while (Iteration < MaxIteration)
        Iteration = Iteration + 1;
        for i= 1 : length(Result(:))
            h = 0;
            for j = 1 : length(Result(:))
                h = h + (Weight(i, j) * Result(j));
            end
            if (h * Result(i) < 0 )
                Result(i) = -Result(i);
            % Else, neuron is not changed
            %else
            %    Result(i) = Result(i);
            end
%            Result(i)
%            pause
        end
    end
    
    Iteration=0;
    energy2 =  Energy(Result, Weight);
    
    fprintf('Energy: Start %s\n', int2str(energy1));
    fprintf('Energy: End %s', int2str(energy2));      
    output = Result;
end