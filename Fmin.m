%FUNKCJA fmin.m
%   dziaĹ‚anie: tworzy funkcjÄ™ do minimalizacji
%   argumenty: x y z , dane satelit (xsat,ysat,zsat,dsat)
%   zwraca:    funkcjÄ™ do minimalizacji

function [wsp Jac]= Fmin(xsat,ysat,zsat,dsat,J,x0,y0,z0)
    syms x y z;
   % i= 1:5;
    wsp = (dsat.^2 - ( (x0 - xsat).^2 + (y0 - ysat).^2 + (z0 - zsat).^2 ) );
    %if nargout > 1
    for n = 1:5
    Jac(n,1) = double(subs(J(n,1),{x},{xsat(n)}));
    Jac(n,2) = double(subs(J(n,2),{y},{ysat(n)}));
    Jac(n,3) = double(subs(J(n,3),{z},{zsat(n)}));
    end
end
