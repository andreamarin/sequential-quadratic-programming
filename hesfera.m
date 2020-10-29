% Optimizaci�n Num�rica
% ITAM
% Proyecto 2 - PCS
% Andrea Mar�n Alarc�n (158999), Andrea P�rez Vega (154467) 
% y Luis Felipe Landa Elizarralde (158228)


function [h] = hesfera(x)
% Funci�n de restricciones del problema de np puntos en la esfera unitaria
% de dimensi�n tres.

% In:
% x: vector en donde se evalua h(x)

% Out:
% h: restricci�n h evaluada en x

n = length(x);
np = floor(n/3); % N�mero de puntos en la esfera
h = zeros(np,1); 

for j = 1:np
    uj = x(3*(j-1)+1:3*j); % Punto uj.
    h(j) = uj'*uj-1; % Restricci�n uj'uj = 1
end
end