clear all, clc;

datos = [2 1;3 2;3 3;4 2;6 1;5 2;7 3]
Y = [1;1;1;1;2;2;2]



valoresClases = unique(Y);
numClases = length(valoresClases);
[numDatos, numAtributos] = size(datos);
    

%Vector de medias 
M = zeros(numClases, numAtributos);
mCov = zeros(numAtributos,numAtributos,numClases);

for i=1:numClases

    FoI = Y==valoresClases(i);
    XClase = datos(FoI,:);
    M(i,:) = mean(XClase);
    mCov(:,:,i) = cov(XClase,1);
        
end

coef_corr = funcion_calcula_coeficiente_correlacion(mCov)

mCovC = (4 * mCov(:,:,1) + 3*mCov(:,:,2)) / (4+3);

[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(datos,Y);


%% Representacion datos
    funcion_representa_muestras_clasificacion_binaria(datos,Y), hold on

    plot(M(:,1),M(:,2),'ko-'); % Puntos medios
    
    % Frontera de decision
    
    A = coeficientes_d12(1);
    B = coeficientes_d12(2);
    C = coeficientes_d12(3);

    x1Recta = min(datos(:,1))-1 : 0.01 : max(datos(:,1))+1;
    x2Recta = -(A*x1Recta+C) / (B+eps); % A*x1+B*x2+C = 0
    
    hold on, plot(x1Recta, x2Recta, 'g*');
