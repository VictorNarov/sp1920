%% REPRESENTACIÓN Y ANÁLISIS CUALITATIVO INICIAL DEL CONJUNTO DE DATOS X-Y
%% ------------------------------------------------------------------------
clear all,clc,close all
%% --------------------------------------------------------------
%% CARGAR CONJUNTO DE DATOS Y VARIABLES DEL PROBLEMA
%% --------------------------------------------------------------
load conjunto_datos.mat
load nombresProblema.mat

[numMuestras, numDescriptores] = size(X);

%% --------------------------------------------------------------
%% REPRESENTAR LOS DATOS EN ESPACIOS DE CARACTERISTICAS DOS A DOS
%% --------------------------------------------------------------

% Cada gráfica en una ventana tipo figure. Utilizar la función:
for i=1:2:numDescriptores-1
    figure,funcion_representa_datos(X,Y, [i i+1], nombresProblema)

end


%% ---------------------------------------------------------------
%% REPRESENTACIÓN HISTOGRAMA Y DIAGRAMA DE CAJAS DE CADA DESCRIPTOR
%% ---------------------------------------------------------------

% Para cada descriptor, abrir dos ventanas tipo figure
% una para representar histogramas y otra para diagramas de caja

% En cada una de ellas se representan los datos del descriptor para las 
% distintas clases del problema en gráficas independientes
numClases = size(unique(Y),1);
numMuestras = size(X,1);
numDescriptores = size(X,2);
codifClases = unique(Y);
nombreDescriptores = nombresProblema.descriptores;
nombreClases = nombresProblema.clases;

% - Histogramas: tantas filas de gráficas como clases -
% subplot(numClases,1,i)
% - Diagramas de caja: tantas columnas de gráficas como clases -
%subplot(1,numClases,i)

% Ejemplo de programación

for j=1:numDescriptores-1
    
    % Valores máximo y mínimos para representar en la misma escala
    vMin = min(X(:,j)); 
    vMax = max(X(:,j));
    
    hFigure = figure; hold on
    bpFigure = figure; hold on
    
    for i=1:numClases
    
        Xij = X(Y==codifClases(i),j); % datos de la clase i del descriptor j 
        numDatosClase = size(Xij,1);

        figure(hFigure)
        subplot(numClases,1,i), hist(Xij),
        xlabel(nombreDescriptores{j})
        ylabel('Histograma')
        axis([ vMin vMax 0 numMuestras/4]) % inf para escala automática del eje y
        title(nombreClases{i})
        
        figure(bpFigure)
        subplot(1,numClases,i), boxplot(Xij)
        xlabel('Diagrama de Caja')
        ylabel(nombreDescriptores{j})
        axis([ 0 2 vMin vMax ])
        title(nombreClases{i})
    end
end


%% ---------------------------------------------------------------
%% OBTENER CONCLUSIONES DE LA EFICIENCIA DE CADA DESCRIPTOR - ANÁLISIS CUALITATIVO
%% ---------------------------------------------------------------

% Por cada descriptor, asignar una categoría según la siguiente escala:

% Escala de adecuación del descriptor: no adecuado, adecuado, muy adecuado 



