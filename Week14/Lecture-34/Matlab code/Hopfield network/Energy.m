function energy =  Energy(Pattern, Weight)
    temp = 0;
    for i = 1 : length(Pattern(:))
        for j = 1 : length(Pattern(:))
            if (i ~= j)
                temp = temp + Weight(i, j) * Pattern(i) * Pattern(j);
                energy = -0.5 * temp;
            end
        end
    end 
end