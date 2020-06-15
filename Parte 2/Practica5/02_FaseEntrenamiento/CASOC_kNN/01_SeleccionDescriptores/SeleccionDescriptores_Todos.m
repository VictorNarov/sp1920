clear all,clc;

% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados');
load('01_GeneracionDatos/DatosGenerados/nombresProblema');

X=Z;

% Nos interesan todas las clases
XoI = X;
YoI = Y;

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

% Nuevo struct nombres problema
nombresProblemaOI = nombresProblema;

%funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI)
%title(['Indice J = ' num2str(JespacioCcas)])

% Guardamos los datos
save('01_SeleccionDescriptores/DatosGenerados/datos_descriptores_Knn', 'nombresProblemaOI','XoI','YoI','espacioCcas');
