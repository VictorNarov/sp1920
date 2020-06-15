clear all,clc;

% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load('01_GeneracionDatos/DatosGenerados/conjunto_datos_estandarizados');
load('01_GeneracionDatos/DatosGenerados/nombresProblema');

X=Z;

% b)Círculos-Cuadrados vs Triangulos
% Marcar cuadrados como circulos
 Y(Y==2) = 1;

clasesOI = [1 3];
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
nombresProblemaOI.clases(2) = []; % Eliminamos cuadrados
nombresProblemaOI.clases(1) = {'Círculos-Cuadrados'};

%funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI)
%title(['Indice J = ' num2str(JespacioCcas)])

% Guardamos los datos
save('Circ-CuadTrian_MDE/01_SeleccionDescriptores/DatosGenerados/datos_descriptores_MDE', 'nombresProblemaOI','XoI','YoI', 'espacioCcas');
