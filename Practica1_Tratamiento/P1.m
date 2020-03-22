clear all, clc;
imfinfo('P1_1.jpg');

Imagen1 = imread('P1_1.jpg');
valor_max = max(Imagen1(:))

% 8 imagen complementaria
imshow(255-Imagen1) % otra manera
figure,subplot(1,3,1),imshow(Imagen1),subplot(1,3,2),imshow(imcomplement(Imagen1)),subplot(1,3,3),imshow(255-Imagen1);

Imagen2 = imcomplement(Imagen1);

R = rand()*255 - Imagen1(:,:,1);
G = rand()*255 - Imagen1(:,:,2);
B = rand()*255 - Imagen1(:,:,3);
RGB = cat(3,R,G,B);

figure,subplot(1,2,1),imshow(Imagen1),subplot(1,2,2),imshow(RGB);




imtool(Imagen2);
imwrite(Imagen2, 'P1_complement.jpg');



% 9 imagen en blanco y negro con los valores RED
Imagen3 = Imagen1(:,:,1);
imtool(Imagen3)

% 10 Cambiar gamma,  no desplaza todos los valores de grises
% los valores del brillo no se modifican desplazando el histograma
% Modifica los valores del rango del histograma segun el exponente gamma 
Imagen4 = imadjust(Imagen1, [],[],1.5);
Imagen5 = imadjust(Imagen1, [],[],0.5);

figure,subplot(2,3,1),imshow(Imagen3),subplot(2,3,2),imshow(Imagen4),subplot(2,3,3),imshow(Imagen5);
subplot(2,3,4),imhist(Imagen3),subplot(2,3,5),imhist(Imagen4),subplot(2,3,6),imhist(Imagen5);

% 11 diferencia en valor absoluto, valores más claros si hay más diferencia
% entre las dos imágenes
Imagen6 = imabsdiff(Imagen4,Imagen5);

figure,subplot(1,3,1),imshow(Imagen4),subplot(1,3,2),imshow(Imagen5),subplot(1,3,3),imshow(Imagen6);

Imabsdiff = imabsdiff(Imagen4,Imagen5);
Im = (funcion_imabsdiff(Imagen4,Imagen5));

Imagen1(230,250), Imagen2(230,250), Imabsdiff(230,250), Im(230,250)
figure,subplot(1,4,1),imshow(Imagen4),subplot(1,4,2),imshow(Imagen5),subplot(1,4,3),imshow(Imabsdiff),subplot(1,4,4),imshow(Im);

funcion_compara_matrices(Imabsdiff,Im);


%%%%%%%%%%%%

hM = imhist(Imagen1(:,:,1));
hNv1 = funcion_imhist_v1(Imagen1);
hNv2 = funcion_imhist_v2(Imagen1);
funcion_compara_matrices(hNv2, hM)



