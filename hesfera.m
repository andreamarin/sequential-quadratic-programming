% Optimización Numérica
% ITAM
% Proyecto 2 - PCS
% Andrea Marín Alarcón (158999), Andrea Pérez Vega (154467) 
% y Luis Felipe Landa Elizarralde (158228)


function [h] = hesfera(x)
% Función de restricciones del problema de np puntos en la esfera unitaria
% de dimensión tres.

% In:
% x: vector en donde se evalua h(x)

% Out:
% h: restricción h evaluada en x

n = length(x);
np = floor(n/3); % Número de puntos en la esfera
h = zeros(np,1); 

for j = 1:np
    uj = x(3*(j-1)+1:3*j); % Punto uj.
    h(j) = uj'*uj-1; % Restricción uj'uj = 1
end
end