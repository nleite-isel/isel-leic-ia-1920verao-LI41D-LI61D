function hopfield

    Samples = training_samples();
    
    Samples_with_noise = training_samples_with_noise(Samples);
    
    % 9.2 Hopfield Networks - p. 250
    %
    % In the learning phase of a Hopfield network, N binary coded patterns,
    % saved in the vectors q^1, ..., q^N , are supposed to be learned. 
    % Each component q_i^j in {-1, 1} of such a vector q^j represents a 
    % pixel of a pattern. For vectors consisting of n pixels, a neural
    % network with n neurons is used, one for each pixel position. 
    % The neurons are fully connected with the restriction that the weight
    % matrix is symmetric and all diagonal elements w_{ij} are zero. 
    % That is, there is no connection between a neuron and itself.
    %
    % N patterns can be learned by simply calculating all weights with 
    % the formula:
    %     w_{ij} = 1/N * sum^{k=1}_{N} ( q_i^k * q_j^k )
    %
    % Once all the patterns have been stored, the network can be used for 
    % pattern recognition. We give the network a new pattern x and update 
    % the activations of all neurons in an asynchronous process according 
    % to the rule:
    %   x_i = -1, if sum^{n}_{j = 1} w_{ij} * x_j < 0,
    %   x_i = 1, else
    % until the network becomes stable, that is, until no more activations 
    % change. As a program schema this reads as follows:
    % ----------------------------------
    % HOPFIELD_ASSOCIATOR(q)
    % Initialize all neurons: x = q
    % Repeat
    %   i = Random(1, n)
    %   Update neuron i according to (9.2) (p. 251)
    % Until x converges
    % Return (x)
    % ----------------------------------
    
    % First the patterns of the digits 1, 2, 3, 4 in Fig. 9.6 above on 
    % page 252 are trained. That is, the weights are calculated by (9.1) 
    % on page 250. Then we put in the pattern with added noise and let 
    % the Hopfield dynamics run until convergence.
    
    %  # patterns
    N = 4;
    % # Neurons
    Num_Neurons = 10 * 10;
    % Weights matrix
    Weight = zeros(Num_Neurons, Num_Neurons);
    %/////////////////////////////////////////////////////
    %
    % Train
    %
    for i = 1 : N
        Source_Img = BinarioToNeural(Samples(:, :, i))
        Weight = NewPattern(Source_Img, 10, 10, Weight);
        %pause
    end
    Weight;
    %/////////////////////////////////////////////////////
    
    MaxIteration = 400;
    
    NoiseImage = Samples_with_noise(:, :, 1);
    
    Result = BinarioToNeural(NoiseImage);
    
    output = Run(Result, MaxIteration, Weight)
    Final_Img = NeuralToBinario(output);
    
    figure
    imshow(~Final_Img, []);
    
    
end




































