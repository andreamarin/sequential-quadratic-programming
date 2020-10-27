%Optimización Numérica
%06 de octubre de 2020
%ITAM

function [x, lambda, kiter] = pcspowell(fx,hx,x0)
% Método de Programación Cuadrática Sucesiva con actualización de Powell
% para el problema:
%  Min x s.a hx = 0

% fx: R^n --> R, hx: R^n --> R^m, ambas son 2 veces continuamente
% diferenciables.

% In:
%  fx: cadena de caracteres con la función objetivo en Matlab.
%  hx: cadena de caracteres con la función de restricciones.
%  x0: vector inicial de dimensión n.

% Out:
%  x: aproximación al mínimo local del problema.
%  lambda: multiplicador de Lagrange de la restricción hx = 0.
%  kiter: número de iteraciones.

% Funciones que se necesitan:
%  gradiente.m: calcula el gradiente de fx en un punto R^n
%  jacobiana.m: calcula la matriz jacobiana de hx en cualquier punto de R^n,
%  matrixz jacobiana es mxn, donde m es el numero de restricciones

% Actualización de Powell para 1 matriz Hessiana del Lagrangeano

tol = 1e-05; 
maxiter = 25;
kiter = 0;

n = length(x0); %dimensión de la variable
h = feval(hx, x0); 
m =  length(h); %número de restricciones

lambda = zeros(m,1); %multiplicador de Lagrange original
B = eye(n);

%CNPO

gf = gradiente(fx,x0);
jh = jacobiana(hx,x0);
vcnpo = [gf + jh'*lambda; h];

x = x0;

%Iteración

while(norm(vcnpo) > tol && kiter < maxiter) 
 % Resolver el subproblema cuadrático de igualdad  
 K = [B jh'; jh zeros(m)];
 ld = - [gf;h];
 d = K\ld;
 px = d(1:n);
 
 % Actualizar
 
 xn = x+ px; %nuevo punto
 lambda = d(n+1: n+m); %nuevo multiplicador de Lagrange
 
 % Calcular la nueva matriz B
 s = xn - x;
 gfn = gradiente(fx,xn);
 jhn = jacobiana(hx,xn);
 lag1 = gf + jh'*lambda;
 lag2 = gfn + jhn'*lambda;
 y = lag2 - lag1;
 aux = s'*B*s;
 
 if (s'*y >= 0.2*aux)
     r = y;
 else %actualizar el vector r
     theta = (0.2*aux - s'*y)/(aux - s'*y);
     r = theta*B*s + (1 - theta)*y;
 end
 
 B = B - ((B*s*s'*B)/aux) + (r*r')/(s'*r);
 
 %Corregir el error de matrices singulares
 if(rcond(B) < 1e-04) 
     B = eye(n);
 end
 
 % CNPO para xn 
 x = xn;
 gf = gradiente(fx, x);
 jh = jacobiana(hx,x);
 vcnpo = [gf + jh'*lambda; h];
 
 kiter = kiter +1;
 
 disp(sprintf('%2.0f %2.8f', kiter, norm(vcnpo), norm(px)))

end

end