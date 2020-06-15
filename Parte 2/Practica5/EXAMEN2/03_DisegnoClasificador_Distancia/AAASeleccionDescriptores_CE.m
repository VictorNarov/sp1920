clear all,clc;

% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados');
load('01_GeneracionDatos/DatosGenerados/nombresProblema');

X=Z;

%% C vs E SELECCIONAR DATOS DE LAS CLASES DE INTERES
clasesOI = [3 5];
filasOI = false(size(Y));

for i=1:length(clasesOI)
    filasOI_i = Y == clasesOI(i);
    filasOI = or(filasOI,filasOI_i);
end

XoI = X(filasOI, :);
YoI = Y(filasOI);

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

%% Nuevo struct nombres problema
nombresProblemaOI = nombresProblema;
nombresProblemaOI.clases = {'C', 'E'};
nombresProblemaOI.simbolos = {'*b', '*c'};

%% Representacion
funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI)
title(['Indice J = ' num2str(JespacioCcas)])

% Vemos que los datos están separados y no siguen una dependencia lineal. 
% Podríamos usar el clasificador MDE.


%% Guardamos los datos
save('03_DisegnoClasificador_Distancia/DatosGenerados/datos_descriptores_CE', 'nombresProblemaOI','XoI','YoI', 'espacioCcas');
