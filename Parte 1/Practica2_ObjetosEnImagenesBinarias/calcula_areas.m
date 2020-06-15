function Areas = calcula_areas(Matriz_Etiquetada)

num_objetos = length(unique(Matriz_Etiquetada))-1; %Descartamos el 0 (fondo)

Areas = [];

for i=1:num_objetos
    
    suma = sum(sum(Matriz_Etiquetada==i));
    
    Areas = [Areas suma];

end


end