clear all,clc;

%% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados');
load('01_GeneracionDatos/DatosGenerados/nombresProblema');

X=Z;

%% TODOS LAS CLASES MENOS B
clasesOI = [1 3 4 5];
filasOI = false(size(Y));

for i=1:length(clasesOI)
    filasOI_i = Y == clasesOI(i);
    filasOI = or(filasOI,filasOI_i);
end

XoI = X(filasOI, :);
YoI = Y(filasOI);

%% Buscamos el mejor espacio de caracteristicas
numDescriptoresOI=9;
[espacioCcas, JespacioCcas]=funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI)

%% Nuevo struct nombres problema
nombresProblemaOI = nombresProblema;
nombresProblemaOI.clases = {'A', 'C', 'D', 'E'};
nombresProblemaOI.simbolos = {'*r', '*b','*y', '*c'};

%%Representacion
%funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI)
%title(['Indice J = ' num2str(JespacioCcas)])

%% Datos filtrados
XTrain = XoI(:,espacioCcas);
YTrain = YoI;

%% Guardamos los datos 
save('02_DisegnoClasificador_Knn/DatosGenerados/datos_Knn_ACDE.mat','XTrain', 'YTrain', 'espacioCcas', 'nombresProblemaOI');