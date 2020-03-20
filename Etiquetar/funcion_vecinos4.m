function vecinos = funcion_vecinos4(I, f, c)
vecinos = [];
if I(f-1,c) ~= 0
    vecinos = [vecinos I(f-1,c)];
end

if I(f+1,c) ~= 0
    vecinos = [vecinos I(f+1,c)];
end

if I(f,c-1) ~= 0
    vecinos = [vecinos I(f,c-1)];
end


if I(f,c+1) ~= 0
    vecinos = [vecinos I(f,c+1)];
end

 
end
