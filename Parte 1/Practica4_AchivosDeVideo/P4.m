clear all, clc;
%% PRACTICA 4 
% Grabar un video a 10fps de 15segundos que muestre sobre las imágenes a color
% capturadas por  una  webcam 
% un cuadrado  3x3 rojo que  se  mueva  de  forma aleatoria
% (en cada imagen, se establecerá de forma aleatoria la posición central del cuadrado utilizando la función de Matlab rand).

% Configuración dispositivo de captura
video=videoinput('winvideo',1,'RGB24_640x480'); % 30 fps
video.ReturnedColorSpace = 'rgb';

Resolucion = video.videoResolution;
NumFilas = Resolucion(2);
NumColumnas = Resolucion(1);

% Forma de trabajo: grabación continua
video.TriggerRepeat=Inf;
video.FrameGrabInterval=3; %30/3=10fps 

% Configuración video de salida
outvideo = VideoWriter('P4_video.avi');
outvideo.FrameRate = 10; %10 fps video de salida


open(outvideo);
start(video);
while(video.FramesAcquired < 150)
    I=getdata(video,1); % Obtenemos el frame capturado
    
    % Generamos la posicion del pixel central aleatoria
    fila = randi([1 NumFilas]);
    col = randi([1 NumColumnas]);
    
    % Pintamos el cuadrado 3x3 rojo
    for i=fila-1:fila+1
        for j=col-1:col+1
            I(i,j,1) = 255;
            I(i,j,2) = 0;
            I(i,j,3) = 0;
        end
    end
    
    writeVideo(outvideo, I);
    
end

stop(video);
close(outvideo);