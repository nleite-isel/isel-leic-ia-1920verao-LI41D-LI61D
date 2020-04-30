function y = binToDec(x)
    % convert x to a string array
    str_x = num2str(x);
    % now use BIN2DEC to convert the binary 
    % string to a decimal number
    y = bin2dec(str_x);
end