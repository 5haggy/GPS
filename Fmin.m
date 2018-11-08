%FUNKCJA fmin.m
%   działanie: tworzy funkcję do minimalizacji
%   argumenty: x y z , dane satelit (xsat,ysat,zsat,dsat)
%   zwraca:    funkcję do minimalizacji

function [wsp Jac]= Fmin(xsat,ysat,zsat,dsat,J,x0,y0,z0)
    syms x y z;
   % i= 1:5;
    wsp = (dsat.^2 - ( (x0 - xsat).^2 + (y0 - ysat).^2 + (z0 - zsat).^2 ) );
    %if nargout > 1
    Jac = double(subs(J,{x,y,z},{xsat,ysat,zsat}));
    %end
end
