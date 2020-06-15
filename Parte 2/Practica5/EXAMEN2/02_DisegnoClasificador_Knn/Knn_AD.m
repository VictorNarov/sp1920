clear all,clc;

% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados');
load('01_GeneracionDatos/DatosGenerados/nombresProblema');

X=Z;

% A vs D SELECCIONAR DATOS DE LAS CLASES DE INTERES
clasesOI = [1 4];
filasOI = false(size(Y));

for i=1:length(clasesOI)
    filasOI_i = Y == clasesOI(i);
    filasOI = or(filasOI,filasOI_i);
end

XoI = X(filasOI, :);
YoI = Y(filasOI);

% Nos dan el espacio de caracteristicas
% Extension invariante, Hu1, Hu2

espacioCcas = [5, 6, 7];

% Nuevo struct nombres problema
nombresProblemaOI = nombresProblema;
nombresProblemaOI.clases = {'A', 'D'};
nombresProblemaOI.simbolos = {'*r', '*y'};


%funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI)
%title(['Indice J = ' num2str(JespacioCcas)])

XTrain = XoI(:,espacioCcas);
YTrain = YoI;


%% Guardamos los datos 
save('02_DisegnoClasificador_Knn/DatosGenerados/datos_Knn_AD.mat','XTrain', 'YTrain', 'espacioCcas', 'nombresProblemaOI');