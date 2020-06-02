function Weight = NewPattern(Pattern, n, m, Weight)
    
    for i = 1: n*m
        for j = 1 : n*m
            if (i == j)
                Weight(i, j) = 0;
            else
                Weight(i, j) = Weight(i, j) + (Pattern(i) * Pattern(j));
            end
        end
    end
end