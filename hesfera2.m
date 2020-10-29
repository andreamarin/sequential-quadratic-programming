function [g,h] = hesfera2(x)
% Función de restricciones del problema de np puntos en la esfera unitaria
% de dimensión tres.
%
% Optimización Numérica
% ITAM
% Proyecto 2 - PCS
% Andrea Marín Alarcón (158999), Andrea Pérez Vega (154467) 
% y Luis Felipe Landa Elizarralde (158228)

g =[];     % uso de fmincon.m en Matlab

n = length(x);
np = floor(n/3);
h = zeros(np,1);
for j = 1:np
    uj = x(3*(j-1)+1:3*j);
    h(j) = uj'*uj-1;
end
end