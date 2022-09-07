clear all; 
close all; 

phi = -90:5:90; % Escursão do ângulo
phi_r = phi.*pi./180;     % Converte em rad
phi_r = phi_r(3:end-2);

load param_60.mat;
Ipd_hat_60 = Ipd_hat; 
load param_45.mat;
Ipd_hat_45 = Ipd_hat; 
load param_30.mat;
Ipd_hat_30 = Ipd_hat; 
load param_15.mat;
Ipd_hat_15 = Ipd_hat; 
load param_m.mat;
Ipd_hat_m = Ipd_hat; 

erro_m = Ipd_m - Ipd_hat_m;
abs_erro_m = abs(erro_m);


erro_60 = Ipd_l60 - Ipd_hat_60; 
abs_erro_60 = abs(erro_60);
subplot(4,1,1);
plot(phi_r, abs_erro_60); hold on; 
plot(phi_r,abs_erro_m); hold on; 

erro_45 = Ipd_l45 - Ipd_hat_45;
abs_erro_45 = abs(erro_45);
subplot(4,1,2);
plot(phi_r,abs_erro_45); hold on; 
plot(phi_r,abs_erro_m); hold on; 

erro_30 = Ipd_l30 - Ipd_hat_30;
abs_erro_30 = abs(erro_30);
subplot(4,1,3);
plot(phi_r,abs_erro_30); hold on; 
plot(phi_r,abs_erro_m); hold on; 

erro_15 = Ipd_l15 - Ipd_hat_15;
abs_erro_15 = abs(erro_15);
subplot(4,1,4);
plot(phi_r,abs_erro_15); hold on; 
plot(phi_r,abs_erro_m); hold on; 

