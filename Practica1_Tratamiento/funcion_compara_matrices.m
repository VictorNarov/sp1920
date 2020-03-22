function funcion_compara_matrices(A,B)

Error = double(A) - double(B); 

m = min(Error(:));
M = max(Error(:));

if m==M && m==0
    disp('Matrices iguales')
else
    disp('Matrices diferentes')
end

end
