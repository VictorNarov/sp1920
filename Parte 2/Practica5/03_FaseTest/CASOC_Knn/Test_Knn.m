clear all, clc
addpath(genpath(pwd))

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
 
%% 6- RECONOCER OBJETOS: APLICAR Y EVALUAR 3 FUNCIONES DECISION
% Cargar información de Train
load('datos_Knn');
k=9;
%distancia = 'Euclidea';
distancia = 'Mahalanobis'

XTestRed = XTest(:, espacioCcas);

YTest= funcion_knn (XTestRed, XTrain, YTrain, k, distancia, espacioCcas);

for i=1:numMuestras %POR CADA OBJETO DE LA IMAGEN    
    %% REGLA DE DECISIÓN
    clase_objeto = 'Desconocida';
    if YTest(i) == 1
        clase_objeto = 'Circulos'; % ES UN CIRCULO     
    elseif YTest(i) == 2
        clase_objeto = 'Cuadrados'; % ES UN CUADRADO
    elseif YTest(i) == 3
        clase_objeto = 'Triangulos'; % ES UN TRIANGULO
   
    end
    %% MOSTRAR RESULTADO
    
    figure, subplot(1,2,1), funcion_visualiza(I, Ietiq==i, [255 255 0]);
    title(['KNN: Objeto pertenece clase:' clase_objeto]);
    
    subplot(1,2,2),funcion_representa_datos_knn(XTrain, YTrain, nombresProblemaOI);
    x1 = XTest(i,espacioCcas(1)); x2 = XTest(i,espacioCcas(2)); x3 = XTest(i,espacioCcas(3));
    hold on, plot3(x1,x2,x3, 'dk');
    title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);                 

end

%% 1.5.- GENERAR Yimagen
% Genera Yimagen -  matriz de N filas y 1 columna con la codificación
% empleada para la clase a la que pertenecen los objetos de la imagen

% YImagen = ones(N,1)*i;
% 
% X = [X ; XImagen];
% Y = [Y ; YImagen];