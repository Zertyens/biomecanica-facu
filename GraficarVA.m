function GraficarVA(VA, Ciclo)
%% Graficación de reporte de múltiples velocidades angulares
% Calcular los índices ajustados
offset = Ciclo.PrimerFrame - Ciclo.AntesHS;

% Ajustar los índices de eventos
RHS1_idx = Ciclo.FrameRHS1 - offset;
RHS2_idx = Ciclo.FrameRHS2 - offset;
LHS1_idx = Ciclo.FrameLHS1 - offset;
LHS2_idx = Ciclo.FrameLHS2 - offset;
RTO_idx = Ciclo.FrameRTO - offset;
LTO_idx = Ciclo.FrameLTO - offset;

%% Extraer velocidades angulares de cada ciclo - MUSLO
ciclo_muslo_der = VA.musloD(RHS1_idx:RHS2_idx, :);  % Nx3: [wx, wy, wz]
ciclo_muslo_izq = VA.musloI(LHS1_idx:LHS2_idx, :);

%% Extraer velocidades angulares de cada ciclo - PIERNA
ciclo_pierna_der = VA.piernaD(RHS1_idx:RHS2_idx, :);
ciclo_pierna_izq = VA.piernaI(LHS1_idx:LHS2_idx, :);

%% Extraer velocidades angulares de cada ciclo - PIE
ciclo_pie_der = VA.pieD(RHS1_idx:RHS2_idx, :);
ciclo_pie_izq = VA.pieI(LHS1_idx:LHS2_idx, :);

%% Definir posiciones de líneas de referencia
x_RTO = round((RTO_idx - RHS1_idx) / size(ciclo_muslo_der, 1) * 100);
x_LTO = round((LTO_idx - LHS1_idx) / size(ciclo_muslo_izq, 1) * 100);

%% Generar gráfico con 3x3 subplots
figure('Position', [100, 100, 600, 400]);

%% FILA 1: MUSLO
% Subplot 1: Velocidad Angular Muslo X (versor i)
subplot(3,3,1);
plot(InterpolaA100Muestras(ciclo_muslo_der(:,1)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_muslo_izq(:,1)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_muslo_der(:,2)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_muslo_izq(:,2)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_muslo_der(:,3)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_muslo_izq(:,3)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_pierna_der(:,1)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pierna_izq(:,1)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_pierna_der(:,2)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pierna_izq(:,2)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_pierna_der(:,3)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pierna_izq(:,3)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_pie_der(:,1)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pie_izq(:,1)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_pie_der(:,2)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pie_izq(:,2)), 'r', 'LineWidth', 2);
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
plot(InterpolaA100Muestras(ciclo_pie_der(:,3)), 'g', 'LineWidth', 2);
hold on;
plot(InterpolaA100Muestras(ciclo_pie_izq(:,3)), 'r', 'LineWidth', 2);
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