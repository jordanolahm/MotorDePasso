% Estima ordem lambertiana
clear all; close all; clc;
%definicao das variaveis
R = 470; 
phi = -90:5:90; % Escursão do ângulo
toto = 2.3;
phi = phi+toto;
phi_r = phi.*pi./180;     % Converte em rad

load background.mat;
background = tensao;

load ledBranco_60.mat
white_led_60 = tensao; 

%Com lente
Ipd_l60 = (white_led_60 - background) / R; 
 
%recorte lateral do plot
Ipd_l60 = Ipd_l60(3:end-2);
phi_r = phi_r(3:end-2);

% Função o qual deve ser estimado o parâmetro nL
fun = @(x) x(2)*(x(1) + 1).*cos(phi_r).^x(1) - Ipd_l60;
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

save param_60 Ipd_hat Ipd_l60;

%calculando RMSE - Root Mean square Error
mse = sum((Ipd_l60 - Ipd_hat).^2)/length(Ipd_l60);
rmse = sqrt(mse)

figure;
plot( phi_r,Ipd_l60,'r', 'LineWidth', 1); hold on;
% plot( phi_r,Ipd_b,'b', 'MarkerSize', 2); hold on;
plot( phi_r, Ipd_hat,'b', 'LineWidth', 1);
set(gca,'FontSize', 11, 'FontName', 'Times New Roman');
legend('Medido','Estimado','Curva exata','fontsize',12, 'FontName', 'Times New Roman');
%xlabel('$\phi$    [rad]','fontsize',13,'interpreter','latex'); 
ylabel('$I_{PD}$','fontsize',12,'interpreter','latex');
xlabel('$\phi\,\,\,[rad]$', 'fontsize',12,'interpreter','latex')
grid on; 
% xlim([-1.6 1.6]); ylim([-1 10]);

