function T = T_otsu(I)

    h = imhist(I);
    
    gIni = 1; gFin=256;
    [gMean, numPix] = calcula_valor_medio_region_histograma(h, gIni, gFin);
    
    var = zeros(256,1);
    
    for g=2:255
       T=g;
       var(g) = calcula_varianza_entre_clases(T,h,numPix, gMean);
    end

    [~, indice] = max(var);
    
    T = indice-1;
end

function var = calcula_varianza_entre_clases(T,h,numPix,gMean)
    
    [gMean1, N1] = calcula_valor_medio_region_histograma(h, 1, T);
    [gMean2, N2] = calcula_valor_medio_region_histograma(h, T+1, 256);

    N = numPix;
    
    prob1 = N1 / N;
    prob2 = N2 / N;
    
    var = prob1*(gMean1 - gMean)^2 + prob2*(gMean2 - gMean)^2;

end


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