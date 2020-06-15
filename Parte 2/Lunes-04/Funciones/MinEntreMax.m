function [minimo, g1max, g2max] = MinEntreMax(h)
   % Suavizar histrograma ruidoso
%    h(1) = (h(1)+h(2))/2;  
%    h(256) = (h(255)+h(256))/2;
%    for i=2:255
%        h(i) = (h(i-1)+h(i)+h(i+1))/3;
%    end

  % Calcular maximo global
  [numPixMax, g1max] = max(h);
  
  % Calcular otro maximo, funcion de ponderacion
  valores2Max = zeros(256,1); 
  for g=1:256
      valores2Max(g) = ((g-g1max) ^2)*h(g);
  end

  [~, g2max] = max(valores2Max);
  
  % Descartar valores que no se encuentren entre los maximos
  if g1max < g2max % g1max esta a la izqda de g2max
      h(1:g1max) = numPixMax;
      h(g2max:256) = numPixMax;
    % Devolver numero de grises reales
      g1max = g1max-1;
      g2max = g2max-1;
  else
      h(1:g2max) = numPixMax;
      h(g1max:256) = numPixMax;
    % Devolver numero de grises reales EN ORDEN
      temp = g1max;
      g1max = g2max-1;
      g2max = temp-1;
  end

  minimo = min(h);
  
end