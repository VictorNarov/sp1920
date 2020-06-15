clear all; clc;
I = imread('Circulo1.jpg');
 %% contar numero pixeles del circulo
 I = imread('Circulo1.jpg');
imhist(I);

ROI = I<120

imshow(ROI)

num = sum(ROI(:) == 1)

imshow(I)

%% contar numero pixeles de la primera X
clear all; clc;

I = imread('X.jpg');

ROI = I<120;

imshow(ROI)

%funcion_etiquetar(num = sum(ROI(:) == 1)

%% Ietiq = funcion etiquetar(Ib)
% ej 3 p2 fundamento en la ultima pagina de la practica
% conectividad tipo 8, ser vecinos y ademas satisfacer una cond (ser 1)


Ietiq = funcion_etiquetar(ROI);

imtool(Ietiq)

% version 2
Ietiq = funcion_etiquetar_v2(ROI,4,"columna");

imtool(Ietiq==2)

