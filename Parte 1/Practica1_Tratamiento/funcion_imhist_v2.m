
% Devuelve vector de 256 posiciones con el numero de courrencias de cada
% nivel de gris al que hace referencia el índice
function h = funcion_imhist_v2(I)

h = double(zeros(256,1));

for gris=0:255
    h(gris+1) = sum(sum(I==gris));
    
end


end