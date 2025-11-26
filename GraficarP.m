function GraficarP(P, Ciclo, peso)
% Grafica las potencias musculares normalizadas por ciclo y peso corporal,
% en un formato 3x3 similar al reporte estándar.

%% 1. Calcular los índices de recorte
offset = Ciclo.PrimerFrame - Ciclo.AntesHS;

% Ajustar los índices de eventos
RHS1_idx = Ciclo.FrameRHS1 - offset;
RHS2_idx = Ciclo.FrameRHS2 - offset;
LHS1_idx = Ciclo.FrameLHS1 - offset;
LHS2_idx = Ciclo.FrameLHS2 - offset;
RTO_idx = Ciclo.FrameRTO - offset;
LTO_idx = Ciclo.FrameLTO - offset;

%% 2. Extraer y Normalizar Potencias (por peso y ciclo)
% Dividimos por el 'peso' para obtener [W/Kg]

% CADERA
ciclo_cadera_der_FE = P.Cadera_D_FlexExt(RHS1_idx:RHS2_idx) / peso;
ciclo_cadera_izq_FE = P.Cadera_I_FlexExt(LHS1_idx:LHS2_idx) / peso;

ciclo_cadera_der_AA = P.Cadera_D_AbdAdd(RHS1_idx:RHS2_idx) / peso;
ciclo_cadera_izq_AA = P.Cadera_I_AbdAdd(LHS1_idx:LHS2_idx) / peso;

ciclo_cadera_der_Rot = P.Cadera_D_Rot(RHS1_idx:RHS2_idx) / peso;
ciclo_cadera_izq_Rot = P.Cadera_I_Rot(LHS1_idx:LHS2_idx) / peso;

% RODILLA
ciclo_rodilla_der_FE = P.Rodilla_D_FlexExt(RHS1_idx:RHS2_idx) / peso;
ciclo_rodilla_izq_FE = P.Rodilla_I_FlexExt(LHS1_idx:LHS2_idx) / peso;

ciclo_rodilla_der_AA = P.Rodilla_D_AbdAdd(RHS1_idx:RHS2_idx) / peso;
ciclo_rodilla_izq_AA = P.Rodilla_I_AbdAdd(LHS1_idx:LHS2_idx) / peso;

ciclo_rodilla_der_Rot = P.Rodilla_D_Rot(RHS1_idx:RHS2_idx) / peso;
ciclo_rodilla_izq_Rot = P.Rodilla_I_Rot(LHS1_idx:LHS2_idx) / peso;

% TOBILLO
ciclo_tobillo_der_FE = P.Tobillo_D_FlexExt(RHS1_idx:RHS2_idx) / peso;
ciclo_tobillo_izq_FE = P.Tobillo_I_FlexExt(LHS1_idx:LHS2_idx) / peso;

ciclo_tobillo_der_AA = P.Tobillo_D_AbdAdd(RHS1_idx:RHS2_idx) / peso;
ciclo_tobillo_izq_AA = P.Tobillo_I_AbdAdd(LHS1_idx:LHS2_idx) / peso;

%% 3. Definir posiciones de líneas de referencia (% del ciclo)
x_RTO = round((RTO_idx - RHS1_idx) / length(ciclo_cadera_der_FE) * 100);
x_LTO = round((LTO_idx - LHS1_idx) / length(ciclo_cadera_izq_FE) * 100);

%% 4. Generar gráfico con 3x3 subplots
figure('Position', [100, 100, 900, 700]);

%% ================ FILA 1: CADERA ================

% Subplot 1: Cadera Flexión/Extensión
subplot(3,3,1);
plot(InterpolaA100Muestras(ciclo_cadera_der_FE), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_cadera_izq_FE), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Cadera Flex-Ext', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 2: Cadera Abducción/Aducción
subplot(3,3,2);
plot(InterpolaA100Muestras(ciclo_cadera_der_AA), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_cadera_izq_AA), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Cadera ABD-ADD', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 3: Cadera Rotación
subplot(3,3,3);
plot(InterpolaA100Muestras(ciclo_cadera_der_Rot), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_cadera_izq_Rot), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Cadera Rot Ext-Int', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

%% ================ FILA 2: RODILLA ================

% Subplot 4: Rodilla Flexión/Extensión
subplot(3,3,4);
plot(InterpolaA100Muestras(ciclo_rodilla_der_FE), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_rodilla_izq_FE), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Rodilla Flex-Ext', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 5: Rodilla Abducción/Aducción (Val-Var)
subplot(3,3,5);
plot(InterpolaA100Muestras(ciclo_rodilla_der_AA), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_rodilla_izq_AA), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Rodilla Val-Var', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 6: Rodilla Rotación
subplot(3,3,6);
plot(InterpolaA100Muestras(ciclo_rodilla_der_Rot), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_rodilla_izq_Rot), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Rodilla Rot Ext-Int', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

%% ================ FILA 3: TOBILLO ================

% Subplot 7: Tobillo Flexión/Extensión
subplot(3,3,7);
plot(InterpolaA100Muestras(ciclo_tobillo_der_FE), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_tobillo_izq_FE), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Tobillo Flex-Ext', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

% Subplot 8: VACÍO (sin gráfico)

% Subplot 9: Tobillo Abducción/Aducción (Proy Ext-Int)
subplot(3,3,9);
plot(InterpolaA100Muestras(ciclo_tobillo_der_AA), 'g', 'LineWidth', 2);
hold on;
yline(0, 'Color', 'k', 'LineWidth', 1.2);   % línea 0
plot(InterpolaA100Muestras(ciclo_tobillo_izq_AA), 'r', 'LineWidth', 2);
line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'g', 'LineWidth', 1.5);
line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 1.5);
hold off;
title('Potencia Muscular Tobillo Proy Ext-Int', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Gen(+)/Abs(-) [Watios/Kg]');
xlabel('% CM');
grid on;
xlim([0 100]);

%% Agregar título general
sgtitle('Análisis de Potencias Musculares', 'FontSize', 14, 'FontWeight', 'bold');

end