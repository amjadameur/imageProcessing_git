function Ic = motionCompensate (I, Vx, Vy)
    [h, w] = size(I);
    [hV, wV] = size(Vx);
    tx = w/wV;
    ty = h/hV;
    Ic =I;
    for i = 1:wV
        for j = 1:hV
            Ic((j-1)*ty+(1:ty), (i-1)*tx+(1:tx))=I((j-1)*ty+(1:ty)+Vy(j,i), (i-1)*tx+(1:tx)+Vx(j,i));
        end 
    end 


end