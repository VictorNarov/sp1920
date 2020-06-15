function funcion_representa_muestras_clasificacion_binaria(X,Y)
    
    valoresClases = unique(Y);
    numClases = length(valoresClases);
    [numDatos, numAtributos] = size(X);
    
    %% Representacion de los datos
    
    nombreCcas{1} = 'Caracteristica columna 1 - x1';
    nombreCcas{2} = 'Caracteristica columna 2 - x2';
    nombreCcas{3} = 'Caracteristica columna 3 - x3';
    
    simbolos{1} = '*r';
    simbolos{2} = '*b';
    simbolos{3} = '*y';
    
    leyenda{1} = 'Objetos Clase 1';
    leyenda{2} = 'Objetos Clase 2';
    
    figure, hold on
    
    if numAtributos == 2
        
        for i=1:numClases
            FoI = Y == valoresClases(i);
            x1 = X(FoI,1);
            x2 = X(FoI,2);
            plot(x1,x2,simbolos{i});
        end
        
        legend(leyenda{1},leyenda{2})
        xlabel(nombreCcas{1}), ylabel(nombreCcas{2})
        axis([min(X(:,1))-2 , max(X(:,1))+2, min(X(:,2))-2, max(X(:,2))+2]);
        grid on
     
    else
        for i=1:numClases
            FoI = Y == valoresClases(i);
            x1 = X(FoI,1);
            x2 = X(FoI,2);
            x3 = X(FoI,3);
            plot3(x1,x2,x3,simbolos{i});
            axis([min(X(:,1))-2 , max(X(:,1))+2, min(X(:,2))-2, max(X(:,2))+2,min(X(:,3))-2 , max(X(:,3))+2]);
        end
        
        legend(leyenda{1},leyenda{2})
        xlabel(nombreCcas{1}), ylabel(nombreCcas{2}), zlabel(nombreCcas{3})
        grid on
    end
    
    hold off
end