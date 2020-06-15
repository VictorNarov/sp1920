clear all,clc;
load datos_MDM_2dimensiones.mat;

valoresClases = unique(Y);
numClases = length(valoresClases);
[numDatos numAtributos] = size(X);

% Vector de medias
M = zeros(numClases,numAtributos);
% Matrices covarianzas
mCov = zeros(numAtributos,numAtributos,numClases);


% Calculo vector prototipo de medias de cada clase
for i=1:numClases

    FoI = Y==valoresClases(i);
    XClase = X(FoI,:);
    M(i,:) = mean(XClase);
    mCov(:,:,i) = cov(XClase,1);

end

% Variables correladas, covarianza de las variables != 0
mCov_clase1 = mCov(:,:,1);
coef_corr = funcion_calcula_coeficiente_correlacion(mCov_clase1)

mCov_clase2 = mCov(:,:,2);
coef_corr = funcion_calcula_coeficiente_correlacion(mCov_clase2)

%% Diseño clasificador MDM

[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X,Y);
