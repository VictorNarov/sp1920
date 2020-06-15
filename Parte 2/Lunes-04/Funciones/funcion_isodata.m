function T = funcion_isodata(h, umbralParada)
    gIni = 1; gFin=256;
    T = calcula_valor_medio_region_histograma(h, gIni, gFin);
    
    varControl = true;

    
    while varControl
       
        gIni = 1; gFin = round(T);
        gMean1 = calcula_valor_medio_region_histograma(h, gIni, gFin);
        
        gIni = round(T)+1; gFin = 256;
        gMean2 = calcula_valor_medio_region_histograma(h, gIni, gFin);
        
        newT = mean([gMean1 gMean2]); %Por si alguna media es []
        
        if abs(T-newT) <= umbralParada
            varControl = false;
        end
        
        T = newT;
    end
    T = T - 1;
end

