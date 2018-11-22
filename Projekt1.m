% AMO - projekt  nr 1 Zestaw nr 3,System Ă˘â‚¬ĹĄgeograficznyĂ˘â‚¬ĹĄ, 
% Autor Piotr Piekarski

clear; close; clc;

format long 
%zmienne do obliczen
szersat = ones(5,1);
dlugsat = ones(5,1);
%% DANE
% x 15491622.1106204
%   -15447549.64113038
c = 299792458; %predkosc swiatla w m/s
c_pow = 299702547; %predkosc swiatla w atmosferze ziemskiej

h_pm = 6378137; %poziom morza wyrazony w metrach 

szer = [52 52 19.2,
        50 18 43.4,
        47 47 48.9,
        50 37 10.5,
        55 29 17.8];

dlug = [13 23 53.9,
        12 22 24.1,
        19 22 54.7,
        26 14 39.3,
        28 47 15.1];

h_npm = 20000000*ones(5,1); %wysokosc satelit nad poziomem morza

%czas sygnalu w centysekundach
% tutaj mialem klopot z zaograglaniem malych liczb. Odpowiedni wspÄ‚Ĺ‚lczynnik
% korygujacy do sekund dodany do rÄ‚Ĺ‚wnania
t_syg = [6.688938036445544,
    6.6912444592128830,
    6.6771094354187960,
    6.6728335450119590,
    6.6862824833554710];
k_t=0.01;

%% 1 Uklad rownan okreslajacy po?o?enie w uk?adzie wspolrzednych kartezjanskich 
%Wykorzystano model sferyczny.
rsat=h_pm+h_npm;
szersat = szer(:,1)+ szer(:,2)/60 + szer(:,3)/3600; %N
dlugsat = dlug(:,1)+ dlug(:,2)/60 + dlug(:,3)/3600; %E

xsat = rsat.*cos(szersat).*cos(dlugsat);
ysat = rsat.*cos(szersat).*sin(dlugsat);
zsat = rsat.*sin(szersat);

%obliczenie odleglosci na podstawie czasu sygnaÄąâ€šu   
dsat = c*k_t*t_syg;

%Rownanie na podstawie danych
%(x-xsat)^2+(y-ysat)^2+(z-zsat)^2 = rsat^2 --> wektor 5 rownan
%szukane x ,y, z - polozenie celu

%% 2 Zadanie optymalizacji bez ograniczeÄąâ€ž stosujĂ„â€¦c metodĂ„â„˘ najmniejszych kwadratÄ‚Ĺ‚w
%wyliczanie Jakobianu
syms x y z
rownanie = rsat.^2 - (x-xsat).^2-(y-ysat).^2-(z-zsat).^2; 

J= jacobian(rownanie,[x y z]); %% obliczyc analitycznie !!!!
disp('Jakobian funkcji celu: '); disp(J);


%% 3. Wyznaczyc swoje polozenie
%METODA LEVENBERGA-MARQUARDTA

%syms x y z
%rsat.^2 - (x-xsat).^2-(y-ysat).^2-(z-zsat).^2;

% options = optimset('Algorithm','interior-point','Gradobj','on','MaxFunEvals',50000,...
% 'MaxIter',10000,'TolCon',1e-30,'TolFun',1e-30 ,'TolX',1e-40);

%options =  optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','MaxIter',30,'Display','iter','Jacobian','on');
%options = optimset('Algorithm','levenberg-marquardt')
options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','MaxIter',20,'Display','iter','Jacobian','on')



x0 = zeros(5,1); 
y0 = zeros(5,1); 
z0 = zeros(5,1); 
f=@(x,y,z)Fmin(xsat,ysat,zsat,dsat,J,x0,y0,z0)

%[output] = lsqnonlin((rsat.^2 - (x-xsat).^2-(y-ysat).^2-(z-zsat).^2),x0,[],[],options);
[X,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMBDA,JACOBIAN] = lsqnonlin(f,x0,[],[],options);


% function wsp = Fmin(x,y,z)
%     syms x y z;
% 
%     wsp = (dsat.^2 - ( (x - xsat).^2 + (y - ysat).^2 + (z - zsat).^2 )' );
%     if nargout > 1
%         Jac = double(subs(J,{x,y,z},{xsat,ysat,zsat}));
%     end
% end
% [wsp Jac] = Fmin(x,y,z)
% function [wsp Jac] = Fmin(x,y,z)
%     syms x y z;
%     
%     wsp = (dsat.^2 - ( (x - xsat).^2 + (y - ysat).^2 + (z - zsat).^2 )' );
%     if nargout > 1
%         Jac = double(subs(J,{x,y,z},{xsat,ysat,zsat}));
%     end
% end



%%smieci
% [52 52 19.2; 
%  50 18 43.4;
%  47 47 48.9;
%  50 37 10.5;
%  55 29 17.8]
% 
% [13 23 53.9;
%  12 22 24.1;
%  19 22 54.7;
%  26 14 39.3;
%  28 47 15.1]
