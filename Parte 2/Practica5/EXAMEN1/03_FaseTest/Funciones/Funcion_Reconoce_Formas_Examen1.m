function Funcion_Reconoce_Formas_Examen1(Nombre)
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
load('CircCuad_MDM/02_DisegnoClasificador/DatosGenerados/MDM_CircCuad');
CircCuad.d12 = d12;
CircCuad.coeficientes_d12 = coeficientes_d12;
CircCuad.nombresProblema = nombresProblemaOIRed;
CircCuad.espacioCcas = espacioCcas;
CircCuad.XoI = XoIRed;
CircCuad.YoI = YoIRed;

load('Circ-CuadTrian_MDE/02_DisegnoClasificador/DatosGenerados/MDE_Circ-CuadTrian');
Circ_CuadTrian.d12 = d12;
Circ_CuadTrian.coeficientes_d12 = coeficientes_d12;
Circ_CuadTrian.nombresProblema = nombresProblemaOIRed;
Circ_CuadTrian.espacioCcas = espacioCcas;
Circ_CuadTrian.XoI = XoIRed;
Circ_CuadTrian.YoI = YoIRed;


for i=1:numMuestras
    
    %% 1. Clasificador Circ-CuadTrian
        %  Selecciono los descriptores
        descriptoresOI = XImagen_S(i, Circ_CuadTrian.espacioCcas);
        x1 = descriptoresOI(1);
        x2 = descriptoresOI(2);
        x3 = descriptoresOI(3);
        
        x1_1 = x1; x2_1 = x2; x3_1 = x3;
        % Evaluamos d12 de CirTrian
        d12_Circ_CuadTrian = eval(Circ_CuadTrian.d12);
        
     
    
    %% 2. Clasificador CircCuad MDM
        %  Selecciono los descriptores
        descriptoresOI = XImagen_S(i, CircCuad.espacioCcas);
        x1 = descriptoresOI(1);
        x2 = descriptoresOI(2);
        x3 = descriptoresOI(3);
        
        x1_2 = x1; x2_2 = x2; x3_2 = x3;
        % Evaluamos d12 de CirCuad
        d12_CircCuad = eval(CircCuad.d12);
     
 
        
    %% REGLA DE DECISIÓN
    clase_objeto = 'Desconocida';
    if d12_Circ_CuadTrian < 0
        clase_objeto = Circ_CuadTrian.nombresProblema.clases(2); % ES UN TRIANGULO   
        
         % Representamos
        figure,subplot(1,2,1), funcion_visualiza(I, Ietiq==i, [255 255 0]);
         title(['MDE: Objeto pertenece clase:' clase_objeto]);
         
        subplot(1,2,2),funcion_representa_muestras_clasificacion_binaria_con_frontera(Circ_CuadTrian.XoI, Circ_CuadTrian.YoI, Circ_CuadTrian.coeficientes_d12, Circ_CuadTrian.nombresProblema);
        hold on, plot3(x1_1,x2_1,x3_1, 'dk');
        title(['MDE: x1= ' num2str(x1_1) 'x2= ' num2str(x2_1) 'x3= ' num2str(x3_1)]);
    
    else
        
        if d12_CircCuad > 0
            clase_objeto = CircCuad.nombresProblema.clases(1); % ES UN CIRCULO
        end
        
        if d12_CircCuad < 0
            clase_objeto = CircCuad.nombresProblema.clases(2); % ES UN CIRCULO
        end
        
          % Representamos
        figure,subplot(1,3,1), funcion_visualiza(I, Ietiq==i, [255 255 0]);
        title(['MDE+MDM: Objeto pertenece clase:' clase_objeto]);
         
        subplot(1,3,2),funcion_representa_muestras_clasificacion_binaria_con_frontera(Circ_CuadTrian.XoI, Circ_CuadTrian.YoI, Circ_CuadTrian.coeficientes_d12, Circ_CuadTrian.nombresProblema);
        hold on, plot3(x1_1,x2_1,x3_1, 'dk');
        title(['MDE: x1= ' num2str(x1) 'x2= ' num2str(x2) 'x3= ' num2str(x3)]);
        
        subplot(1,3,3),funcion_representa_muestras_clasificacion_binaria_con_frontera(CircCuad.XoI, CircCuad.YoI, CircCuad.coeficientes_d12, CircCuad.nombresProblema);
        hold on, plot3(x1_2,x2_2,x3_2, 'dk');
        title(['MDM: x1= ' num2str(x1_2) 'x2= ' num2str(x2_2) 'x3= ' num2str(x3_2)]);
            
    end
    %% MOSTRAR RESULTADO
    %axes(ax1), hold on, plot3(x1,x2,x3, 'dk') % Representar muestra
end

%% 1.5.- GENERAR Yimagen
% Genera Yimagen -  matriz de N filas y 1 columna con la codificación
% empleada para la clase a la que pertenecen los objetos de la imagen

% YImagen = ones(N,1)*i;
% 
% X = [X ; XImagen];
% Y = [Y ; YImagen];

end