function var = calcula_varianza_entre_clases(T,h,numPix,gMean)
    
    [gMean1, N1] = calcula_valor_medio_region_histograma(h, 1, T);
    [gMean2, N2] = calcula_valor_medio_region_histograma(h, T+1, 256);

    N = numPix;
    
    prob1 = N1 / N;
    prob2 = N2 / N;
    
    var = prob1*(gMean1 - gMean)^2 + prob2*(gMean2 - gMean)^2;

end
