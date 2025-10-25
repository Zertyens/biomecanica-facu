function GraficarMRP(M_anatomico, Ciclo, peso)
% Grafica los momentos musculares (anatómicos) normalizados por ciclo
% y peso corporal, en un formato 3x3 similar al reporte estándar.

%% 1. Calcular los índices de recorte
% (Lógica idéntica a tu GraficarVA)
offset = Ciclo.PrimerFrame - Ciclo.AntesHS;

% Ajustar los índices de eventos
RHS1_idx = Ciclo.FrameRHS1 - offset;
RHS2_idx = Ciclo.FrameRHS2 - offset;
LHS1_idx = Ciclo.FrameLHS1 - offset;
LHS2_idx = Ciclo.FrameLHS2 - offset;
RTO_idx = Ciclo.FrameRTO - offset;
LTO_idx = Ciclo.FrameLTO - offset;

%% 2. Extraer y Normalizar Momentos (por peso y ciclo)
% Dividimos por el 'peso' para obtener [Nm/Kg]

% CADERA
ciclo_cadera_der = M_anatomico.caderaD(RHS1_idx:RHS2_idx, :) / peso; % Nx3: [FlexExt, AbdAdd, Rot]
ciclo_cadera_izq = M_anatomico.caderaI(LHS1_idx:LHS2_idx, :) / peso;

% RODILLA
ciclo_rodilla_der = M_anatomico.rodillaD(RHS1_idx:RHS2_idx, :) / peso;
ciclo_rodilla_izq = M_anatomico.rodillaI(LHS1_idx:LHS2_idx, :) / peso;

% TOBILLO
ciclo_tobillo_der = M_anatomico.tobilloD(RHS1_idx:RHS2_idx, :) / peso;
ciclo_tobillo_izq = M_anatomico.tobilloI(LHS1_idx:LHS2_idx, :) / peso;

%% 3. Definir posiciones de líneas de referencia (% del ciclo)
% (Lógica idéntica a tu GraficarVA)
x_RTO = round((RTO_idx - RHS1_idx) / size(ciclo_cadera_der, 1) * 100);
x_LTO = round((LTO_idx - LHS1_idx) / size(ciclo_cadera_izq, 1) * 100);

%% 4. Generar gráfico con 3x3 subplots
figure('Position', [100, 100, 800, 600]); % Hice la figura un poco más grande

%% ================ FILA 1: CADERA ================

% Subplot 1: Cadera Flexión/Extensión
subplot(3,3,1);
plot(InterpolaA100Muestras(ciclo_cadera_der(:,1)), 'g', 'LineWidth', 2); % Col 1 = FlexExt
hold on;
plot(InterpolaA100Muestras(ciclo_cadera_izq(:,1)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Cadera', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Flex(-)/Ext(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 2: Cadera Abducción/Aducción
subplot(3,3,2);
plot(InterpolaA100Muestras(ciclo_cadera_der(:,2)), 'g', 'LineWidth', 2); % Col 2 = AbdAdd
hold on;
plot(InterpolaA100Muestras(ciclo_cadera_izq(:,2)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Cadera', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('ABD(-)/ADD(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 3: Cadera Rotación
subplot(3,3,3);
plot(InterpolaA100Muestras(ciclo_cadera_der(:,3)), 'g', 'LineWidth', 2); % Col 3 = Rot
hold on;
plot(InterpolaA100Muestras(ciclo_cadera_izq(:,3)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Cadera', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('RotExt(-)/RotInt(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

%% ================ FILA 2: RODILLA ================

% Subplot 4: Rodilla Flexión/Extensión
subplot(3,3,4);
plot(InterpolaA100Muestras(ciclo_rodilla_der(:,1)), 'g', 'LineWidth', 2); % Col 1 = FlexExt
hold on;
plot(InterpolaA100Muestras(ciclo_rodilla_izq(:,1)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Rodilla', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Ext(-)/Flex(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 5: Rodilla Abducción/Aducción
subplot(3,3,5);
plot(InterpolaA100Muestras(ciclo_rodilla_der(:,2)), 'g', 'LineWidth', 2); % Col 2 = AbdAdd
hold on;
plot(InterpolaA100Muestras(ciclo_rodilla_izq(:,2)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Rodilla', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('ABDopVal(-)/ADDopVar(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 6: Rodilla Rotación
subplot(3,3,6);
plot(InterpolaA100Muestras(ciclo_rodilla_der(:,3)), 'g', 'LineWidth', 2); % Col 3 = Rot
hold on;
plot(InterpolaA100Muestras(ciclo_rodilla_izq(:,3)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Rodilla', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('RotExt(-)/RotInt(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

%% ================ FILA 3: TOBILLO ================

% Subplot 7: Tobillo Flexión/Extensión
subplot(3,3,7);
plot(InterpolaA100Muestras(ciclo_tobillo_der(:,1)), 'g', 'LineWidth', 2); % Col 1 = FlexExt
hold on;
plot(InterpolaA100Muestras(ciclo_tobillo_izq(:,1)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Tobillo', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Flex(-)/Ext(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 8: Tobillo Abducción/Aducción
subplot(3,3,9);
plot(InterpolaA100Muestras(ciclo_tobillo_der(:,2)), 'g', 'LineWidth', 2); % Col 2 = AbdAdd
hold on;
plot(InterpolaA100Muestras(ciclo_tobillo_izq(:,2)), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Momentos Musculares Tobillo', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('ABDopExt(-)/ADDopInt(+) [Nm/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Agregar título general
sgtitle('Análisis de Momentos Musculares Anatómicos', 'FontSize', 14, 'FontWeight', 'bold');

end