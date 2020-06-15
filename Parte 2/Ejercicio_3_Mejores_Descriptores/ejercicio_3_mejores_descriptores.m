%Sobre  el  conjunto  de  datos  X-Y  de  la  práctica(sin  considerar  el  número  de  Euler), 
%determina  las  3 características que proporcionan de forma conjuntala mayor separabilidad 
%en los datos y representa las muestras en ese espacio de características.

% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load 'DatosGenerados/conjunto_datos_estandarizados'
%load 'DatosGenerados/conjunto_datos'
load 'DatosGenerados/nombresProblema'

X = Z;
%[numMuestras, numDescriptores] = size(X);


%% a)Círculos vs cuadrados vs triángulos
XoI = X;
YoI = Y;
numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

% Nuevo struct nombres problema
nombresProblemaOI{1} = nombresProblema;

funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI{1})
title(['Indice J = ' num2str(JespacioCcas)])

XoI_problema{1} = XoI;
YoI_problema{1} = YoI;

%% b)Círculos vs cuadrados
% Marcar triangulos a cero 
YoI = Y(Y ~= 3);
XoI = X(YoI ~= 3, :);

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

% Nuevo struct nombres problema
nombresProblemaOI{2} = nombresProblema;
nombresProblemaOI{2}.clases(3) = []; % Eliminamos triangulos

funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI{2})
title(['Indice J = ' num2str(JespacioCcas)])

XoI_problema{2} = XoI;
YoI_problema{2} = YoI;

%% c)Círculos vs triángulos
YoI = Y(Y ~= 2);
XoI = X(YoI ~= 2, :);

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

% Nuevo struct nombres problema
nombresProblemaOI{3} = nombresProblema;
nombresProblemaOI{3}.clases(2) = []; % Eliminamos cuadrados

funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI{3})

title(['Indice J = ' num2str(JespacioCcas)])

XoI_problema{3} = XoI;
YoI_problema{3} = YoI;

%% d)Cuadrados vs triángulos
YoI = Y(Y ~= 1);
XoI = X(YoI ~= 1, :);

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

% Nuevo struct nombres problema
nombresProblemaOI{4} = nombresProblema;
nombresProblemaOI{4}.clases(1) = []; % Eliminamos circulos

funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI{4})

title(['Indice J = ' num2str(JespacioCcas)])

XoI_problema{4} = XoI;
YoI_problema{4} = YoI;

%% e)Círculos-triángulos vs cuadrados
YoI = Y;
YoI(YoI==3) = 1; % Reemplazar valor para juntar las 2 clases
XoI = X;

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

% Nuevo struct nombres problema
nombresProblemaOI{5} = nombresProblema;
nombresProblemaOI{5}.clases(3) = []; % Eliminamos triangulos
nombresProblemaOI{5}.clases{1} = 'Circulos-Triangulos';

funcion_representa_datos(XoI,YoI, espacioCcas, nombresProblemaOI{5})

title(['Indice J = ' num2str(JespacioCcas)])

XoI_problema{5} = XoI;
YoI_problema{5} = YoI;

%% Guardamos los datos
save('Ejercicio_3_mejores_descriptores/DatosGenerados/datos_problema_3_descriptores', 'XoI_problema', 'YoI_problema' , 'nombresProblemaOI')

