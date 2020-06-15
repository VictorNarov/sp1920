clear all,clc;
load datos_MDE_2dimensiones.mat;

valoresClases = unique(Y);
numClases = length(valoresClases);
[numDatos numAtributos] = size(X);

% Vector de medias
M = zeros(numClases,numAtributos);
% Matrices covarianzas
mCov = zeros(numAtributos,numAtributos,numClases);

for i=1:numClases
   
    FoI = Y==valoresClases(i);
    XClase = X(FoI,:);
    M(i,:) = mean(XClase);
    mCov(:,:,i) = cov(XClase,1);
    
    
end

% Variables no correladas, covarianza de las variables aprox 0
mCov_clase1 = mCov(:,:,1);
coef_corr = funcion_calcula_coeficiente_correlacion(mCov_clase1)

mCov_clase2 = mCov(:,:,2);
coef_corr = funcion_calcula_coeficiente_correlacion(mCov_clase2)


%% Diseño clasificador MDE

[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(X,Y);

%% Aplicacion del clasificador: Opcion cuadratica - Tantas funciones de decision como clases

 Y_clasificador1 = zeros(size(Y));
 
 for i=1:numDatos
     XoI = X(i,:);
     x1 = XoI(1);
     x2 = XoI(2);
     
     valor_d1 = eval(d1);
     valor_d2 = eval(d2);
     
     if valor_d1 > valor_d2
         Y_clasificador1(i) = valoresClases(1);
     else
         Y_clasificador1(i) = valoresClases(2);
     end
 end
 
 %% Aplicacion del clasificador: Opcion lineal - Funcion para separar las dos clases, frontera lineal

 Y_clasificador2 = zeros(size(Y));
 A = coeficientes_d12(1);  B = coeficientes_d12(2);  C = coeficientes_d12(3);
 
 for i=1:numDatos
     XoI = X(i,:);
     x1 = XoI(1);
     x2 = XoI(2);
     
    d12_manual = A*x1 + B*x2 + C;
    %eval(d12);
    
     if d12_manual > 0
         Y_clasificador2(i) = valoresClases(1);
     else
         Y_clasificador2(i) = valoresClases(2);
     end
 end
 
 %% Evaluamos la precision
 
 Y_modelo = Y_clasificador1;
 
 error = Y_modelo - Y;
 
 num_aciertos = sum(error==0);
 Acc = num_aciertos/numDatos * 100
 
 
 
