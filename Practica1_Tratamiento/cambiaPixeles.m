%9.-Crear una función que reciba como entradas:
% ?Imagen I que puede ser en color o en escala de grises
% ?Matriz  Ib  binaria  de  0's  y  1's de  las  mismas  dimensiones  (filas  y  columnas)  que I
% ?Color: vector con 3 valores de 0 a 255.
% La   función   debe   visualizar   la   Imagen   I   con   los   píxeles   de   Ib   con   el   color especificado.
function cambiaPixeles(I, Ib, color)

% [f, c] = find(Ib==1);
% I(f,c,1) = color(1);
% I(f,c,2) = color(2);
% I(f,c,3) = color(3);
if(size(I,3) == 1) % imagen en grises
    I = cat(3,I,I,I); % GENERAR UNA MATRIZ X3 DIM  
end
%SEPARAR POR CANALES
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

R(Ib) = color(1);
G(Ib) = color(2);
B(Ib) = color(3);

I = cat(3,R,G,B);
figure, imshow(I);

end

