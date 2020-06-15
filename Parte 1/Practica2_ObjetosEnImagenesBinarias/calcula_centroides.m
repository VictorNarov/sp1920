% Centroide o centro de gravedad: se determina promediando las coordenadas x e y
% de los píxeles que conforman el contorno.
function Centroides = calcula_centroides(Matriz_Etiquetada)

num_objetos = length(unique(Matriz_Etiquetada))-1; %Descartamos el 0 (fondo)

Centroides =  zeros(num_objetos,2);

Areas = calcula_areas(Matriz_Etiquetada);


for obj=1:num_objetos
    xmedio = 0;
    ymedio = 0;
    %disp("Buscando el obj: "+obj)
    for x=1:size(Matriz_Etiquetada,1)       
        for y=1:size(Matriz_Etiquetada,2)
           % disp("Visitando: "+ Matriz_Etiquetada(x,y));
            
            if(Matriz_Etiquetada(x,y) == obj)
                %disp("Encontrado!");
                xmedio = xmedio + x;
                ymedio = ymedio + y;
            end
        
        end
    end
    xmedio = xmedio / Areas(obj);
    ymedio = ymedio / Areas(obj);
    
    Centroides(obj,1) = xmedio;
    Centroides(obj,2) = ymedio;
    
end


end