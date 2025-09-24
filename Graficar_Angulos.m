function Graficar_Angulos(AA, Ciclo)
%% Graficación de reporte de múltiples ángulos
% Calcular los índices ajustados para tus arrays
% Los arrays empiezan en (PrimerFrame - AntesHS)
offset = Ciclo.PrimerFrame - Ciclo.AntesHS;

% Ajustar los índices de eventos para que coincidan con tus arrays
RHS1_idx = Ciclo.FrameRHS1 - offset;
RHS2_idx = Ciclo.FrameRHS2 - offset;
LHS1_idx = Ciclo.FrameLHS1 - offset;
LHS2_idx = Ciclo.FrameLHS2 - offset;
RTO_idx = Ciclo.FrameRTO - offset;
LTO_idx = Ciclo.FrameLTO - offset;

%% Extraer ángulos de cada ciclo - CADERA
ciclo_cadera_alpha_der = AA.a_R_HJC(RHS1_idx:RHS2_idx);
ciclo_cadera_alpha_izq = AA.a_L_HJC(LHS1_idx:LHS2_idx);
ciclo_cadera_beta_der = AA.b_R_HJC(RHS1_idx:RHS2_idx);
ciclo_cadera_beta_izq = AA.b_L_HJC(LHS1_idx:LHS2_idx);
ciclo_cadera_gamma_der = AA.g_R_HJC(RHS1_idx:RHS2_idx);
ciclo_cadera_gamma_izq = AA.g_L_HJC(LHS1_idx:LHS2_idx);

%% Extraer ángulos de cada ciclo - RODILLA
ciclo_rodilla_alpha_der = AA.a_R_KJC(RHS1_idx:RHS2_idx);
ciclo_rodilla_alpha_izq = AA.a_L_KJC(LHS1_idx:LHS2_idx);
ciclo_rodilla_beta_der = AA.b_R_KJC(RHS1_idx:RHS2_idx);
ciclo_rodilla_beta_izq = AA.b_L_KJC(LHS1_idx:LHS2_idx);
ciclo_rodilla_gamma_der = AA.g_R_KJC(RHS1_idx:RHS2_idx);
ciclo_rodilla_gamma_izq = AA.g_L_KJC(LHS1_idx:LHS2_idx);

%% Extraer ángulos de cada ciclo - TOBILLO
ciclo_tobillo_alpha_der = AA.a_R_AJC(RHS1_idx:RHS2_idx);
ciclo_tobillo_alpha_izq = AA.a_L_AJC(LHS1_idx:LHS2_idx);
ciclo_tobillo_beta_der = AA.b_R_AJC(RHS1_idx:RHS2_idx);
ciclo_tobillo_beta_izq = AA.b_L_AJC(LHS1_idx:LHS2_idx);
ciclo_tobillo_gamma_der = AA.g_R_AJC(RHS1_idx:RHS2_idx);
ciclo_tobillo_gamma_izq = AA.g_L_AJC(LHS1_idx:LHS2_idx);

%% Definir posiciones de líneas de referencia
x_RTO = round((RTO_idx - RHS1_idx) / length(ciclo_cadera_alpha_der) * 100);
x_LTO = round((LTO_idx - LHS1_idx) / length(ciclo_cadera_alpha_izq) * 100);

%% Generar gráfico con 3x3 subplots
figure('Position', [100, 100, 600, 400]);

%% FILA 1: CADERA
% Subplot 1: Ángulo de Cadera Alpha (Flexión/Extensión)
subplot(3,3,1);
plot(InterpolaA100Muestras(ciclo_cadera_alpha_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_cadera_alpha_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Cadera', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Flex(+)/Ext(-)');
grid on;
xlim([0 100]);

% Subplot 2: Ángulo de Cadera Beta (Abducción/Aducción)
subplot(3,3,2);
plot(InterpolaA100Muestras(ciclo_cadera_beta_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_cadera_beta_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Cadera', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Abd(+)/Add(-)');
grid on;
xlim([0 100]);

% Subplot 3: Ángulo de Cadera Gamma (Rotación)
subplot(3,3,3);
plot(InterpolaA100Muestras(ciclo_cadera_gamma_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_cadera_gamma_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Cadera', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Rotint(+)/Rotext(-)');
grid on;
xlim([0 100]);

%% FILA 2: RODILLA
% Subplot 4: Ángulo de Rodilla Alpha (Flexión/Extensión)
subplot(3,3,4);
plot(InterpolaA100Muestras(ciclo_rodilla_alpha_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_rodilla_alpha_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Rodilla', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Flex(+)/Ext(-)');
grid on;
xlim([0 100]);

% Subplot 5: Ángulo de Rodilla Beta (Abducción/Aducción)
subplot(3,3,5);
plot(InterpolaA100Muestras(ciclo_rodilla_beta_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_rodilla_beta_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Rodilla', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Abd(+)/Add(-)');
grid on;
xlim([0 100]);

% Subplot 6: Ángulo de Rodilla Gamma (Rotación)
subplot(3,3,6);
plot(InterpolaA100Muestras(ciclo_rodilla_gamma_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_rodilla_gamma_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Rodilla', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Rotint(+)/Rotext(-)');
grid on;
xlim([0 100]);

%% FILA 3: TOBILLO
% Subplot 7: Ángulo de Tobillo Alpha (Flexión/Extensión)
subplot(3,3,7);
plot(InterpolaA100Muestras(ciclo_tobillo_alpha_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_tobillo_alpha_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Tobillo', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Flex(+)/Ext(-)');
grid on;
xlim([0 100]);

% Subplot 8: Ángulo de Tobillo Beta (Inversión/Eversión)
subplot(3,3,8);
plot(InterpolaA100Muestras(ciclo_tobillo_gamma_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_tobillo_gamma_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Tobillo', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Inv(+)/Eve(-)');
grid on;
xlim([0 100]);

% Subplot 9: Ángulo de Tobillo Gamma (Rotación)
subplot(3,3,9);
plot(InterpolaA100Muestras(ciclo_tobillo_beta_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_tobillo_beta_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Ángulo de Tobillo', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('Abd(+)/Add(-)');
grid on;
xlim([0 100]);

% Agregar leyenda general
sgtitle('Análisis de Ángulos Articulares', 'FontSize', 14, 'FontWeight', 'bold');

end