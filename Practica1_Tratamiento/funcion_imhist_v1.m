
% Devuelve vector de 256 posiciones con el numero de courrencias de cada
% nivel de gris al que hace referencia el índice
function h = funcion_imhist_v1(I)

h = double(zeros(256,1));

for i=1:size(I,1)
    for j=1:size(I,2)
        index = double(I(i,j));
        h(index+1) = h(index+1)+1 ;
    end
end


end