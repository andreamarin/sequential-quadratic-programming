% Optimización Numérica
% ITAM
% Proyecto 2 - PCS
% Andrea Marín Alarcón (158999), Andrea Pérez Vega (154467) 
% y Luis Felipe Landa Elizarralde (158228)


function [f] = fesfera(x)
% Función de repulsión para (n/3) puntos en la esfera unitaria de 
% dimensión tres.

% In:
% x: vector en donde se evalua f(x)

% Out:
% h: función f evaluada en x

x = vertcat([1;0;0],x); % u1 = (1,0,0)' es fijo.
n = length(x);
np = floor(n/3); % Número de puntos en la esfera
f = 0;           

for i = 1:np-1
   ui = x(3*(i-1)+1:3*i);         % Anclados en el punto ui.
   for j =i+1:np
        uj = x(3*(j-1)+1:3*j);      % Punto uj.
      f = f+(1/norm(ui-uj));    % La función crece en sumandos.
   end    
end

end
