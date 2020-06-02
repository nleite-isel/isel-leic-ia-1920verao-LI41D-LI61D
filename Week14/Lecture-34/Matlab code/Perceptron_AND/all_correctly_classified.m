function result = all_correctly_classified(w, M_Plus, M_Minus)
    % Assume result is true initially
    result = true;
    % Get count of M_Plus
    count_M_Plus = size(M_Plus, 1);
    % Adjust weigths when learning positive samples
    for i = 1 : count_M_Plus
        x = M_Plus(i, :)
        if w * x' <= 0
            result = false;
            break;
        end
    end
    % Get count of M_Mius
    count_M_Minus = size(M_Minus, 1);
    % Adjust weigths when learning negative samples
    for i = 1 : count_M_Minus
        x = M_Minus(i, :)
        if w * x' > 0
            result = false;
            break;
        end
    end
end