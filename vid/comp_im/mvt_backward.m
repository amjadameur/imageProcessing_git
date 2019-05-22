function  [Vx, Vy] = mvt_backward(I1, I2)


tab = zeros(size(I1)/8);

for(l=1:size(I1,1):8)
    for(h=1:size(I1,2):8)
    
        for(i=l:size(I1,1)/8)
        
            for(j= h:size(I1,2)/8)

                for(u=1:15)
                    for(v=1:15)
                        tab(u,v) = I2(i,j) - I1(i+u,j+v);
                        
                    end
                end
                m = min(tab);
               [Vx, Vy] = ind2sub(size(tab), m);
            end
            
        end
       
    end
end

end


                