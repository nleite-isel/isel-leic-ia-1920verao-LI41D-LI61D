function plots

    %/////////////////////////////////////////////////////
    %
    % Plot objective function
    %
    x = -20:20;
    y = x.^3 - 60 * x.^2 + 900 * x + 100;
    figure(1);
    plot(x, y);
    %/////////////////////////////////////////////////////
    
    %/////////////////////////////////////////////////////
    %
    % Plot cooling rate (exponential) function
    %
    %tmax = 1e3;
    tmax = 1e5;
    % Rate increment variable
    t = 0 : tmax;
    %
    % SA parameters
    %    
    % Temperature bounds
    %Tmax = 0.05;
    Tmax = 0.5;
    % Rate
    %R =    0.001;
    R =    0.0001;
    %R =    0.00001;
    
    y = Temp(t, Tmax, R);
   
    figure(2);
    plot(t, y);
    %/////////////////////////////////////////////////////

end


% Temperature actualization
function newtemp = Temp(t, Tmax, R)
    newtemp = Tmax * exp(-R * t);
end





















