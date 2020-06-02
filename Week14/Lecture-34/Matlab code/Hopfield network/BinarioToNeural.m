function Neural_Image = BinarioToNeural(temp_image)

     for i=1 :  size(temp_image,1);
        for j = 1 : size(temp_image,2);
           if(temp_image(i,j)==0)
                Neural_Image(i,j) = -1;
           end
           if(temp_image(i,j)==1)
                Neural_Image(i,j) = 1;
           end
        end
     end
end