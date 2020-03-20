function [Ietiq, num_etiquetas] = funcion_etiquetar(Ib)
% DECLARACION DE VARIABLES
Ib = padarray(Ib, [1 1]); %Matriz ampliada con ceros a los bordes
Ietiq = zeros(size(Ib)); %Solucion
[nLineas, nPixeles] = size(Ib);
contador = 1; %Siguiente etiqueta a usar


%inicialización de cada píxel de valor 1
%a una única etiqueta
for L=1:nLineas
    for P=1:nPixeles
        if Ib(L,P)==1
            Ietiq(L,P) = contador;
            contador = contador + 1;
        end
    end
end

% Paso arriba-abajo
cambio = true; %Verdadero si hay cambio de etiqueta
while(cambio==true)
    cambio=false;
    for L=1:nLineas
        for P=1:nPixeles
            if Ietiq(L,P) ~= 0 
                % Asignar minimo de los vecinos 4
                M = min([Ietiq(L,P) funcion_vecinos4(Ietiq, L, P)]);
                if M ~= Ietiq(L,P)
                    cambio = true;
                    Ietiq(L,P) = M;
                end
            end
        end
    end
% Paso abajo-arriba  
    for L=nLineas:1
        for P=nPixeles:1
            if Ietiq(L,P) ~= 0 
                % Asignar minimo de los vecinos 4
               M = min([Ietiq(L,P) funcion_vecinos4(Ietiq, L, P)]);
                if M ~= Ietiq(L,P)
                    cambio = true;
                    Ietiq(L,P) = M;
                end
            end
        end
    end
          
end
 
% ASIGNACION DE ETIQUETAS FINALES UNICAS POR CADA X

etiquetas = unique(Ietiq); %Valores de las etiquetas
etiquetas = etiquetas(2:end); %Quitar la etiqueta 0

for fila=1:size(Ietiq,1)
    for col=1:size(Ietiq,2)
        if Ietiq(fila,col) ~= 0 %Si tiene alguna etiqueta
             Ietiq(fila,col) = find(etiquetas == Ietiq(fila,col)); %Se cambia por el indice 
        end
    end
end

num_etiquetas = length(etiquetas); %Devolver numero de etiquetas distinas

end

