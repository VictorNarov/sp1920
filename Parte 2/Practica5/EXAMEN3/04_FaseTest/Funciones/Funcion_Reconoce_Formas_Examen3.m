function Funcion_Reconoce_Formas_Examen3(Nombre)
%% En la representación de la fase 3 vimos que las muestras de las clases C y E estaban separadas
% y no presentaban dependencia lineal, por lo tanto, usaremos el
% clasificador de minima distancia Euclídea
I=rgb2gray(imread(Nombre));

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

% Cargar información de los clasificadores
load('02_DisegnoClasificador_Knn/DatosGenerados/datos_Knn_ACDE');
XTrainKnn = XTrain;
YTrainKnn = YTrain;
espacioCcasKnn = espacioCcas;
nombresProblemaKnn = nombresProblemaOI;

% Preparamos los conjuntos de datos reducidos
XTestRedKnn = XTest(:, espacioCcasKnn);

k=9; % Aplicamos el clasificador Knn
YTestKnn = funcion_knn_D (XTestRedKnn, XTrainKnn, YTrainKnn, k, 'Euclidea', espacioCcasKnn);

for i=1:numMuestras %POR CADA OBJETO DE LA IMAGEN    
    %% REGLA DE DECISIÓN
    clase_objeto = 'Desconocida';
    figure,ax1=subplot(1,2,1),funcion_visualiza(I, Ietiq==i, [255 255 0]);
    title(['Objeto pertenece clase:' clase_objeto]); 
    
    % DISCERNIR ENTRE B Y EL RESTO SEGUN NUMERO DE EULER
    % Aplicamos el clasificador del numero E
    numEuler = regionprops(Ietiq==i, 'Euler').EulerNumber;
    if numEuler == -1
        
        clase_objeto = 'B';
        axes(ax1);title(['numEuler = -1: Objeto pertenece clase:' clase_objeto]); 
        
    else
       
        clase_objeto = nombresProblemaKnn.clases{YTestKnn(i)};      

        % Representacion
        axes(ax1);title(['numEuler != -1 -> KNN: Objeto pertenece clase:' clase_objeto]);
        subplot(1,2,2),funcion_representa_datos_knn(XTrain, YTrain, nombresProblemaOI);
        x1 = XTest(i,espacioCcas(1)); x2 = XTest(i,espacioCcas(2)); x3 = XTest(i,espacioCcas(3));
        hold on, plot3(x1,x2,x3, 'dk');
        title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);  
   

    end

end
    
       
end

