% Optimización Numérica
% ITAM
% Proyecto 2 - PCS
% Andrea Marín Alarcón (158999), Andrea Pérez Vega (154467) 
% y Luis Felipe Landa Elizarralde (158228)

close all

sphere(50)
axis equal
hold on

np = 20; % Consideramos np = 20, ya que u1 = (1,0,0)' es fijo. Al unirlos, np = 21.

x0 = randn(3*np,1);
[x, lambda, k] = pcsglobal('fesfera','hesfera',x0);


x = vertcat([1;0;0], x); % Resulta np = 21

% Gráfica de los np + 1 puntos en la esfera unitaria.

for j = 1:np+1
    P = x(3*(j-1)+1:3*j);
    plot3(P(1), P(2), P(3),'rd','Linewidth',3)
    hold on
end
