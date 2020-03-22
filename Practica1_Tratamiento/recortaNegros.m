function recorte = recortaNegros(path)
I = imread(path);
cont = 0;
recorte = false(size(I));

for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j) < 100
            cont = cont+1;
            recorte(i,j) = true;
        end
    end
end