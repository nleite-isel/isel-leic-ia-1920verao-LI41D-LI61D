function neuralNetPerceptron()
%neuralNetPerceptron Simple neural network - Perceptron
%   

close all;
clc;

% load IRIS dataset
[SepalLength, SepalWidth, PetalLength, PetalWidth, Irissetosa1] = importIrisDataset;


% Sepal width
SepalWidth

% Petal length
PetalLength

% Iris class
Irissetosa1

% Num samples
numSamples = size(Irissetosa1, 1)

Data = [SepalWidth, PetalLength]

% Try exchange data and see that the perceptron still learns
%Data = [PetalLength SepalWidth]

for i = 1 : numSamples
    if (strcmp(Irissetosa1{i}, 'Iris-setosa'))
        str = 'ro';
        LH(1) = plot(Data(i,1), Data(i,2), str);
        L{1} = 'Iris-setosa';
    elseif (strcmp(Irissetosa1{i}, 'Iris-versicolor'))
        str = 'go';
        LH(2) = plot(Data(i,1), Data(i,2), str);
        L{2} = 'Iris-versicolor';
    elseif (strcmp(Irissetosa1{i}, 'Iris-virginica'))
        str = 'bo';
        LH(3) = plot(Data(i,1), Data(i,2), str);
        L{3} = 'Iris-virginica';
    end
    hold on;       
end

xlabel('Sepal width');
ylabel('Petal length');

legend(LH, L);


w = perceptron_Iris(Data, numSamples, Irissetosa1)

% Try this
%w = [1 1 0];

%w1 * x + w2 * y = w3
%y = -w1/w2 * x + w3/w2 

% Plot
b0 = w(3)/w(2); m = w(1)/w(2);
xmin = 1.8;
xmax = 5;
x = xmin:xmax;

% Try this
%x = -1.5:1.5;

y = b0 - m*x;
plot(x, y)


hold off


end



































