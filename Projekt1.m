% AMO - projekt  nr 1 Zestaw nr 3,System ”geograficzny”, 
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
% tutaj mialem klopot z zaograglaniem malych liczb. Odpowiedni wspólczynnik
% korygujacy do sekund dodany do równania
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

%obliczenie odleglosci na podstawie czasu sygnału   
dsat = c*k_t*t_syg;

%Rownanie na podstawie danych
%(x-xsat)^2+(y-ysat)^2+(z-zsat)^2 = rsat^2 --> wektor 5 rownan
%szukane x ,y, z - polozenie celu

%% 2 Zadanie optymalizacji bez ograniczeń stosując metodę najmniejszych kwadratów
%wyliczanie Jakobianu
syms x y z
rownanie = rsat.^2 - (x-xsat).^2-(y-ysat).^2-(z-zsat).^2; 

J= jacobian(rownanie,[x y z]);
disp('Jakobian funkcji celu: '); disp(J);


%% 3. Wyznaczyc swoje polozenie
%METODA LEVENBERGA-MARQUARDTA

%syms x y z
%rsat.^2 - (x-xsat).^2-(y-ysat).^2-(z-zsat).^2;

options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','MaxIter',30,'Display','iter','Jacobian','on');
x0 = [0;0;0]; 
%[output] = lsqnonlin((rsat.^2 - (x-xsat).^2-(y-ysat).^2-(z-zsat).^2),x0,[],[],options);
[output] = lsqnonlin(@Fmin,x0,[],[],options);





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
