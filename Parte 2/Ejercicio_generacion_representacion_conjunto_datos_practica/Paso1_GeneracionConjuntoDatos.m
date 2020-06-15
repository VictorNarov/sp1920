%% PROGRAMACIÓN GENERACIÓN CONJUNTO DE DATOS X-Y

%% LECTURA AUMATIZADA DE LAS IMÁGENES DE ENTRENAMIENTO DISPONIBLES

% LECTURA AUTOMATIZADA DE IMAGENES
addpath('Imagenes/Entrenamiento')

nombres{1}='Circulo';
nombres{2} = 'Cuadrado';
nombres{3} = 'Triangulo';

numClases = 3;
numImagenesPorClase = 2;

%% --------------------------------
%% 1.- GENERACIÓN CONJUNTO DE DATOS X-Y
%% --------------------------------

X = []; 
Y = [];

for i=1:numClases
    for j=1:numImagenesPorClase
        
        nombreImagen = [nombres{i} num2str(j,'%02d') '.jpg']
        I = imread(nombreImagen);
        


%% PARA CADA IMAGEN:

%% 1.1- BINARIZAR CON METODOLOGÍA DE SELECCIÓN AUTOMÁTICA DE UMBRAL (OTSU)
T = 255*graythresh(I);
Ibin = I < T;


% Genera: Ibin

%% 1.2.- ELIMINAR POSIBLES COMPONENTES CONECTADAS RUIDOSAS: 

% COMPONENTE RUIDOSA:
% COMPONENTES DE MENOS DEL 0.1% DEL NÚMERO TOTAL DE PÍXELES DE LA IMAGEN
% O NÚMERO DE PÍXELES MENOR AL AREA DEL OBJETO MAYOR /5
% SE DEBE CUMPLIR CUALQUIERA DE LAS DOS CONDICIONES

% Genera IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);
IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);
% ind =0;
% if i==1
%     ind=1;
%     
% elseif i==2 
%     ind=3;
%     
% else 
%     ind = 5;
% end
% 
% subplot(3,2,ind), imshow(Ibin), title('Sin filtrar'), subplot(3,2,ind+1), imshow(IbinFilt),title('Filtrada');

%% 1.3.- ETIQUETAR.

% Genera matriz etiquetada Ietiq y número N de agrupaciones conexas 
[Ietiq N] = bwlabel(IbinFilt);


%% 1.4.- CALCULAR TODOS LOS DESCRIPORES DE CADA AGRUPACIÓN CONEXA

% Genera Ximagen - matriz de N filas y 23 columnas (los 23 descriptores
% generados en el orden indicado en la práctica)

 XImagen = funcion_calcula_descriptores_imagen(Ietiq,N);


%% 1.5.- GENERAR Yimagen

% Genera Yimagen -  matriz de N filas y 1 columna con la codificación
% empleada para la clase a la que pertenecen los objetos de la imagen

YImagen = ones(N,1)*i;


X = [X ; XImagen];
Y = [Y ; YImagen];
    end
end
%% --------------------------------
%% 2.- GENERACIÓN VARIABLE TIPO STRUCT nombresProblema
%% --------------------------------

% nombreDescriptores = {'XXX','XXX', 'XXX', 'XXX', ... HASTA LOS 23};
nombreDescriptores{1} = 'Compacticidad';
nombreDescriptores{2} = 'Excentricidad';
nombreDescriptores{3} = 'Solidez';
nombreDescriptores{4} = 'Extension';
nombreDescriptores{5} = 'Extension Invariante Rotacion';
nombreDescriptores{6} = 'Hu Numero 1';
nombreDescriptores{7} = 'Hu Numero 2';
nombreDescriptores{8} = 'Hu Numero 3';
nombreDescriptores{9} = 'Hu Numero 4';
nombreDescriptores{10} = 'Hu Numero 5';
nombreDescriptores{11} = 'Hu Numero 6';
nombreDescriptores{12} = 'Hu Numero 7';
nombreDescriptores{13} = 'DF Numero 1';
nombreDescriptores{14} = 'DF Numero 2';
nombreDescriptores{15} = 'DF Numero 3';
nombreDescriptores{16} = 'DF Numero 4';
nombreDescriptores{17} = 'DF Numero 5';
nombreDescriptores{18} = 'DF Numero 6';
nombreDescriptores{19} = 'DF Numero 7';
nombreDescriptores{20} = 'DF Numero 8';
nombreDescriptores{21} = 'DF Numero 9';
nombreDescriptores{22} = 'DF Numero 10';
nombreDescriptores{23} = 'Numero de Euler';

% nombreClases:
nombreClases{1} = 'Circulos';
nombreClases{2} = 'Cuadrados';
nombreClases{3} = 'Triangulos';


% simboloClases: simbolos y colores para representar las muestras de cada clase
 simbolosClases{1} = '*r';
 simbolosClases{2} = '*g';
 simbolosClases{3} = '*b';
% ...

% ------------------------------------
nombresProblema = [];
nombresProblema.descriptores = nombreDescriptores;
nombresProblema.clases = nombreClases;
nombresProblema.simbolos = simbolosClases;


%% --------------------------------
%% 3.- GUARDAR CONJUNTO DE DATOS Y NOMBRES DEL PROBLEMA
% (EN DIRECTORIO DATOSGENERADOS)
%% --------------------------------
save('DatosGenerados/conjunto_datos', 'X','Y')
save('DatosGenerados/nombresProblema', 'nombresProblema')
