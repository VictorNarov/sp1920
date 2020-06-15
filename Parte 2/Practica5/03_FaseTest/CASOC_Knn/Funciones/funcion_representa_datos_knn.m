function funcion_representa_datos_knn(X,Y, nombresProblema)

valoresClases = unique(Y);
numClases = length(valoresClases);

    for i=1:numClases
        
        FoI = Y == valoresClases(i);
        x1 = X(FoI,1);
        x2 = X(FoI,2);
        x3 = X(FoI,3);
        plot3(x1, x2, x3, nombresProblema.simbolos{i}), hold on; 
    
    end
    legend(nombresProblema.clases)
    xlabel(nombresProblema.descriptores{1}), ylabel(nombresProblema.descriptores{2}), zlabel(nombresProblema.descriptores{3});
    x1 = X(:,1);
    x2 = X(:,2);
    x3 = X(:,3);
    axis([min(x1) , max(x1), min(x2), max(x2), min(x3), max(x3)]);
    grid on
end


