clear all, clc;

load('01_SeleccionDescriptores/DatosGenerados/datos_descriptores_MDE.mat')

XoIRed = XoI(:,espacioCcas);
YoIRed = YoI;

%% Diseño clasificador MDE
[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(XoIRed,YoIRed);


%% Representamos muestras y plano del clasificador
nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombresProblemaOI.descriptores(espacioCcas);
nombresProblemaOIRed.clases = nombresProblemaOI.clases;
nombresProblemaOIRed.simbolos = nombresProblemaOI.simbolos;

%funcion_representa_muestras_clasificacion_binaria(XoIRed,YoIRed,nombresProblemaOIRed);
funcion_representa_muestras_clasificacion_binaria_con_frontera(XoIRed,YoIRed,coeficientes_d12,nombresProblemaOIRed);

%% Guardamos los datos
save('Circ-CuadTrian_MDE/02_DisegnoClasificador/DatosGenerados/MDE_Circ-CuadTrian','espacioCcas', 'd12', 'coeficientes_d12', 'XoIRed', 'YoIRed', 'nombresProblemaOIRed');