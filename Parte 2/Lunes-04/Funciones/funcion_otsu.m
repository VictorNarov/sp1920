function T_otsu = funcion_otsu(I)

h = imhist(uint8(I));

% Consideramos en toda la programacion niveles de gris de 1 a 256 despues
% al resultado le restamos una unidad

gIni = 1; gFin = 256;
[gmedio, numPix] = calcula_valor_medio_region_histograma(h,gIni,gFin);

var = zeros(256,1); % Para almacenar la varianza entre clases

for g=2:255 % los extremos de g = 0 y g = 255, no son posibles umbrales
    T = g;
    var(g) = calcula_varianza_entre_clases(T,h,numPix,gmedio);
end

[~, indice] = max(var);

T_otsu = indice - 1;

end

function var = calcula_varianza_entre_clases(T,h,numPix,gmedio) 
    
    N1 = 0;
    for g=1:T
        N1 = N1 + h(g);
    end
    
    N2 = 0;
    for g=T+1:256
        N2 = N2 + h(g);
    end
    
    w1 = N1/numPix;
    w2 = N2/numPix;
    
    g1medio = calcula_valor_medio_region_histograma(h,1,T);
    g2medio = calcula_valor_medio_region_histograma(h,T+1,256);
    
    var1 = w1*((g1medio-gmedio)^2);
    if isempty(var1)
        var1 = 0;
    end
    var2 = w2*((g2medio-gmedio)^2);
    if isempty(var2)
        var2 = 0;
    end
    var = var1 + var2;
end

function [gMean, numPix] = calcula_valor_medio_region_histograma(h,gIni,gFin)

% Comprobar los valores inicial y final
gIni = round(gIni);
if gIni<1
    gIni = 1;
end

gFin = round(gFin);
if gFin > 256
    gFin = 256;
end

% Suma los niveles de grises
gMean = 0;
for g = gIni:gFin
    gMean = gMean + g*h(g);
end

% Se suman la cantidad de pizeles de las dos zonas
numPix = sum(h(gIni:gFin));

% Y se devuelve los niveles de grises entre el numero de pizeles o vacio
if numPix > 0
    gMean = gMean/numPix;
else
    gMean = [];
end

end