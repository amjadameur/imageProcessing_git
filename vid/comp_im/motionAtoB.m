function [Vx, Vy] = motionAtoB(A, B, t, s)

[h, w]=size(A); %taille de A
wV =w/t(1); %division de l'image en carrés de taille 8
hV = h/t(2); %division de l'image en carrés de taille 8
Vx = zeros(hV, wV); %tableau des min (SAD) taille 30*44
Vy = Vx;
dtx = (1 : t(1));
dty = (1 : t(2));

for i = 1:wV
    for j = 1:hV
        flag = 1; %initialisation valeur du min
        for u =-(s(1)-1)/2 : (s(1)-1)/2 %u varie entre -7 et 7
           for v =-(s(2)-1)/2 : (s(2)-1)/2
               if(i-1)*t(1) + 1 + u >= 1 && (i-1)*t(1) + t(1) + u <= w && (j-1)*t(2) + 1 + v >= 1 && (j-1)*t(2) + t(2) + v <= h %pour eviter les effets de bords
                   c = sum(sum(abs(A((j-1)*t(2) + dty, (i-1)*t(1) + dtx) - B((j-1)*t(2) + dty + v, (i-1)*t(1) + dtx + u)))); %SAD
                   if flag==1 || c<cMin
                       flag=0;
                       cMin=c;
                       uMin=u;
                       vMin=v;
                   end
               end
           end
        end
        Vx(j,i) = uMin;
        Vy(j,i) = vMin;
    end
end
end
