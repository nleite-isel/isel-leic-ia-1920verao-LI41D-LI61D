function Samples_with_noise = training_samples_with_noise(Samples)

    clc;
    close all;

    Samples_with_noise = Samples;
    
    %
    % First sample
    %
    Samples_with_noise(2, 1, 1) = 1;
    Samples_with_noise(5, 2, 1) = 1;
    Samples_with_noise(6, 1, 1) = 1;
    Samples_with_noise(7, 3, 1) = 1;
    Samples_with_noise(7, 4, 1) = 1;
    Samples_with_noise(8, 3, 1) = 1;
    Samples_with_noise(4, 8, 1) = 1;
    Samples_with_noise(9, 10, 1) = 1;
    % white pixels
    Samples_with_noise(3, 6, 1) = 0;
    Samples_with_noise(4, 6, 1) = 0;
    Samples_with_noise(6, 5, 1) = 0;
    
    figure(1)
    imshow(~Samples_with_noise(:, :, 1), []);

    %///////////////////////////////////////////
    %
    % Second sample
    %
    Samples_with_noise(3, 7, 2) = 1;
    Samples_with_noise(7, 3, 2) = 1;
    Samples_with_noise(7, 6, 2) = 1;
    Samples_with_noise(8, 3, 2) = 1;
    Samples_with_noise(8, 5, 2) = 1;
    % white pixels
    Samples_with_noise(1, 5, 2) = 0;
    Samples_with_noise(3, 10, 2) = 0;
    Samples_with_noise(6, 9, 2) = 0;
    Samples_with_noise(10, 2, 2) = 0;
    
    figure(2)
    imshow(~Samples_with_noise(:, :, 2), []);
    
    %///////////////////////////////////////////
    %
    % Third sample
    %
    Samples_with_noise(2, 3, 3) = 1;
    Samples_with_noise(4, 7, 3) = 1;
    Samples_with_noise(7, 1, 3) = 1;
    Samples_with_noise(7, 5, 3) = 1;
    Samples_with_noise(9, 3, 3) = 1;
    % white pixels
    Samples_with_noise(5, 3, 3) = 0;
    Samples_with_noise(5, 8, 3) = 0;
    Samples_with_noise(9, 10, 3) = 0;
    Samples_with_noise(10, 2, 3) = 0;
    Samples_with_noise(10, 6, 3) = 0;
    
    figure(3)
    imshow(~Samples_with_noise(:, :, 3), []);
    
    
    %///////////////////////////////////////////


end







































