clear,clc,close all;

%% Cargo los directorios
addpath('Funciones');
addpath('Imagenes');
addpath('Videos')

%% Parte 1

% 1. Determinar el brillo y el contraste de la imagen “P4.jpg”. 
P4 = imread("P4.jpg"); % Cargo la imagen (Esta en niveles de intensidad)
brillo = funcion_calcular_brillo(P4);
% brillo = 138.8170

% 2. Genere nuevas imágenes de mayor y menor brillo que la original y mida, 
%    para cada imagen generada, el nuevo valor de brillo.

% Para eso usaremos el comando imadjust
% Imagen con mas brillo
P41 = imadjust(P4,[],[],0.8);
brillo_claro = funcion_calcular_brillo(P41);

% Imagen con menos brillo
P42 = imadjust(P4,[],[],1.2);
brillo_oscuro = funcion_calcular_brillo(P42);


% 3. Genere nuevas imágenes de mayor y menor contraste que la original 
%    y mida, para cada imagen generada, el nuevo valor de contraste.

contraste_original = funcion_calcular_contraste(P4,brillo);

% Para eso usaremos el comando imadjust
% Imagen con menos contraste
P41 = imadjust(P4,[],[0.4 0.5]);
brillo_bajo_contraste = funcion_calcular_brillo(P41);
contraste_bajo = funcion_calcular_contraste(P41,brillo_bajo_contraste);

% Imagen con mas contraste
P42 = imadjust(P4,[0.3 0.7]);
brillo_alto_contraste = funcion_calcular_brillo(P42);
contraste_alto = funcion_calcular_contraste(P42,brillo_alto_contraste);

% 4. Aumente el contraste de la zona central de la imagen expandiendo 
%    de forma lineal el histograma.  

%% Segunda parte

% Cargamos las imagenes
A1 = imread('A1.jpg');
A2 = imread('A2.jpg');
A3 = imread('A3.jpg');

% Convertimos la primera imagen a imagen de intensidad
A1I = rgb2gray(A1);

% Calculamos el histograma de cada una de las imagenes
[h1,nivelesGris1] = imhist(A1I);
[h2,nivelesGris2] = imhist(A2);
[h3,nivelesGris3] = imhist(A3);

% Calculamos la intensidad maxima de cada histograma
[numPixMax1, A1I_max] = max(h1);
[numPixMax2, A2_max] = max(h2);
[numPixMax3, A3_max] = max(h3);
% Realmente el nivel maximo es el nivel calculado anteriormente -1 
% debido a que el histograma va de 1~256 y no de 0~255

% Ahora vamos a calcular el segundo maximo
valores2Max1 = zeros(256,1);
valores2Max2 = zeros(256,1);
valores2Max3 = zeros(256,1);

for g=1:256
    valores2Max1(g) = ((g-A1I_max)^2)*h1(g);
    valores2Max2(g) = ((g-A2_max)^2)*h2(g);
    valores2Max3(g) = ((g-A3_max)^2)*h3(g);
end

[~, A1I_max2] = max(valores2Max1);
[~, A2_max2] = max(valores2Max2);
[~, A3_max2] = max(valores2Max3);

% Ahora vamos a ejecutar la funcion minimo entra maximos
minimo_entre_maximos1 = MinEntreMax(h1);
minimo_entre_maximos2 = funcion_minimo_entre_maximos(A2_max,A2_max2,numPixMax2,h2);
minimo_entre_maximos3 = funcion_minimo_entre_maximos(A3_max,A3_max2,numPixMax3,h3);

%% Suavización de ruido en el histograma
% Se lo aplicaremos a la imagen 3

horig = imhist(A3);
horig_norm = (1/max(horig))*horig;

valorMaxRuido = 0.05;
h = horig_norm + valorMaxRuido*rand(size(horig));
close all;
figure, plot(0:255,horig_norm,'r');
figure, plot(0:255,h,'g');

I = imread("ImagenBinaria.tif");

T = T_otsu(I)
255*graythresh(I);