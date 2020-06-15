function [gMean, numPix] = calcula_valor_medio_region_histograma(h, gIni, gFin)

    gIni = round(gIni);
    if gIni<1
        gIni =1;
    end
    
    gFin = round(gFin);
    if gFin>256
        gFin = 256;
    end
    
    gMean = 0;
    for g=gIni:gFin
       gMean = gMean + g*h(g); 
    end

    numPix = sum(h(gIni:gFin));
    
    if numPix > 0
        gMean = gMean / numPix;
    else
        gMean = [];
    end

end