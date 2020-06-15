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


%% EJERCICIO 3
% La  escena inicialmente oscurecida y  aclarándose progresivamente

% Configuración dispositivo de captura
video=videoinput('winvideo',1,'YUY2_640x360'); % 30 fps
video.ReturnedColorSpace = 'grayscale';

% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FrameGrabInterval=1; %30/6=5fps 

preview(video)

% Capturamos 50 frames (10s)
start(video);
umbral=0:255;

for i=1:length(umbral)
    
    I=getdata(video,1);
    Ib=(I>umbral(i));
    
    imshow(Ib);

end

stop(video);

%% EJERCICIO 4
% Todos los  píxeles  que  tengan una  intensidad  mayor que  un  determinado  umbral.
% Asignar inicialmente el valor 0 a este umbral e ir aumentándolo progresivamente.

% Configuración dispositivo de captura
video=videoinput('winvideo',1,'YUY2_640x360'); % 30 fps
video.ReturnedColorSpace = 'rgb';

% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FramesPerTrigger=1; % 2 frames por disparo
video.FrameGrabInterval=6; %30/6=5fps 

preview(video)

% Capturamos 50 frames (10s)
start(video);

umbral=0;
while(video.FramesAcquired < 50)
    
    I=getdata(video,1);
    R = double(I(:,:,1));
    G = double(I(:,:,2));
    B = double(I(:,:,3));

    Intensidad = uint8((R+G+B) / 3);
    
    imshow(Intensidad>umbral);

    umbral = umbral+5;

end

stop(video);

%% EJERCICIO 5
% Las diferencias que se producen entre los distintos frames 
% que captura la webcam(utilizar la instrucción imabsdiff).

% Configuración dispositivo de captura
video=videoinput('winvideo',1,'YUY2_640x360'); % 30 fps
video.ReturnedColorSpace = 'rgb';

% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FramesPerTrigger=1; % 2 frames por disparo
video.FrameGrabInterval=6; %30/6=5fps 

preview(video)

% Capturamos 50 frames (10s)
start(video);

diferencia = uint8(zeros(360,640));

while(video.FramesAcquired < 50)
    
    I=getdata(video,1);
    Ig = rgb2gray(I);
    diferencia = imabsdiff(Ig, diferencia);
    
    imshow(diferencia);

end

stop(video);


%% EJERCICIO 6
% El movimiento más significativo a partir de diferencias de imágenes de intensidad..

% Configuración dispositivo de captura
video=videoinput('winvideo',1,'YUY2_640x360'); % 30 fps
video.ReturnedColorSpace = 'grayscale';

% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FramesPerTrigger=1; % 2 frames por disparo
video.FrameGrabInterval=2; %30/2=15fps 

preview(video)

umbral = 100;
diferencia = uint8(zeros(360,640));

% Capturamos 150 frames (10s)
start(video);

frame_ant = getdata(video,1); %Inicializamos el frame

while(video.FramesAcquired < 150)
    
    frame=getdata(video,1);
    diferencia = imabsdiff(frame, frame_ant);
    
    movimiento = (diferencia > umbral);
    
    imshow(movimiento);

    frame_ant = frame;
end

stop(video);

%% 7.  El   seguimiento   del   movimiento   del   objeto   mayor   detectado 
% en   las   diferencias significativas de  imágenes  de  intensidad.
% El  seguimiento  debe  visualizarse  a  través  de  un punto rojo situado en el centroide del objeto.


% Configuración dispositivo de captura
video=videoinput('winvideo',1,'RGB24_640x480'); % 30 fps
video.ReturnedColorSpace = 'grayscale';
preview(video);
% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;

video.FrameGrabInterval=2; %30/2=15fps 

umbral = 100;
diferencia = uint8(zeros(360,640));

% Capturamos 150 frames (10s)
start(video);

frame_ant = getdata(video,1); %Inicializamos el frame

while(video.FramesAcquired < 300)
    
    frame=getdata(video,1);
    diferencia = imabsdiff(frame, frame_ant);
    
    movimiento = (diferencia > umbral); % Matriz binaria
    
    %Obtenemos sus objetos etiquetados y las propiedades
    [IEtiq, N] = bwlabel(movimiento);
    
    if N>0 % Hay algun movimiento
        stats = regionprops(IEtiq, 'Area', 'Centroid');
        centroides = cat(1,stats.Centroid);
        areas = cat(1,stats.Area);

        mayor_objeto = find(areas==max(areas)); % Indice

        centroide_mayor_x = centroides(mayor_objeto,1); 
        centroide_mayor_y = centroides(mayor_objeto,2); 
    
    else
        centroide_mayor_x=1;
        centroide_mayor_y=1;
    end
    
    frame_ant=frame;
    
    subplot(1,2,1), imshow(frame); hold on, plot(centroide_mayor_x, centroide_mayor_y, 'R*'), hold off;
    subplot(1,2,2), imshow(movimiento); hold on, plot(centroide_mayor_x, centroide_mayor_y, 'R*'), hold off;
    
   
end

stop(video);




