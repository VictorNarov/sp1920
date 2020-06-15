clear all,clc;

% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados');
load('01_GeneracionDatos/DatosGenerados/nombresProblema');

X=Z;

% b)Círculos vs cuadrados
% Marcar triangulos a cero 
% YoI = Y(Y ~= 3);
% XoI = X(YoI ~= 3, :);

clasesOI = [1 2];
filasOI = false(size(Y));

for i=1:length(clasesOI)
    filasOI_i = Y == clasesOI(i);
    filasOI = or(filasOI,filasOI_i);
end

XoI = X(filasOI, :);
YoI = Y(filasOI);

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

% Nuevo struct nombres problema
nombresProblemaOI = nombresProblema;
nombresProblemaOI.clases(3) = []; % Eliminamos triangulos

%funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI)
%title(['Indice J = ' num2str(JespacioCcas)])

% Guardamos los datos
save('01_SeleccionDescriptores/DatosGenerados/datos_CircCuad', 'nombresProblemaOI','XoI','YoI', 'espacioCcas');
