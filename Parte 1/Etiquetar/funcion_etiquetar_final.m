function [Ietiq, num_etiquetas] = funcion_etiquetar_final(Ietiq, ordenExp)
    
    % ASIGNACION DE ETIQUETAS FINALES UNICAS POR CADA X
    etiquetas = unique(Ietiq); %Valores de las etiquetas
    etiquetas = etiquetas(2:end); %Quitar la etiqueta 0

    if ordenExp == "fila"
        for fila=1:size(Ietiq,1)
            for col=1:size(Ietiq,2)
                if Ietiq(fila,col) ~= 0 %Si tiene alguna etiqueta
                     Ietiq(fila,col) = find(etiquetas == Ietiq(fila,col)); %Se cambia por el indice 
                end
            end
        end
    elseif ordenExp == "columna"
        for col=1:size(Ietiq,2)
            for fila=1:size(Ietiq,1)
                if Ietiq(fila,col) ~= 0 %Si tiene alguna etiqueta
                     Ietiq(fila,col) = find(etiquetas == Ietiq(fila,col)); %Se cambia por el indice 
                end
            end
        end 
    else
        disp("Valor de orden de exploracion no valido!. Valores aceptados: 'fila' , 'columna'");
    end
    num_etiquetas = length(etiquetas); %Devolver numero de etiquetas distinas
end