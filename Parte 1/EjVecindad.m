clear all, clc;
M1 = uint8(rand(5)*10+1);

% 1.-Genera un matriz A, de 5 filas y 5 columnas,
% con números aleatorios entre 0 y 1.
B = M1(2:4,3:5);

% 2.-Genera una nueva matriz B compuesta por el píxel
% localizado en la fila 3  columna 4 y
% sus 8 vecinos más cercanos. 
fila = 3;
col = 4;
M1

% 3.-Genera un vector C compuesto
% por la vecindad tipo-4 del píxel 
% localizado en la fila 3  columna 4.

C = [M1(fila:col-1:col+1) M1(fila-1:fila+1,col)']
index = find(C==M1(fila,col)) %Encuentra la pos donde estan los 1 logicos donde el valor es C
C(index) = [] %Quitarlas

%C = [M1(fila-1,col),M1(fila,col),M1(fila+1,col),M1(fila,col-1),M1(fila,col+1)];

%4.-Genera un vector D con los vecinos tipo-8 
% de la fila superior del píxel localizado en la fila 3  columna 4.
fila = 3;
col = 4;
M1
D = M1(fila-1,col-1:col+1)

% 5-Incorporar al vector D los vecinos de la izquierda y derecha 
% del píxel en cuestión.

% D = [D M1(fila,col-1) M1(fila,col+1)]
D = [D M1(fila,col-1:2:c+1)] %SALTO 2
 
% 6.-Generar una matriz E a partir de la matriz A,
% poniendo a cero todos los valores de A inferiores a 0.5.

% E = A > 0.5
% E = E * A 

E = A
E(A<0.5) = 0

% A(A<0.5) valores donde estan los numeros binarios (vector col) NO

% A = rand(5)
% E = A
% index = find(A<0.5)
% E(index) = 0

% 7.-Calcular la media de los valores de A que estén entre 0.2 y 0.7.
A = rand(5)
valores = A(A<=0.7 & A>=0.2)
media = sum(valores(:)) / length(valores)
media2 = mean(valores


% 8.-Genera dos matrices A y B, 5x5, de números aleatorios entre 0 y 1. 
% Calcula la media de A en aquellos puntos donde B es mayor a 0.5. 

A = rand(5);
B = rand(5);

%index = find(B>0.5)
media = mean(A(B>0.5))

% funcion
clear all;
Ic = imread('X.jpg');
 
Ib = (Ic(:,:,2)<100);

color = uint8([255,0,0]);
cambiaPixeles(Ic, Ib, color);

% Reemplazar segun INTENSIDAD
Ic = imread('P1_1.jpg');
R = double(Ic(:,:,1));
G = double(Ic(:,:,2));
B = double(Ic(:,:,3));

I = (R+G+B)/3; % NO SE CONVIERTE A UINT8 AQUI

%imshow(uint8(I)) % SOLO CUANDO LO QUEREMOS VISUALIZAR

X = imread('X.jpg');

% FUNCION VISUALIZA
ROI = X<120;
figure, imshow(ROI)


cambiaPixeles(Igris, ROI, color)


