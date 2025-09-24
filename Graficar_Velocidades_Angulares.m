function Graficar_Velocidades_Angulares(VA, Ciclo)
%% Graficación de reporte de múltiples velocidades angulares
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

%% Extraer velocidades angulares de cada ciclo - MUSLO
ciclo_muslo_wx_der = VA.musloD.wx(RHS1_idx:RHS2_idx);
ciclo_muslo_wx_izq = VA.musloI.wx(LHS1_idx:LHS2_idx);
ciclo_muslo_wy_der = VA.musloD.wy(RHS1_idx:RHS2_idx);
ciclo_muslo_wy_izq = VA.musloI.wy(LHS1_idx:LHS2_idx);
ciclo_muslo_wz_der = VA.musloD.wz(RHS1_idx:RHS2_idx);
ciclo_muslo_wz_izq = VA.musloI.wz(LHS1_idx:LHS2_idx);

%% Extraer velocidades angulares de cada ciclo - PIERNA
ciclo_pierna_wx_der = VA.piernaD.wx(RHS1_idx:RHS2_idx);
ciclo_pierna_wx_izq = VA.piernaI.wx(LHS1_idx:LHS2_idx);
ciclo_pierna_wy_der = VA.piernaD.wy(RHS1_idx:RHS2_idx);
ciclo_pierna_wy_izq = VA.piernaI.wy(LHS1_idx:LHS2_idx);
ciclo_pierna_wz_der = VA.piernaD.wz(RHS1_idx:RHS2_idx);
ciclo_pierna_wz_izq = VA.piernaI.wz(LHS1_idx:LHS2_idx);

%% Extraer velocidades angulares de cada ciclo - PIE
ciclo_pie_wx_der = VA.pieD.wx(RHS1_idx:RHS2_idx);
ciclo_pie_wx_izq = VA.pieI.wx(LHS1_idx:LHS2_idx);
ciclo_pie_wy_der = VA.pieD.wy(RHS1_idx:RHS2_idx);
ciclo_pie_wy_izq = VA.pieI.wy(LHS1_idx:LHS2_idx);
ciclo_pie_wz_der = VA.pieD.wz(RHS1_idx:RHS2_idx);
ciclo_pie_wz_izq = VA.pieI.wz(LHS1_idx:LHS2_idx);

%% Definir posiciones de líneas de referencia
x_RTO = round((RTO_idx - RHS1_idx) / length(ciclo_muslo_wx_der) * 100);
x_LTO = round((LTO_idx - LHS1_idx) / length(ciclo_muslo_wx_izq) * 100);

%% Generar gráfico con 3x3 subplots
figure('Position', [100, 100, 600, 400]);

%% FILA 1: MUSLO
% Subplot 1: Velocidad Angular Muslo X (versor i)
subplot(3,3,1);
plot(InterpolaA100Muestras(ciclo_muslo_wx_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_muslo_wx_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Muslo eje x - versor i', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

% Subplot 2: Velocidad Angular Muslo Y (versor j)
subplot(3,3,2);
plot(InterpolaA100Muestras(ciclo_muslo_wy_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_muslo_wy_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Muslo eje y - versor j', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

% Subplot 3: Velocidad Angular Muslo Z (versor k)
subplot(3,3,3);
plot(InterpolaA100Muestras(ciclo_muslo_wz_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_muslo_wz_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Muslo eje z - versor k', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

%% FILA 2: PIERNA
% Subplot 4: Velocidad Angular Pierna X (versor i)
subplot(3,3,4);
plot(InterpolaA100Muestras(ciclo_pierna_wx_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pierna_wx_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Pierna eje x - versor i', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

% Subplot 5: Velocidad Angular Pierna Y (versor j)
subplot(3,3,5);
plot(InterpolaA100Muestras(ciclo_pierna_wy_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pierna_wy_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Pierna eje y - versor j', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

% Subplot 6: Velocidad Angular Pierna Z (versor k)
subplot(3,3,6);
plot(InterpolaA100Muestras(ciclo_pierna_wz_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pierna_wz_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Pierna eje z - versor k', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

%% FILA 3: PIE
% Subplot 7: Velocidad Angular Pie X (versor i)
subplot(3,3,7);
plot(InterpolaA100Muestras(ciclo_pie_wx_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pie_wx_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Pie eje x - versor i', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

% Subplot 8: Velocidad Angular Pie Y (versor j)
subplot(3,3,8);
plot(InterpolaA100Muestras(ciclo_pie_wy_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pie_wy_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Pie eje y - versor j', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

% Subplot 9: Velocidad Angular Pie Z (versor k)
subplot(3,3,9);
plot(InterpolaA100Muestras(ciclo_pie_wz_der), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pie_wz_izq), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
hold off;
title('Vel Ang Pie eje z - versor k', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('% CM');
ylabel('[°/s]');
grid on;
xlim([0 100]);

% Agregar título general
sgtitle('Análisis de Velocidades Angulares', 'FontSize', 14, 'FontWeight', 'bold');

end