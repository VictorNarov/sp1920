%Diseño   del   clasificador:   generación   del   conjunto   de   datos  
% de entrenamiento  para  el  clasificador  XTrain-YTrain.
% Esta  etapa  guarda este conjunto de entrenamiento. 

clear all, clc;

addpath(pwd)

load('01_SeleccionDescriptores/DatosGenerados/datos_descriptores_Knn.mat')

XTrain = XoI(:,espacioCcas);
YTrain = YoI;


%% Guardamos los datos 
save('02_DisegnoClasificador/DatosGenerados/datos_Knn.mat','XTrain', 'YTrain', 'espacioCcas', 'nombresProblemaOI');