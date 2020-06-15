function brillo = funcion_calcular_brillo(Imagen)
    if(size(Imagen,3) == 1)
        histograma = imhist(Imagen);
        p = histograma/sum(histograma); % normalizamos el histograma
        brillo = 0; % Establezo el valor inicial del brillo
        for g=0:255 % Recorrido desde 0 (color negro) hasta 255 (color blanco)
            ind = g+1; % indice del histograma normalizado
            brillo = brillo + g*p(ind); % formula
        end
    else
        if(size(Imagen,3) == 3)
            Imagen = rgb2gray(Imagen);
            histograma = imhist(Imagen);
            p = histograma/sum(histograma); % normalizamos el histograma
            brillo = 0; % Establezo el valor inicial del brillo
            for g=0:255 % Recorrido desde 0 (color negro) hasta 255 (color blanco)
                ind = g+1; % indice del histograma normalizado
                brillo = brillo + g*p(ind); % formula
            end
        else
             disp("Imagen tiene que ser o una imagen de intensidad o de color");
        end    
    end
end