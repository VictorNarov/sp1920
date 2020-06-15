function funcion_representa_datos(X,Y, espacioCcas, nombresProblema)

valoresClases = unique(Y);
numClases = length(valoresClases);
figure;
if length(espacioCcas) == 2
    
    for i=1:numClases
        
        FoI = Y == valoresClases(i);
        x1 = X(FoI,espacioCcas(1));
        x2 = X(FoI,espacioCcas(2));
        
        plot(x1, x2, nombresProblema.simbolos{i}), hold on; 
    
    end
    legend(nombresProblema.clases)
    xlabel(nombresProblema.descriptores{espacioCcas(1)}), ylabel(nombresProblema.descriptores{espacioCcas(2)})
    x1 = X(:,espacioCcas(1));
    x2 = X(:,espacioCcas(2));

    axis([min(x1), max(x1), min(x2), max(x2)]);
    grid on
elseif length(espacioCcas) == 3
    for i=1:numClases
        
        FoI = Y == valoresClases(i);
        x1 = X(FoI,espacioCcas(1));
        x2 = X(FoI,espacioCcas(2));
        x3 = X(FoI,espacioCcas(3));
        plot3(x1, x2, x3, nombresProblema.simbolos{i}), hold on; 
    
    end
    legend(nombresProblema.clases)
    xlabel(nombresProblema.descriptores{espacioCcas(1)}), ylabel(nombresProblema.descriptores{espacioCcas(2)}), zlabel(nombresProblema.descriptores{espacioCcas(3)});
    x1 = X(:,espacioCcas(1));
    x2 = X(:,espacioCcas(2));
    x3 = X(:,espacioCcas(3));
    axis([min(x1) , max(x1), min(x2), max(x2), min(x3), max(x3)]);
    grid on
end
end

