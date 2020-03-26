clear all, clc;
Imagen = imread('imagen_binaria.png');

% ----------------------------------------------------------------------------------------
% 3. Genera  una  imagen  en  color,  donde  se  visualice 
%   con  un  color  diferente  los  objetos presentes  en  la  imagen
% ----------------------------------------------------------------------------------------
 
[Ietiq N] = funcion_etiquetar_v2(Imagen>100, 8, "fila");
imtool(Ietiq)

Icolor = cat(3,Ietiq,Ietiq,Ietiq);
R = [255    0   0   255     255 0];
G = [0      255 0   255     0   255];
B = [0      0   255 0       255 255];

Icolor_R = Icolor(:,:,1);
Icolor_G = Icolor(:,:,2);
Icolor_B = Icolor(:,:,3);
for i=1:N
    Icolor_R(Icolor_R==i) = R(i);
    Icolor_G(Icolor_G==i) = G(i);
    Icolor_B(Icolor_B==i) = B(i);
end

Icolor = cat(3,Icolor_R,Icolor_G,Icolor_B);

imtool(Icolor)

% ----------------------------------------------------------------------------------------
% 4.Genera una imagen donde se localicen, a través de su centroide,
% los objetos de mayor y menor área
% (ver documentación para la definición de área y centroide).
% ----------------------------------------------------------------------------------------
areas = calcula_areas(Ietiq)            %Obtenemos los valores de las areas de los objetos

obj_mayor = find(areas==max(areas))     %Obtenemos el indice del mayor y menor objeto
obj_menor = find(areas==min(areas))

centroide_mayor = calcula_centroides(Ietiq==obj_mayor)
centroide_menor = calcula_centroides(Ietiq==obj_menor)

Imagen_centroides = cat(3,Ietiq,Ietiq,Ietiq);

% COLOREAR EL CENTROIDE MAYOR DE ROJO
Imagen_centroides(int32(centroide_mayor(1)), int32(centroide_mayor(2)), 1) = 1;
Imagen_centroides(int32(centroide_mayor(1)), int32(centroide_mayor(2)), 2) = 0;
Imagen_centroides(int32(centroide_mayor(1)), int32(centroide_mayor(2)), 3) = 0;

% COLOREAR EL CENTROIDE MENOR DE ROJO
Imagen_centroides(int32(centroide_menor(1)), int32(centroide_menor(2)), 1) = 1;
Imagen_centroides(int32(centroide_menor(1)), int32(centroide_menor(2)), 2) = 0;
Imagen_centroides(int32(centroide_menor(1)), int32(centroide_menor(2)), 3) = 0;

figure, imshow(Imagen_centroides) %Visualizar la imagen con los centroides del mayor y menor objeto en rojo

% ----------------------------------------------------------------------------------------
% 5.Genera una imagen binaria donde sólo se visualicen los dos objetos deárea mayor.
% ----------------------------------------------------------------------------------------
imshow(filtra_objetos(Imagen,5000))


%% Funciones de matlab

[Ietiq2 N] = bwlabel(Imagen); %Similar a funcion_etiquetar_v2(Imagen,8,"columna";
N
imtool(Ietiq2);

stats=regionprops(Ietiq2,'Area','Centroid'); 
% stats.Area contiene información de las áreas de cada objeto
% stats.Centroid -contiene información de la coordenada x (columna)
% y la coordenada y (fila) del centroide de cada objeto


MatrizBinaria_ObjetosGrandes=bwareaopen(Imagen,5000); 
%se eliminan de la MatrizBinaria todos las agrupaciones de píxeles a “1” 
% compuestas por menos de NumPixpixeles.

imtool(MatrizBinaria_ObjetosGrandes);
