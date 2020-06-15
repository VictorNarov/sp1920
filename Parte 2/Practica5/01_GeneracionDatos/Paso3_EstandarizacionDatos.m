load conjunto_datos.mat
load nombresProblema.mat

% Variables del problema
[numMuestras, numDescriptores] = size(X);
codifClases = unique(Y);
numClases = length(codifClases);

%% ESTANDARIZACION: VALORES EN EL MISMO RANGO

medias = mean(X);
desviaciones = std(X);
medias(end) = 0; %Num de euler no se modifica
desviaciones(end) = 1;

Z = X;

for i=1:numDescriptores-1
    Z(:,i) = (X(:,i) - medias(i)) / desviaciones(i);
end

%% GUARDAMOS LOS DATOS: PARA PODER VOLVER A NORMALIZAR UNA NUEVA MUESTRA DE TEST
save('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados', 'Z', 'Y');
save('01_GeneracionDatos/DatosGenerados/datos_estandarizacion', 'medias', 'desviaciones');