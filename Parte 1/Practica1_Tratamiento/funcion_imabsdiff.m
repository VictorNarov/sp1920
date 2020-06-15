% function funcion_compara_matrices(A,B)
%    % E = A-B;
%      %devuelve si todos los valores de las matrices son identicos
%     
% end

function Resultado = funcion_imabsdiff(A,B)

%Resultado = max(A,B) - min(A,B);
Resultado = uint8(abs(double(A) - double(B)));
end


