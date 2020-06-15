clear all, clc
addpath(genpath(pwd))

Distancia = 'Mahalanobis'
%% 0- LEER LA IMAGEN
Nombre = 'Test1.JPG';

I=imread(Nombre);

%% 1- BINARIZAR CON METODOLOGÍA DE SELECCIÓN AUTOMÁTICA DE UMBRAL (OTSU)
T = 255*graythresh(I);
Ibin = I < T;

%% 2.- ELIMINAR POSIBLES COMPONENTES CONECTADAS RUIDOSAS: 
% COMPONENTE RUIDOSA:
% COMPONENTES DE MENOS DEL 0.1% DEL NÚMERO TOTAL DE PÍXELES DE LA IMAGEN
% O NÚMERO DE PÍXELES MENOR AL AREA DEL OBJETO MAYOR /5
% SE DEBE CUMPLIR CUALQUIERA DE LAS DOS CONDICIONES

% Genera IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);
IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);

%% 3.- ETIQUETAR.
% Genera matriz etiquetada Ietiq y número N de agrupaciones conexas 
[Ietiq N] = bwlabel(IbinFilt);


%% 4.- CALCULAR TODOS LOS DESCRIPTORES DE CADA AGRUPACIÓN CONEXA
% Genera Ximagen - matriz de N filas y 23 columnas (los 23 descriptores
% generados en el orden indicado en la práctica)
XImagen = funcion_calcula_descriptores_imagen(Ietiq,N);

%% 5- ESTANDARIZAR LOS DATOS
% Necesitamos leer los datos guardados en la etapa 01 de medias y
% desviaciones
load('01_GeneracionDatos/DatosGenerados/datos_estandarizacion')

[numMuestras, numDescriptores] = size(XImagen);
XTest = XImagen;

for i=1:numDescriptores-1
    XTest(:,i) = (XImagen(:,i) - medias(i)) / desviaciones(i);
end
 
%% 6- RECONOCER OBJETOS: APLICAR Y EVALUAR FUNCIONES DECISION

% FASE 1: APLICAR CLASIFICADOR KNN (CIRCULOS-CUADRADOS VS TRIANGULOS)
% Cargar información de los clasificadores
load('Clasificador_Knn_2clases/02_DisegnoClasificador/DatosGenerados/datos_Knn');
XTrainKnn = XTrain;
YTrainKnn = YTrain;
espacioCcasKnn = espacioCcas;
nombresProblemaKnn = nombresProblemaOI;

load('Clasificador_MDE_CircTrian/02_DisegnoClasificador/DatosGenerados/MDE_CircTrian');
XTrainDistancia = XoIRed;
YTrainDistancia = YoIRed;
coeficientes_d12MDE = coeficientes_d12;
nombresProblemaDistancia = nombresProblemaOIRed;
espacioCcasMDE = espacioCcas;
d12_MDE = d12;

load('Clasificador_MDM_CircTrian/02_DisegnoClasificador/DatosGenerados/MDM_CircTrian');
espacioCcasMDM = espacioCcas;
coeficientes_d12MDM = coeficientes_d12;
d12_MDM = d12;

k=9;

XTestRedKnn = XTest(:, espacioCcasKnn);
XTestRedMDE = XTest(:, espacioCcasMDE);
XTestRedMDM = XTest(:, espacioCcasMDM);

YTestKnn = funcion_knn_D(XTestRedKnn, XTrainKnn, YTrainKnn, k, Distancia, espacioCcasKnn);

for i=1:numMuestras %POR CADA OBJETO DE LA IMAGEN    
    %% REGLA DE DECISIÓN
    clase_objeto = 'Desconocida';
    
        % Representacion
        figure, ax1 = subplot(1,3,1); funcion_visualiza(I, Ietiq==i, [255 255 0]);
        
        subplot(1,3,2),funcion_representa_datos_knn(XTrain, YTrain, nombresProblemaOI);
        x1 = XTest(i,espacioCcas(1)); x2 = XTest(i,espacioCcas(2)); x3 = XTest(i,espacioCcas(3));
        hold on, plot3(x1,x2,x3, 'dk');
        title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);            
    
    if YTestKnn(i) == 2 % Solo necesitamos Knn
        codifClases = unique(YTrainKnn);
        pos_clase = find(ismember(codifClases,YTestKnn(i)));
        clase_objeto = nombresProblemaKnn.clases(pos_clase); % ES UN CUADRADO
        
        axes(ax1),title(['KNN: Objeto pertenece clase:' clase_objeto]);
        
    elseif YTestKnn(i) == 1 % ES CIRCULO O TRIANGULO, APLICAMOS EL CLASIFICADOR DE DISTANCIA
        
      if Distancia == "Euclidea"
        x1 = XTestRedMDE(i,1);
        x2 = XTestRedMDE(i,2);
        x3 = XTestRedMDE(i,3);
        
        d12_evaluada = eval(d12_MDE);
        
        % Representacion
        subplot(1,3,3),funcion_representa_muestras_clasificacion_binaria_con_frontera(XTrainDistancia, YTrainDistancia, coeficientes_d12MDE, nombresProblemaDistancia);
        hold on, plot3(x1,x2,x3, 'dk');
        title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);

        
      else
        x1 = XTestRedMDM(i,1);
        x2 = XTestRedMDM(i,2);
        x3 = XTestRedMDM(i,3);
        d12_evaluada = eval(d12_MDM);
        
        % Representacion
        subplot(1,3,3),funcion_representa_muestras_clasificacion_binaria_con_frontera(XTrainDistancia, YTrainDistancia, coeficientes_d12MDM, nombresProblemaDistancia);
        hold on, plot3(x1,x2,x3, 'dk');
        title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);

        
      end

      if d12_evaluada > 0

          clase_objeto = nombresProblemaDistancia.clases(1);
          axes(ax1),title(['KNN + MDE: Objeto pertenece clase:' clase_objeto]);
      else
          clase_objeto = nombresProblemaDistancia.clases(2);
          axes(ax1),title(['KNN + MDM: Objeto pertenece clase:' clase_objeto]);
      end

    end
    
       
end
