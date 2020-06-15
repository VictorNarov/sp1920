clear all, clc;
load('Datos/datos_biomarcadores_exp1.mat');


funcion_representa_muestras_clasificacion_binaria(datos,clases);

valoresClases = unique(clases);
numClases = length(valoresClases);
[numDatos, numAtributos] = size(datos);
    

%Vector de medias 
M = zeros(numClases, numAtributos);
mCov = zeros(numAtributos,numAtributos,numClases);

for i=1:numClases

    FoI = clases==valoresClases(i);
    XClase = datos(FoI,:);
    M(i,:) = mean(XClase);
    mCov(:,:,i) = cov(XClase,1);
        
end

% Suponemos mCov1 = mCov2 -> mCovConjunta 

mCovC = (22 * mCov(:,:,1) + 22 * mCov(:,:,2)) / 44;


[d1_mCov_comun, d2_mCov_comun, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(datos,clases);

%% Representacion datos
   funcion_representa_muestras_clasificacion_binaria(datos,clases), hold on

    plot(M(:,1),M(:,2),'ko-'); % Puntos medios
    
    % Frontera de decision
    
    A = coeficientes_d12(1);
    B = coeficientes_d12(2);
    C = coeficientes_d12(3);

    x1Recta = min(datos(:,1))-1 : 0.01 : max(datos(:,1))+1;
    x2Recta = -(A*x1Recta+C) / (B+eps); % A*x1+B*x2+C = 0
    
    hold on, plot(x1Recta, x2Recta, 'g*');
