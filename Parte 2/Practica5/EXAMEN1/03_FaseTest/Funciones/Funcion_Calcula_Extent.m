function Extent = Funcion_Calcula_Extent(Ibin)

    Ibin_centrada = Funcion_Centra_Objeto(Ibin);
    numPixObjeto = sum(Ibin(:));
    Extent = [];
    
    for i=0:5:355
        Ibin_rotada = imrotate(Ibin_centrada,i);
        
        stats=regionprops(Ibin_rotada, 'BoundingBox');
        
        bb = cat(1,stats.BoundingBox);
        % COL, FILA (ESQUINA SUP IZDA), ANCHURA Y ALTURA
        
        numPixBB = bb(3)*bb(4);
        
        extentObjeto = numPixObjeto / numPixBB;
        
        Extent = [Extent extentObjeto];
    end
    
    Extent = max(Extent);

end

