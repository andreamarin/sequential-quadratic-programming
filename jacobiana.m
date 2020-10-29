% Optimización Numérica
% ITAM
% Proyecto 2 - PCS
% Andrea Marín Alarcón (158999), Andrea Pérez Vega (154467) 
% y Luis Felipe Landa Elizarralde (158228)

function [jh] = jacobiana(hx,x0)
% Calcula la matriz jacobiana de hx: R^^ --> R^m

n = length(x0);
h = feval(hx,x0);
m = length(h);
ep = 1e-05;

jh = zeros(m,n);

for j = 1:n
    y = x0; 
    y(j) = y(j) + ep;
    hy = feval(hx,y);
    jh(:,j) = (hy-h)/ep;
end

end