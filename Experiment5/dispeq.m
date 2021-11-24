function [L,k,C,Cg,n]=dispeq(T,h)

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ecuación de la dispersión
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clase IAyC
% Septiembre 30, 2010

% Input: T = periodo
%        h =  profundidad

% Output: L = longitud de onda
%         k = número de onda 2pi/L
%         C = celeridad de fase
%         Cg = celeridad de grupo
%         n => Cg = nC


% clear all, close all, clc

% Constantes y valores iniciales

g = 9.81;
% T = 10;
% h = 3;

Lo = (g.*T.^2)./(2*pi);
sigma = (2.*pi)./T;

tol = 1e-6;

%%%%%%%%%%%%%%% INCREMENTOS DE L %%%%%%%%%%%%%%%%%

% L = 1e-3;
% f = 100;
% inc = 1e-3;
% 
% i=1;
% while f > 1e-3
%     L = L + inc;
%     f = Lo.*tanh((2.*pi.*h)./L)-L;
%     i = i+1;
% end
% 
% L1 = L
% iteraciones = i
% tolerancia = tol
% 
% %%%%%%%%%%%%%% FENTON & MC KEE %%%%%%%%%%%%%%%%%%%
% 
% L2 = Lo.*(tanh(((sigma.^2.*h)./g).^(3/4))).^(2/3)
% 
% 
%%%%%%%%%%% MÉTODO DE NEWTON-RAPHSON %%%%%%%%%%%%%
% i = 1;
L = Lo;
dif = 100;

while dif > tol
    Fx = L - Lo.*tanh((2.*pi.*h)./L);
    dFx = 1 + Lo.*(2.*pi.*h)./L.^2 .* sech((2.*pi.*h)./L).^2;
    L3 = L - Fx./dFx;
    dif = abs(L3-L);
    L = L3;
%     i = i + 1;
end

% iteraciones = i
% tolerancia = tol

k = (2.*pi)./L;
C = L./T;
n =0.5.*(1+((2.*k.*h)./sinh(2.*k.*h)));
Cg = n .* C;

