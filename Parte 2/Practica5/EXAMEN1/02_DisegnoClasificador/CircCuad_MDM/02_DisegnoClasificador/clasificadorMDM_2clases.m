clear all, clc;

addpath(genpath(pwd))
load('01_SeleccionDescriptores/DatosGenerados/datos_CircCuad.mat')

XoIRed = XoI(:,espacioCcas);
YoIRed = YoI;

%% DiseÃ±o clasificador MDE
[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(XoIRed,YoIRed);


%% Representamos muestras y plano del clasificador
nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombresProblemaOI.descriptores(espacioCcas);
nombresProblemaOIRed.clases = nombresProblemaOI.clases;
nombresProblemaOIRed.simbolos = nombresProblemaOI.simbolos;

%funcion_representa_muestras_clasificacion_binaria(XoIRed,YoIRed,nombresProblemaOIRed);
funcion_representa_muestras_clasificacion_binaria_con_frontera(XoIRed,YoIRed,coeficientes_d12,nombresProblemaOIRed);
title('Función de decisión clasificador MDM');
%% Guardamos los datos
save('02_DisegnoClasificador/DatosGenerados/MDM_CircCuad.mat','espacioCcas', 'd12', 'coeficientes_d12', 'XoIRed', 'YoIRed', 'nombresProblemaOIRed');