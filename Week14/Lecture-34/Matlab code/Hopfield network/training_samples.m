function Samples = training_samples

    clc;
    close all;

    sample_one = zeros(10, 10);
    for i = 1 : 10
        sample_one(i, 5) = 1;
        sample_one(i, 6) = 1;
    end
    sample_one
    figure(1)
    imshow(~sample_one, []);
    
        
    %///////////////////////////////////////////
    sample_two = zeros(10, 10);
    for j = 1 : 10
        sample_two(1, j) = 1;
        sample_two(6, j) = 1;
        sample_two(10, j) = 1;
    end
    for i = 1 : 5
        sample_two(i, 9) = 1;
        sample_two(i, 10) = 1;
    end
    for i = 7 : 9
        sample_two(i, 1) = 1;
        sample_two(i, 2) = 1;
    end
    
    sample_two
    figure(2)
    imshow(~sample_two, []);
    
    %///////////////////////////////////////////
    sample_three = zeros(10, 10);
    for j = 1 : 10
        sample_three(1, j) = 1;
        sample_three(10, j) = 1;
    end
    % Middle part
    for j = 3 : 10
        sample_three(5, j) = 1;
        sample_three(6, j) = 1;
    end
    % Right columns
    for i = 1 : 9
        sample_three(i, 9) = 1;
        sample_three(i, 10) = 1;
    end
        
    sample_three
    figure(3)
    imshow(~sample_three, []);        
    
    %///////////////////////////////////////////
    sample_four = zeros(10, 10);
    % Middle row
    for j = 1 : 10
        sample_four(6, j) = 1;
    end
    % Left columns
    for i = 1 : 5
        sample_four(i, 1) = 1;
        sample_four(i, 2) = 1;
    end
    % Middle columns
    for i = 1 : 10
        sample_four(i, 6) = 1;
        sample_four(i, 7) = 1;
    end
        
    sample_four
    figure(4)
    imshow(~sample_four, []);
    %///////////////////////////////////////////
        
    Samples = zeros(10, 10, 4);
    Samples(:, :, 1) = sample_one;
    Samples(:, :, 2) = sample_two;
    Samples(:, :, 3) = sample_three;
    Samples(:, :, 4) = sample_four;
end







































