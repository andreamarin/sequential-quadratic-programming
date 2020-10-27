% Optimizaci�n Num�rica
% ITAM
% Proyecto 2 - PCS
% Andrea Mar�n Alarc�n (158999), Andrea P�rez Vega (154467) 
% y Luis Felipe Landa Elizarralde (158228)


function [x,lambda,k] =  pcsglobal(fx,hx,x0)
% M�todo de Programaci�n Cuadr�tica Sucesiva con b�squeda lineal, usando la
% funci�n de m�rito L-1 y actualizaci�n de la hessiana con la f�rmula BFGS
% para el problema:
% Min f(x) s.a. h(x) = 0

% In:
% fx y hx = cadenas de caracteres con las funciones en Matlab de la
% funci�n objetivo y las restricciones del problema.
% x0 = valor inicial
% Out:
% x = aproximaci�n al m�nimo local
% lambda = multiplicador de Lagrange asociado a x
% k = n�mero de iteraciones realizadas

m = length(hx);
n = length(x0);
tol = 1e-05;
maxk = 100;
C1 = 1e-02;
C0 = 1;
lambdak = zeros(m,1);
Bk = eye(n);
xk = x0;
vk = zeros(2,1);

while norm(vk,2) >= tol && k <= maxk
    
    % Resolvemos el subproblema cuadr�tico
    
    % Escogemos Ck+1
    
    s
    % Calculamos alphak
    alphak = 1;
    phik = fx + Ck1*norm(xk,1)
    Dk = Dpk * phik; % Calcular Dpk
    aux = ; % Calcular aux
    while aux > phik
        alphak = alphak/2;
    end
    
    % Actualizamos
    xk1 = xk + alphak*pk;
    s = xk1 - xk;
    y = gradiente(fx,xk1) - gradiente(fx,xk);
    
    % Actualizaci�n con Powell
    
    % Actualizamos valores
    xk = xk1;
    lambdak = lambdak1;
    Bk = Bk1;
    k = k + 1;
    
    %Calculamos vk
    vk = [gradiente(fx,xk), hk];   
    
    
end   

end