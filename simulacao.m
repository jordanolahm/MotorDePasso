% Estima ordem lambertiana
clear all; close all; clc;

%pkg load communications
%pkg load optim

% %% Constroi o modelo do ganho lambertiano
% Apd = 1;
% D = 1;
% Iled = 1;
% c = Iled* Apd/(2*pi*D^2); % Constante
% nL = 10; % Ordem lambertiana de teste
% alpha = 5; % Produto Sled*Rpd de teste
% phi = -90:0.1:90;         % Escursão do ângulo
% phi_r = phi.*pi./180;     % Converte em rad
% % phir = -pi/2:pi/180:pi/2 % em rad "direto"
% 
% 
% Ipd = alpha*c.*(nL + 1).*cos(phi_r).^nL;
% % Adiciona ruido gaussiano com média zero e desvio padrão 0.05 
% sigma = 0.005;
% sigma2 = 10*sigma;
% Ipd_n = Ipd + sqrt(sigma)*randn(size(Ipd));
% Ipd_n2 = Ipd + sqrt(sigma2)*randn(size(Ipd));

R = 470; 
phi = -90:5:90; % Escursão do ângulo
toto = 1.5;
phi = phi+toto;
phi_r = phi.*pi./180;     % Converte em rad

load background.mat;
background = tensao;

load whiteLed.mat
white_led = tensao; 

load ledAzul.mat
blue_led = tensao; 

load ledVerde.mat
green_led = tensao;

load ledVermelho.mat
Red_led = tensao;

Ipd_m = (white_led - background) / R;  
% Ipd_b = (blue_led - background) / R;  

Ipd_m = Ipd_m(3:end-2)
phi_r = phi_r(3:end-2)

plot(phi_r, Ipd_m);
% plot(phi, Ipd_b);
% Função o qual deve ser estimado o parâmetro nL
fun = @(x) x(2)*(x(1) + 1).*cos(phi_r).^x(1) - Ipd_m;
% fun = @(x) x(2)*(x(1) + 1).*cos(phi_r).^x(1) - Ipd_b;

%% Estimador NL-LS
%help lsqnonlin
opts = optimset ("Jacobian", "on")
x0 = [1 1]; % Ponto inicial de busca

% Primeiro plot
[x, jacobian] = lsqnonlin( fun, x0)
% Parâmetros estimados quem minimizam o erro quadrático
nL_hat = x(1);  
alpha_hat = x(2); 
% Ganho DC com o parâmetro nL_hat estimado 
Ipd_hat = alpha_hat.*(nL_hat + 1).*cos(phi_r).^nL_hat;

figure;
plot( phi_r,Ipd_m,'b', 'MarkerSize', 2); hold on;
% plot( phi_r,Ipd_b,'b', 'MarkerSize', 2); hold on;
plot( phi_r, Ipd_hat,'k', 'LineWidth', 2);
set(gca,'FontSize', 11, 'FontName', 'Times New Roman');
legend('Dados','Ajuste NL-LS','Curva exata','fontsize',12, 'FontName', 'Times New Roman');
%xlabel('$\phi$    [rad]','fontsize',13,'interpreter','latex'); 
ylabel('$I_{PD}(\phi)$','fontsize',13,'interpreter','latex'); 
grid on; 
% xlim([-1.6 1.6]); ylim([-1 10]);

