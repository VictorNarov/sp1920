function vecinos = funcion_vecinos8(I, f, c)
vecinos = [];
for i=f-1:f+1
    for j=c-1:c+1
        if I(i,j) ~= 0 && (i~=f || j~=c) %No incluye elemento central
            vecinos = [vecinos I(i,j)];
        end
    end
end
end

