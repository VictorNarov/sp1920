clear all, clc;

addpath(genpath(pwd))

load('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados');
load('01_GeneracionDatos/DatosGenerados/nombresProblema');

X=Z;

% b)Círculos vs Cuadrados
clasesOI = [1 2];
filasOI = false(size(Y));

for i=1:length(clasesOI)
    filasOI_i = Y == clasesOI(i);
    filasOI = or(filasOI,filasOI_i);
end

% Nos indican el espacio de caracteristicas
% DF3 DF7 
espacioCcas = [15, 19, 8];

XoIRed = X(filasOI, espacioCcas);
YoIRed = Y(filasOI);


%% DiseÃ±o clasificador MDE
[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(XoIRed,YoIRed);


% Nuevo struct nombres problema
nombresProblemaOI = nombresProblema;
nombresProblemaOI.clases(3) = []; % Eliminamos triangulos
nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombresProblemaOI.descriptores(espacioCcas);
nombresProblemaOIRed.clases = nombresProblemaOI.clases;
nombresProblemaOIRed.simbolos = nombresProblemaOI.simbolos;

%% Representamos muestras y plano del clasificador
%funcion_representa_muestras_clasificacion_binaria(XoIRed,YoIRed,nombresProblemaOIRed);
funcion_representa_muestras_clasificacion_binaria_con_frontera(XoIRed,YoIRed,coeficientes_d12,nombresProblemaOIRed);
title('Función de decisión clasificador MDM');
%% Guardamos los datos
save('CircCuad_MDM/02_DisegnoClasificador/DatosGenerados/MDM_CircCuad.mat','espacioCcas', 'd12', 'coeficientes_d12', 'XoIRed', 'YoIRed', 'nombresProblemaOIRed');