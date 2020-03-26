% Práctica 3
% Introducción a la adquisición de imágenes digitales en Matlab
% Víctor M. Rodríguez

% 1 

clear all
clc

%% Configuración dispositivo de captura
datos=imaqhwinfo('winvideo')
video=videoinput('winvideo',1,'YUY2_640x360'); % 30 fps
video.ReturnedColorSpace = 'rgb';


% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FramesPerTrigger=1; % 2 frames por disparo
video.FrameGrabInterval=6; %30/6=5fps 


preview(video)

I = getsnapshot(video);
imshow(I);



%% CREAR PLANTILLA
sample_regions(:,:) = roipoly(I);
[filas columnas]=find(sample_regions==1);
fila1=min(filas);
fila2=max(filas);
columna1=min(columnas);
columna2=max(columnas);
Plantilla=I(fila1:fila2,columna1:columna2);

imshow(Plantilla)
imshow(sample_regions)

[NT MT]=size(Plantilla);


start(video)

while(video.FramesAcquired<150)
    I=getdata(video,1); % captura un frame guardado en memoria. 
    I=rgb2gray(I);
    ncc = normxcorr2(Plantilla,I);
    [Nncc Mncc]=size(ncc);
    ncc=ncc(1+floor(NT/2):Nncc-floor(NT/2),1+floor(MT/2):Mncc-floor(MT/2));
    [i j]=find(ncc==max(ncc(:)));
    
    imshow(I),hold on, plot(j,i,'R*'),hold off
end
stop(video)

delete(video);
clear video;


%% EJERCICIO 1

% CONFIGURACION DISP. CAPTURA
clear all, clc
video=videoinput('winvideo',1,'YUY2_640x360'); % 30 fps
video.ReturnedColorSpace = 'rgb';
% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FramesPerTrigger=1; % 2 frames por disparo
video.FrameGrabInterval=6; %30/6=5fps 

preview(video);
captura = getsnapshot(video);
imshow(captura);

% Calcular matriz intensidad
R = double(captura(:,:,1));
G = double(captura(:,:,2));
B = double(captura(:,:,3));

Intensidad = uint8((R+G+B) / 3);
I = zeros(3,360,640);
I(1,:,:) = Intensidad > 100;
I(2,:,:) = Intensidad > 150;
I(3,:,:) = Intensidad > 200;

figure, subplot(2,2,1), imshow(I), 
subplot(2,2,2), imshow(I(1,:,:)), 
subplot(2,2,3), imshow(I(2)),
subplot(2,2,4), imshow(I(3));

%% EJERCICIO 2
for umbral=1:3
    
    %Obtengo la matriz etiquetada con N objetos de cada umbral
    [Ietiq(umbral) N(umbral)]=bwlabel(I(umbral)); 
    
    % Obtener estadisticas de los objetos
    stats(umbral)=regionprops(Ietiq(umbral),'Area','Centroid'); 
    
    % Obtener centroides en un vector
    centroides(umbral)=cat(1,stats(umbral).Centroid);
    
    
    % Obtener mat. 3 dimensiones a partir de la matriz booleana
    Imagen(umbral) = cat(3,Ietiq(umbral),Ietiq(umbral),Ietiq(umbral));
    
    % Marcar todos centroides en color verde
    for i=1:N(umbral)
        fila = floor(centroides(umbral,i,2));
        col = floor(centroides(umbral,i,1));
        % Coloreo sus vecinos 8
        for j=fila-1:fila+1
            for k=col-1:col+1
                Imagen(umbral,j,k,:) = [0 255 0];
            end
        end

    end
    
    % Obtener areas
    areas(umbral)=cat(1,stats(umbral).Area);
    
    % Buscar indices correspondientes al objeto
    obj_mayor(umbral) = find(areas(umbral)==max(areas(umbral)));
    centroide_mayor(umbral) = centroides(umbral,obj_mayor(umbral),:);
    
    
    
end

figure, subplot(2,2,1), imshow(I), 
subplot(2,2,2), imshow(Imagen(1)), 
subplot(2,2,3), imshow(Imagen(2)),
subplot(2,2,4), imshow(Imagen(3));


% Marcar esos centroides en rojo
Imagen1(floor(centroide_mayor1(2)),floor(centroide_mayor1(1)),:) = [255 0 0];
Imagen2(floor(centroide_mayor2(2)),floor(centroide_mayor2(1)),:) = [255 0 0];
Imagen3(floor(centroide_mayor3(2)),floor(centroide_mayor3(1)),:) = [255 0 0];






