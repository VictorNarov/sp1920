% Recibe datos filtrados de las clases de interes y los descriptores de
% interes (22)
% Devuelve los 3 mejores descriptores para separar las clases
function [espacioCcas, JespacioCcas]=funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI)

%% Cuantificación individual de características:

J = zeros(1,22); % Valor de separabilidad de cada descriptor

for i=1:22
   inputs = XoI(:, i)';
   outputs = YoI';
   J(1,i) = indiceJ(inputs,outputs);
    
end

%% Utiliza  los  valores  de  J  para  ordenar  el  conjunto  de  características  de  mayor  a  menor 
% importancia de acuerdo a este criterio de evaluación individual de características. 

[JespacioCcas_ordenado, espacioCcas_ordenado] = sort(J,'descend');

%% 2.Pre-selección  de  características:  de  las  22 características,  selecciona  las  9más  relevantes 

JespacioCcas_interes = JespacioCcas_ordenado(1:numDescriptoresOI);
espacioCcas_interes = espacioCcas_ordenado(1:numDescriptoresOI);

%% Combinatoria para encontrar los 3 mejores descriptores de forma conjunta

combinaciones = combnk(espacioCcas_interes,3);
num_combinaciones = length(combinaciones);

J_combinaciones = zeros(num_combinaciones, 1);
 
for i=1:num_combinaciones
   inputs = XoI(:, combinaciones(i,:))';
   outputs = YoI';
   J_combinaciones(i,1) = indiceJ(inputs,outputs);
end

[JespacioCcas, indice_min_combinacion] = max(J_combinaciones);
espacioCcas = combinaciones(indice_min_combinacion,:);


end

