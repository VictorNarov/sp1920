% CLASIFICADOR K-NEAREST-NEIGHBOURS:básicamente consiste en medir la
% distancia entre la muestra desconocida y cada una de las
% muestras de entrenamiento disponibles. Nos quedamos con las k distancias
% menores y asociamos a la muestra desconocida aquella clase que más se% repita.

% ENTRADAS-SALIDAS DE LA FUNCIÓN
% XTest: matriz numMuestrasTest x numDescriptores  
% XTrain: matriz numMuestrasTrain x numDescriptores
% YTrain: matriz numMuestrasTrain x 1 (codificación de las clases
% para cada instancia de train) 
% k: número de"vecinos" más cercanos considerado% distancia: 'Euclidea' ó 'Mahalanobis'
% YTest: matriz numMuestrasTest x 1 (codificación delasclases predichas
%   para cada instancia de test).

function YTest = funcion_knn_D (XTest, XTrain, YTrain, k, Distancia, espacioCcas)
codifClases = unique(YTrain);
[numMuestrasTest, ~] = size(XTest);
[numMuestrasTrain, ~] = size(XTrain);
numAtributos = length(espacioCcas);
numClases = length(codifClases);
YTest = [];

for i=1:numMuestrasTest    
    % 1.-CALCULO DEL VECTOR DISTANCIAS ENTRE LA INSTANCIA DE TEST Y TODAS LAS
    % INSTANCIAS DE TRAIN
  
    if Distancia == "Euclidea"
        iTest = repmat(XTest(i,:),numMuestrasTrain,1)';
        distancias = sqrt(sum((XTrain' - iTest ).^2));

    else
        
        mCov = zeros(numAtributos,numAtributos,numClases);
        for j=1:numClases
            FoI = YTrain==codifClases(j);
            XClase = XTrain(FoI,:);
            mCov(:,:,j) = cov(XClase,1);
        end
        
       
        % 1.-CALCULO DEL VECTOR DISTANCIAS ENTRE LA INSTANCIA DE TEST Y TODAS LAS% INSTANCIAS DE TRAIN
        distancias = [];
        
        for j=1:numMuestrasTrain
            mCovClase = mCov(:,:,YTrain(j));
            X1 = XTrain(j,:);
            X2 = XTest(i,:);
            distancia_calculada = (X1-X2)*pinv(mCovClase)*(X1-X2)';
            distancias = [distancias distancia_calculada];
        end
    end
    
   % 2.-LOCALIZAR LAS k INSTANCIAS DE XTrain MAS CERCANAS A LA INSTANCIA DE% TEST BAJO CONSIDERACIÓN
   
      [distancias_ordenadas indices] = sort(distancias);

      menores_k_indices = indices(1:k);

       % 3.-CREAR UN VECTOR CON LAS CODIFICACIONES DE LAS CLASES DE ESAS% k-INSTANCIAS MÁS CERCANA
       ocurrencias_clases = zeros(numClases,1);
       for h=1:k
          valorMuestraTrain = YTrain(menores_k_indices(h));
          indiceClase = find(ismember(codifClases, valorMuestraTrain));
          ocurrencias_clases(indiceClase) = ocurrencias_clases(indiceClase) + 1;
       end
    
   % 4.-ANALIZAR ESE VECTOR PARA CONTAR EL NÚMERO DE VECES QUE APARECE
   % CADA CODIFICACIÓNPRESENTE EN EL VECTOR (unique del vector)
  
%     [numOcurrencias valor] = groupcounts(vector_clases);
%       
%     [~, indice] = max(numOcurrencias);
%     
%     clase_objeto = valor(indice);
%    
%     YTest = [YTest; clase_objeto];
     [~, clase_objeto] = max(ocurrencias_clases);
     YTest = [YTest; clase_objeto];
     
    end
end



