function [g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMaximos(I,vectorPesos)

h = imhist(uint8(I));

if not(isempty(vectorPesos))
    h = funcion_suaviza_vector_medias_moviles(h,vectorPesos);
end

% Consideramos en toda la programacion niveles de gris de 1 a 256, depues
% al resultado le restamos una unidad

% Valor maximo

[numPixMax, gmax] = max(h);

valores2Max = zeros(256,1);

for g=1:256
    valores2Max(g) = ((g-gmax)^2)*h(g);
end

[~,g2Max] = max(valores2Max);

if gmax < g2Max
    h(1:gmax) = numPixMax;
    h(g2Max:256) = numPixMax;
    gmax1 = gmax - 1;
    gmax2 = g2Max - 1;
else
    h(1:g2Max) = numPixMax;
    h(gmax:256) = numPixMax;
    gmax1 = g2Max - 1;
    gmax2 = gmax - 1;
end

[~, indice] = min(h);

g_MinEntreMax = indice - 1;
end