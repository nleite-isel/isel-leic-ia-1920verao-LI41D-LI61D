function Learn_Image(Image_vector, Weight)
    for i = 1 : size(Image_vector,2)
        for j = 1 : size(Image_vector,2)
            if(i~=j)
                Weight(i,j)=Weight(i,j)+(Image_vector(i)*Image_vector(j));
            else
                Weight(i,j)=0;
            end
        end
    end
end