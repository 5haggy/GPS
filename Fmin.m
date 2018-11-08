%FUNKCJA fmin.m
%   dzia³anie: tworzy funkcjê do minimalizacji
%   argumenty: x y z , dane satelit (xsat,ysat,zsat,dsat)
%   zwraca:    funkcjê do minimalizacji

function [wsp Jac]= Fmin(xsat,ysat,zsat,dsat,x,y,z)
    syms x y z;

    wsp = (dsat.^2 - ( (x - xsat).^2 + (y - ysat).^2 + (z - zsat).^2 )' );
    if nargout > 1
        Jac = double(subs(J,{x,y,z},{xsat,ysat,zsat}));
    end
end