function [Ietiq, num_etiquetas] = funcion_etiquetar_v2(Ib, tipoV, ordenExploracion)
% DECLARACION DE VARIABLES
Ib = padarray(Ib, [1 1]); %Matriz ampliada con ceros a los bordes
Ietiq = zeros(size(Ib)); %Solucion
[nLineas, nPixeles] = size(Ib);
contador = 1; %Siguiente etiqueta a usar


% ------------------------------------
% ORDEN DE EXPLORACION POR FILAS
% ------------------------------------
if ordenExploracion == "fila"
    %Inicialización de cada píxel de valor 1
    % a una única etiqueta
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
    while(cambio==true) % Repetir hasta que cambio sea false
        cambio=false; % Suponemos que no hay cambios
        for L=1:nLineas
            for P=1:nPixeles
                if Ietiq(L,P) ~= 0 
                    % Asignar minimo de los vecinos
                    if tipoV == 4 % TIPO DE VECINDAD 4
                        M = min([Ietiq(L,P) funcion_vecinos4(Ietiq, L, P)]);
                    elseif tipoV == 8 % TIPO DE VECINDAD 8
                        M = min([Ietiq(L,P) funcion_vecinos8(Ietiq, L, P)]);
                    else
                        disp("Error: tipo de vecindad no válido. Valores aceptados: 8, 4.");
                    end
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
                    % Asignar minimo de los vecinos
                   if tipoV == 4 % TIPO DE VECINDAD 4
                            M = min([Ietiq(L,P) funcion_vecinos4(Ietiq, L, P)]);
                    elseif tipoV == 8 % TIPO DE VECINDAD 4
                        M = min([Ietiq(L,P) funcion_vecinos8(Ietiq, L, P)]);
                    else
                        disp("Error: tipo de vecindad no válido. Valores aceptados: 8, 4.");
                    end
                    if M ~= Ietiq(L,P)
                        cambio = true;
                        Ietiq(L,P) = M;
                    end
                end
            end
        end
        
        % APLICAR ETIQUETAS FINALES
        [Ietiq, num_etiquetas] = funcion_etiquetar_final(Ietiq, "fila");
    end
    
% ------------------------------------
% ORDEN DE EXPLORACION POR COLUMNAS 
% ------------------------------------
elseif ordenExploracion == "columna" 
        %Inicialización de cada píxel de valor 1
        % a una única etiqueta
        for P=1:nPixeles
            for L=1:nLineas
                if Ib(L,P)==1
                    Ietiq(L,P) = contador;
                    contador = contador + 1;
                end
            end
        end
        cambio = true; %Verdadero si hay cambio de etiqueta
        while(cambio==true) % Repetir hasta que cambio sea false
            cambio=false; % Suponemos que no hay cambios
            for P=1:nPixeles    
                for L=1:nLineas
                    if Ietiq(L,P) ~= 0 
                        % Asignar minimo de los vecinos
                        if tipoV == 4
                            M = min([Ietiq(L,P) funcion_vecinos4(Ietiq, L, P)]);
                        elseif tipoV == 8
                            M = min([Ietiq(L,P) funcion_vecinos8(Ietiq, L, P)]);
                        else
                            disp("Error: tipo de vecindad no válido. Valores aceptados: 8, 4.");
                        end
                        if M ~= Ietiq(L,P)
                            cambio = true;
                            Ietiq(L,P) = M;
                        end
                    end
                end
            end
            % Paso abajo-arriba  
            for P=nPixeles:1
                for L=nLineas:1
                    if Ietiq(L,P) ~= 0 
                        % Asignar minimo de los vecinos
                       if tipoV == 4
                                M = min([Ietiq(L,P) funcion_vecinos4(Ietiq, L, P)]);
                        elseif tipoV == 8
                            M = min([Ietiq(L,P) funcion_vecinos8(Ietiq, L, P)]);
                        else
                            disp("Error: tipo de vecindad no válido. Valores aceptados: 8, 4.");
                        end
                        if M ~= Ietiq(L,P)
                            cambio = true;
                            Ietiq(L,P) = M;
                        end
                    end
                end
            end
        end % while
        
    % APLICAR ETIQUETAS FINALES
    [Ietiq, num_etiquetas]= funcion_etiquetar_final(Ietiq, "columna");
           
else % CASO ERROR EN LOS PARAMETROS
    disp("Valor de orden de exploracion no valido!. Valores aceptados: 'fila' , 'columna'");
        
end %

end