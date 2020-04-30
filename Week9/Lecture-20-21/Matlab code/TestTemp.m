
function TestTemp()
    
    Tmax = 0.01;
    Tmin = 0.0001;
    t = 0;
    R = 0.001;

    T = Tmax
    
    while (T >= Tmin)
        t = t + 1;
        T = Temp(t, Tmax, R)
    end
    

end


% Temperature actualization
function newtemp = Temp(t, Tmax, R)
    newtemp = Tmax*exp(-R*t);
end
    