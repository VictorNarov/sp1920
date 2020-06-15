function Funcion_Reconoce_Formas(Nombre)
addpath(genpath(pwd))

%% 0- LEER LA IMAGEN
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
XImagen_S = XImagen;

for i=1:numDescriptores-1
    XImagen_S(:,i) = (XImagen(:,i) - medias(i)) / desviaciones(i);
end
 
%% 6- RECONOCER OBJETOS: APLICAR Y EVALUAR 3 FUNCIONES DECISION
% Cargar información de cada clasificador

load('MDE_CircCuad');
CircCuad.coeficientes_d12 = coeficientes_d12;
CircCuad.d12 = d12;
CircCuad.nombresProblema = nombresProblemaOIRed;
CircCuad.espacioCcas = espacioCcas;
CircCuad.XoI = XoIRed;
CircCuad.YoI = YoIRed;

load('MDE_CircTrian');
CircTrian.coeficientes_d12 = coeficientes_d12;
CircTrian.d12 = d12;
CircTrian.nombresProblema = nombresProblemaOIRed;
CircTrian.espacioCcas = espacioCcas;
CircTrian.XoI = XoIRed;
CircTrian.YoI = YoIRed;

load('MDE_CuadTrian');
CuadTrian.coeficientes_d12 = coeficientes_d12;
CuadTrian.d12 = d12;
CuadTrian.nombresProblema = nombresProblemaOIRed;
CuadTrian.espacioCcas = espacioCcas;
CuadTrian.XoI = XoIRed;
CuadTrian.YoI = YoIRed;

for i=1:numMuestras
    %% 1. Clasificador CircCuad
        %  Selecciono los descriptores
        descriptoresOI = XImagen_S(i, CircCuad.espacioCcas);
        x1 = descriptoresOI(1);
        x2 = descriptoresOI(2);
        x3 = descriptoresOI(3);
        
        % Evaluamos d12 de CirCuad
        d12_CircCuad = eval(CircCuad.d12 > 0);
        
        % Representamos
        figure,subplot(2,2,2),funcion_representa_muestras_clasificacion_binaria_con_frontera(CircCuad.XoI, CircCuad.YoI, CircCuad.coeficientes_d12, CircCuad.nombresProblema);
        hold on, plot3(x1,x2,x3, 'dk');
        title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);
        
    %% 2. Clasificador CircTrian
        %  Selecciono los descriptores
        descriptoresOI = XImagen_S(i, CircTrian.espacioCcas);
        x1 = descriptoresOI(1);
        x2 = descriptoresOI(2);
        x3 = descriptoresOI(3);
        
        % Evaluamos d12 de CirTrian
        d12_CircTrian = eval(CircTrian.d12 > 0);
        
        % Representamos
        subplot(2,2,3),funcion_representa_muestras_clasificacion_binaria_con_frontera(CircTrian.XoI, CircTrian.YoI, CircTrian.coeficientes_d12, CircTrian.nombresProblema);
        hold on, plot3(x1,x2,x3, 'dk');
        title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);
        
    %% 3. Clasificador CuadTrian
        %  Selecciono los descriptores
        descriptoresOI = XImagen_S(i, CuadTrian.espacioCcas);
        x1 = descriptoresOI(1);
        x2 = descriptoresOI(2);
        x3 = descriptoresOI(3);
        
        % Evaluamos d12 de CuadTrian
        d12_CuadTrian = eval(CuadTrian.d12 > 0);
        
        % Representamos
        subplot(2,2,4),funcion_representa_muestras_clasificacion_binaria_con_frontera(CuadTrian.XoI, CuadTrian.YoI, CuadTrian.coeficientes_d12, CuadTrian.nombresProblema);
        hold on, plot3(x1,x2,x3, 'dk');
        title(['x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);
        
     %% REGLA DE DECISIÓN
    clase_objeto = 'Desconocida';
    if d12_CircCuad &&  d12_CircTrian
        clase_objeto = CircCuad.nombresProblema.clases(1); % ES UN CIRCULO     
    elseif  ~d12_CircCuad && d12_CuadTrian
        clase_objeto = CircCuad.nombresProblema.clases(2); % ES UN CUADRADO
    elseif  ~d12_CircTrian && ~d12_CuadTrian
        clase_objeto = CircTrian.nombresProblema.clases(2); % ES UN TRIANGULO
   
    end
    %% MOSTRAR RESULTADO
    %axes(ax1), hold on, plot3(x1,x2,x3, 'dk') % Representar muestra

    subplot(2,2,1), funcion_visualiza(I, Ietiq==i, [255 255 0]);
    title(['MDM: Objeto pertenece clase:' clase_objeto]);
       
end

%% 1.5.- GENERAR Yimagen
% Genera Yimagen -  matriz de N filas y 1 columna con la codificación
% empleada para la clase a la que pertenecen los objetos de la imagen

% YImagen = ones(N,1)*i;
% 
% X = [X ; XImagen];
% Y = [Y ; YImagen];

end