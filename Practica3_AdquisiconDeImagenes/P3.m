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

I = {Intensidad > 100,Intensidad > 150,Intensidad > 200};

figure, subplot(2,2,1), imshow(captura), 
subplot(2,2,2), imshow(cell2mat(I(1))), 
subplot(2,2,3), imshow(cell2mat(I(2))),
subplot(2,2,4), imshow(cell2mat(I(3)));

%% EJERCICIO 2
Ietiq = {[],[],[]}, N={[],[],[]},stats={[],[],[]}, centroides={[],[],[]}, Imagen={uint8([]),uint8([]),uint8([])}, areas={[],[],[]}, obj_mayor={[],[],[]}, centroide_mayor={[],[],[]};
for umbral=1:3
    
    %Obtengo la matriz etiquetada con N objetos de cada umbral
   [Etiquetada N{umbral}]=bwlabel(cell2mat(I(umbral))); 
   Ietiq{umbral} = mat2cell(Etiquetada,size(Etiquetada,1),size(Etiquetada,2));
    
    % Obtener estad[[[[[isticas de los objetos
    stats{umbral}=regionprops(cell2mat(Ietiq{umbral}),'Area','Centroid'); 
    
    % Obtener centroides en un vector
    centroides{umbral}=cat(1,stats{umbral}.Centroid);
    
    
    % Obtener mat. 3 dimensiones a partir de la matriz booleana
    Imagen{umbral} = cat(3,Ietiq{umbral},Ietiq{umbral},Ietiq{umbral});
    
    % Marcar todos centroides en color verde
    for i=1:N{umbral}
        fila = floor(centroides{umbral}(i,2));
        col = floor(centroides{umbral}(i,1));
        

        Imagen{umbral}{1}(fila,col)= 0; 
        Imagen{umbral}{2}(fila,col)= 255;
        Imagen{umbral}{3}(fila,col)= 0;


    end
    
    % Obtener areas
    areas{umbral}=cat(1,stats{umbral}.Area);
    
    % Buscar indices correspondientes al objeto
    obj_mayor{umbral} = find(areas{umbral}==max(areas{umbral}));
    centroide_mayor{umbral} = centroides{umbral}(obj_mayor{umbral},:);
    
    
    
end

% Marcar esos centroides en rojo
Imagen{1}{1}(floor(centroide_mayor{1}(2)),floor(centroide_mayor{1}(1))) = 255;
Imagen{1}{2}(floor(centroide_mayor{1}(2)),floor(centroide_mayor{1}(1))) = 0;
Imagen{1}{3}(floor(centroide_mayor{1}(2)),floor(centroide_mayor{1}(1))) = 0;

Imagen{2}{1}(floor(centroide_mayor{2}(2)),floor(centroide_mayor{2}(1))) = 255;
Imagen{2}{2}(floor(centroide_mayor{2}(2)),floor(centroide_mayor{2}(1))) = 0;
Imagen{2}{3}(floor(centroide_mayor{2}(2)),floor(centroide_mayor{2}(1))) = 0;

Imagen{3}{1}(floor(centroide_mayor{3}(2)),floor(centroide_mayor{3}(1))) = 255;
Imagen{3}{2}(floor(centroide_mayor{3}(2)),floor(centroide_mayor{3}(1))) = 0;
Imagen{3}{3}(floor(centroide_mayor{3}(2)),floor(centroide_mayor{3}(1))) = 0;



%Mostrarlos por pantalla
figure, subplot(2,2,1), imshow(captura), 
subplot(2,2,2), imshow(cell2mat(Imagen{1})), 
subplot(2,2,3), imshow(cell2mat(Imagen{2})),
subplot(2,2,4), imshow(cell2mat(Imagen{3}));



