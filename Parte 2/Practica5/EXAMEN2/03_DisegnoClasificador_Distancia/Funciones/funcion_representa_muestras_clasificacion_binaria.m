function funcion_representa_muestras_clasificacion_binaria(X,Y,nombresProblema)
    
    valoresClases = unique(Y);
    numClases = length(valoresClases);
    [~, numAtributos] = size(X);
    
    %% Representacion de los datos
    
    leyenda{1} = nombresProblema.clases{1};
    leyenda{2} = nombresProblema.clases{2};
    
    hold on
    
    if numAtributos == 2
        
        for i=1:numClases
            FoI = Y == valoresClases(i);
            x1 = X(FoI,1);
            x2 = X(FoI,2);
            plot(x1,x2,nombresProblema.simbolos{i});
        end
        
        legend(leyenda{1},leyenda{2})
        xlabel(nombresProblema.descriptores{1}), ylabel(nombresProblema.descriptores{2})
        axis([min(X(:,1))-2 , max(X(:,1))+2, min(X(:,2))-2, max(X(:,2))+2]);
        grid on
     
    else
        for i=1:numClases
            FoI = Y == valoresClases(i);
            x1 = X(FoI,1);
            x2 = X(FoI,2);
            x3 = X(FoI,3);
            plot3(x1,x2,x3,nombresProblema.simbolos{i});
            axis([min(X(:,1))-2 , max(X(:,1))+2, min(X(:,2))-2, max(X(:,2))+2,min(X(:,3))-2 , max(X(:,3))+2]);
        end
        
        legend(leyenda{1},leyenda{2})
        xlabel(nombresProblema.descriptores{1}), ylabel(nombresProblema.descriptores{2}), zlabel(nombresProblema.descriptores{3})
        grid on
    end
    
    hold off
end