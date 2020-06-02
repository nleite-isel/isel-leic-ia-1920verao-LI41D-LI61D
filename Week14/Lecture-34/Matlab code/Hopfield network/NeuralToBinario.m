function Binary_Image = NeuralToBinario(temp_image)

     for i=1 :  size(temp_image,1);
        for j = 1 : size(temp_image,2);
           if(temp_image(i,j) == -1)
                Binary_Image(i,j) = 0;
           end
           if(temp_image(i,j)==1)
                Binary_Image(i,j) = 1;
           end
        end
     end
end