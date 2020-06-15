clear all, clc;

% Cargar todos los directorios en el path del espacio de trabajo
addpath(genpath(pwd));

load('datosEj2.mat');


valoresClases = unique(YTrain);
numClases = length(valoresClases);
[numDatos, numAtributos] = size(XTrain);

% Representamos los datos
funcion_representa_muestras_clasificacion_binaria(XTrain,YTrain);
    

%Vector de medias 
M = zeros(numClases, numAtributos);

%% Diseño del clasificador
[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(XTrain,YTrain);


%% 2.2 Representación de la frontera que separa las clases (Puntos a la misma
% distancia Mahalanubis de los v. prototipo de cada clase).
    funcion_representa_muestras_clasificacion_binaria(XTest,YTest);
    
    hold on,plot3(M(:,1),M(:,2),M(:,3),'ko-'), hold on; % Puntos medios
    
    % Frontera de decision
    
    A = coeficientes_d12(1);
    B = coeficientes_d12(2);
    C = coeficientes_d12(3);
    D = coeficientes_d12(4);

    % Plano del del clasificador MDM lineal
    Xmin = min(XTest(:));
    Xmax = max(XTest(:));
    paso = (Xmax-Xmin)/100;
    [x1Plano, x2Plano] = meshgrid(Xmin:paso:Xmax);
    x3Plano = -(A*x1Plano + B*x2Plano + D) / (C+eps);
    surf(x1Plano,x2Plano,x3Plano);
    
%% Aplicación lineal del clasificador
% Usamos la función discriminante d12 como frontera
valoresClases = unique(YTest);
numClases = length(valoresClases);
[numDatos, numAtributos] = size(XTest);


Y_Lineal = zeros(size(YTest));

    for i=1:numDatos
        x1 = XTest(:,1);
        x2 = XTest(:,2);
        x3 = XTest(:,3);

        valor_d12 = eval(d12);

        if valor_d12 > 0
            Y_Lineal(i) = valoresClases(1);
        else
            Y_Lineal(i) = valoresClases(2);
        end

    end

%% Apliación cuadrática del clasificador    
% Evaluamos cada funcion discriminante y
% Nos quedamos con la de mayor valor para esa instancia
 Y_Cuadratica = zeros(size(YTest));

    for i=1:numDatos
        x1 = XTest(i,1);
        x2 = XTest(i,2);
        x3 = XTest(i,3);

        valor_d1 = eval(d1);
        valor_d2 = eval(d2);

        if valor_d1 > valor_d2
            Y_Cuadratica(i) = valoresClases(1);
        else
            Y_Cuadratica(i) = valoresClases(2);
        end

    end


%% 2.3 Accuracy - Precisión del clasificador
Y_modelo = Y_Lineal;
error = Y_modelo - YTest;
num_aciertos = sum(error==0);
Acc_Lineal = num_aciertos / numDatos;

Y_modelo = Y_Cuadratica;
error = Y_modelo - YTest;
num_aciertos = sum(error==0);
Acc_Cuadratica = num_aciertos / numDatos;

%% 2.4
% A simple vista apreciamos que los datos siguen una dispersión de tal
% forma que los atributos x1 y x2 están muy relacionados, a medida que
% crece uno, crece el otro, por lo que cumple no cumple la condición de
% baja correlación para el clasificador MDE, donde los atributos son
% estadísticas independientes

% Representamos los datos
funcion_representa_muestras_clasificacion_binaria(XTest,YTest);

