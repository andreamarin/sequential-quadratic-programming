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


m = length(feval(hx, x0));
n = length(x0);

% Par�metros
tol = 1e-05;
maxk = 100;
C1 = 1e-02;
C0 = 1;

% Valores iniciales
lambdak = zeros(m,1);
Bk = eye(n);
xk = x0;
k=1;
vk = vertcat(gradiente(fx,xk) + jacobiana(hx,xk)'*lambdak,feval(hx,xk));

while norm(vk,2) >= tol && k <= maxk
    
    % Resolvemos el subproblema cuadr�tico
    fk = feval(fx,xk);
    gradfk = gradiente(fx,xk);
    Ak = jacobiana(hx,xk);
    hk = feval(hx,xk);
    
    [pk,~,~,~,lambdak1] = quadprog(Bk, gradfk, [],[], Ak,-hk);
    
    lambdak1 = lambdak1.eqlin;
    
    % Escogemos Ck+1 tal que Dpkphi(xk,Ck+1)<0
    C = gradfk'*pk/norm(hk,1);
    
    if C < 0
        C = -1*C;
    end
    
    C = C + 1;
    
    % Calculamos alphak
    alphak = 1;
    phik = fk + C*norm(hk,1);
    Dk = gradfk'*pk - C*norm(hk,1); % Calcular Dpk
    aux = feval(fx,xk+alphak*pk) + C*norm(feval(hx,xk+alphak*pk),1);
    
    while  aux > phik + alphak*C1*Dk
        alphak = alphak/2;
        aux = feval(fx,xk+alphak*pk) + C*norm(feval(hx,xk+alphak*pk),1);
    end
    
    % Actualizamos xk+1, sk y yk 
    xk1 = xk + alphak*pk;
    sk = xk1 - xk;
    
      % Usamos la forma cerrada del gradiente de la funci�n lagrangiana
    yk = gradiente(fx,xk1) + jacobiana(hx,xk1)'*lambdak1 - gradiente(fx,xk) - jacobiana(hx,xk)'*lambdak1;
    
    % Actualizaci�n de Bk+1 de acuerdo al esquema BFGS con esquema de Powell
    
    aux = sk'*Bk*sk;
 
    if (sk'*yk > 0.2*aux)
        r = yk;
    else 
        theta = (0.8*aux)/(aux - sk'*yk);
        r = theta*yk + (1 - theta)*Bk*sk;
    end
    
    Bk = Bk - ((Bk*sk*sk'*Bk)/aux) + (r*r')/(sk'*r);
 
    %Corregimos el error en caso que Bk sea singular
    if(rcond(Bk) < 1e-04) 
        Bk = eye(n);
    end
    
    % Actualizamos valores
    xk = xk1;
    lambdak = lambdak1;
    k = k + 1;
    
    %Calculamos vk
    vk = vertcat(gradiente(fx,xk) + jacobiana(hx,xk)'*lambdak,feval(hx,xk));   
    
    
end   

x = xk;
lambda = lambdak;

end