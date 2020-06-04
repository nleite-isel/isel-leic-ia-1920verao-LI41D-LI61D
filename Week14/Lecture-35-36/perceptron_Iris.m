function w = perceptron_Iris(Data, numSamples, Irissetosa1)
%perceptron Implements a perceptron that classifies the Iris dataset
%   
% Definition 8.3 Let w = (w1, ..., wn ) in R^{n} n be a weight vector 
% and x in R^{n} an input vector. 
% A perceptron represents a function P: R^{n} -> {0, 1} which cor-
% responds to the following rule:
%
% P(x) = 1, if w * x = sum^{n}_{i = 1} w_i * x_i > 0;
% P(x) = 0, otherwise
%
% In 2D space we have Fig. 8.8.
%
% Learning algorithm - SEE Section 8.2.1 The Learning Rule
% PERCEPTRON LEARNING [M+, M−]
% w = arbitrary vector of real numbers
% Repeat
%   For all x ∈ M+
%     If w x ≤ 0 Then w = w + x
%   For all x ∈ M−
%     If w x > 0 Then w = w − x
% Until all x ∈ M+ ∪ M− are correctly classified
%

% Clear output
clc;

% Weights to be learned by the perceptron:
w = rand(1, 3)


%Irissetosa1
M_PlusIndices = find(contains(Irissetosa1, 'Iris-setosa'));
M_MinusIndices = find(contains(Irissetosa1, 'Iris-versicolor'));


% [x1 x2 theta], where theta is the bias of the hyperplane
M_Plus = [Data(M_PlusIndices, :) ones(length(M_PlusIndices), 1)]
M_Minus = [Data(M_MinusIndices, :) ones(length(M_MinusIndices), 1)]

% Get count of M_Plus
count_M_Plus = size(M_Plus, 1)
% Get count of M_Minus
count_M_Minus = size(M_Minus, 1)

while true
    % Adjust weigths when learning positive samples
    for i = 1 : count_M_Plus
    % Try this
    %for i = 1 : 1
        x = M_Plus(i, :)
        if w * x' <= 0
            w = w + x
        end
    end
    % Adjust weigths when learning negative samples
    for i = 1 : count_M_Minus
    % Try this
    %for i = 10 : 10
        x = M_Minus(i, :)
        if w * x' > 0
            w = w - x
        end
    end
    if all_correctly_classified(w, M_Plus, M_Minus)
        break;
    end
    
%    pause;
    
end


% Test
for i = 1 : count_M_Plus
    x = M_Plus(i, :)
    fprintf('is classified as %i', classify(w * x'));
end

for i = 1 : count_M_Minus
    x = M_Minus(i, :)
    fprintf('is classified as %i', classify(w * x'));
end
































