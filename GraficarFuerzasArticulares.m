function GraficarFuerzasArticulares(FA, SL, Datos, Ciclo)
    % GraficarFuerzasArticulares - Grafica fuerzas articulares en ejes anatómicos
    % normalizadas por peso corporal vs % ciclo de marcha
    %
    % Inputs:
    %   FA     - Estructura con fuerzas articulares en coordenadas globales
    %   SL     - Estructura con sistemas locales (vectores unitarios i, j, k)
    %   Datos  - Estructura con datos antropométricos
    %   Ciclo  - Estructura con información de eventos de marcha
    
    %% Parámetros
    peso = Datos.antropometria.PESO.Valor; % kg
    g = 9.81; % m/s^2
    peso_N = peso * g; % Peso en Newtons
    
    %% Calcular ejes flotantes (floating axes)
    % Según Apéndice B, ecuaciones B.98-B.103, B.114-B.119, B.130-B.135
    
    % Eje tobillo derecho: perpendicular a i5 y k3
    l_R_Ankle = calcularEjeFlotante(SL.i5, SL.k3);
    
    % Eje flotante rodilla derecha: perpendicular a i3 y k1
    l_R_Knee = calcularEjeFlotante(SL.i3, SL.k1);
    
    % Eje flotante cadera derecha: perpendicular a i1 y k_pelv
    l_R_Hip = calcularEjeFlotante(SL.i1, SL.k_pelv);
    
    % Eje tobillo izquierdo: perpendicular a i6 y k4
    l_L_Ankle = calcularEjeFlotante(SL.i6, SL.k4);
    
    % Eje rodilla izquierda: perpendicular a i4 y k2
    l_L_Knee = calcularEjeFlotante(SL.i4, SL.k2);
    
    % Eje cadera izquierda: perpendicular a i2 y k_pelv
    l_L_Hip = calcularEjeFlotante(SL.i2, SL.k_pelv);
    
    %% Transformar fuerzas a coordenadas anatómicas
    
    % TOBILLO DERECHO
    F_R_Ankle_PrxDis = proyectarVector(FA.F_TobilloDerecho, SL.i5);
    F_R_Ankle_MedLat = proyectarVector(FA.F_TobilloDerecho, SL.k3);
    F_R_Ankle_AntPos = -proyectarVector(FA.F_TobilloDerecho, l_R_Ankle);
    
    % RODILLA DERECHA
    F_R_Knee_PrxDis = proyectarVector(FA.F_RodillaDerecha, SL.i3);
    F_R_Knee_MedLat = proyectarVector(FA.F_RodillaDerecha, SL.k1);
    F_R_Knee_AntPos = -proyectarVector(FA.F_RodillaDerecha, l_R_Knee);
    
    % CADERA DERECHA
    F_R_Hip_PrxDis = proyectarVector(FA.F_CaderaDerecha, SL.i1);
    F_R_Hip_MedLat = proyectarVector(FA.F_CaderaDerecha, SL.k_pelv);
    F_R_Hip_AntPos = -proyectarVector(FA.F_CaderaDerecha, l_R_Hip);
    
    % TOBILLO IZQUIERDO (notar el signo negativo en MedLat, ec. B.149)
    F_L_Ankle_PrxDis = proyectarVector(FA.F_TobilloIzquierdo, SL.i6);
    F_L_Ankle_MedLat = -proyectarVector(FA.F_TobilloIzquierdo, SL.k4);
    F_L_Ankle_AntPos = -proyectarVector(FA.F_TobilloIzquierdo, l_L_Ankle);
    
    % RODILLA IZQUIERDA (notar el signo negativo en MedLat, ec. B.165)
    F_L_Knee_PrxDis = proyectarVector(FA.F_RodillaIzquierda, SL.i4);
    F_L_Knee_MedLat = -proyectarVector(FA.F_RodillaIzquierda, SL.k2);
    F_L_Knee_AntPos = -proyectarVector(FA.F_RodillaIzquierda, l_L_Knee);
    
    % CADERA IZQUIERDA (notar el signo negativo en MedLat, ec. B.181)
    F_L_Hip_PrxDis = proyectarVector(FA.F_CaderaIzquierda, SL.i2);
    F_L_Hip_MedLat = -proyectarVector(FA.F_CaderaIzquierda, SL.k_pelv);
    F_L_Hip_AntPos = -proyectarVector(FA.F_CaderaIzquierda, l_L_Hip);
    
    %% Normalizar por peso corporal
    F_R_Ankle_PrxDis_norm = F_R_Ankle_PrxDis / peso_N;
    F_R_Ankle_MedLat_norm = F_R_Ankle_MedLat / peso_N;
    F_R_Ankle_AntPos_norm = F_R_Ankle_AntPos / peso_N;
    
    F_R_Knee_PrxDis_norm = F_R_Knee_PrxDis / peso_N;
    F_R_Knee_MedLat_norm = F_R_Knee_MedLat / peso_N;
    F_R_Knee_AntPos_norm = F_R_Knee_AntPos / peso_N;
    
    F_R_Hip_PrxDis_norm = F_R_Hip_PrxDis / peso_N;
    F_R_Hip_MedLat_norm = F_R_Hip_MedLat / peso_N;
    F_R_Hip_AntPos_norm = F_R_Hip_AntPos / peso_N;
    
    F_L_Ankle_PrxDis_norm = F_L_Ankle_PrxDis / peso_N;
    F_L_Ankle_MedLat_norm = F_L_Ankle_MedLat / peso_N;
    F_L_Ankle_AntPos_norm = F_L_Ankle_AntPos / peso_N;
    
    F_L_Knee_PrxDis_norm = F_L_Knee_PrxDis / peso_N;
    F_L_Knee_MedLat_norm = F_L_Knee_MedLat / peso_N;
    F_L_Knee_AntPos_norm = F_L_Knee_AntPos / peso_N;
    
    F_L_Hip_PrxDis_norm = F_L_Hip_PrxDis / peso_N;
    F_L_Hip_MedLat_norm = F_L_Hip_MedLat / peso_N;
    F_L_Hip_AntPos_norm = F_L_Hip_AntPos / peso_N;
    
    %% Calcular porcentaje del ciclo de marcha
    offset = Ciclo.PrimerFrame - Ciclo.AntesHS;
    RHS1_idx = Ciclo.FrameRHS1 - offset;
    RHS2_idx = Ciclo.FrameRHS2 - offset;
    LHS1_idx = Ciclo.FrameLHS1 - offset;
    LHS2_idx = Ciclo.FrameLHS2 - offset;
    RTO_idx = Ciclo.FrameRTO - offset;
    LTO_idx = Ciclo.FrameLTO - offset;
    
    % Ciclo derecho: de RHS1 a RHS2
    ciclo_derecho_frames = RHS2_idx - RHS1_idx + 1;
    porcentaje_derecho = linspace(0, 100, ciclo_derecho_frames);
    
    % Ciclo izquierdo: de LHS1 a LHS2
    ciclo_izquierdo_frames = LHS2_idx - LHS1_idx + 1;
    porcentaje_izquierdo = linspace(0, 100, ciclo_izquierdo_frames);
    
    %% Definir posiciones de líneas de referencia
    x_RTO = ((RTO_idx - RHS1_idx) / (ciclo_derecho_frames - 1)) * 100;
    x_LTO = ((LTO_idx - LHS1_idx) / (ciclo_izquierdo_frames - 1)) * 100;
    
    %% Extraer datos del ciclo
    % DERECHO
    F_R_Ankle_PrxDis_ciclo = F_R_Ankle_PrxDis_norm(RHS1_idx:RHS2_idx);
    F_R_Ankle_MedLat_ciclo = F_R_Ankle_MedLat_norm(RHS1_idx:RHS2_idx);
    F_R_Ankle_AntPos_ciclo = F_R_Ankle_AntPos_norm(RHS1_idx:RHS2_idx);
    
    F_R_Knee_PrxDis_ciclo = F_R_Knee_PrxDis_norm(RHS1_idx:RHS2_idx);
    F_R_Knee_MedLat_ciclo = F_R_Knee_MedLat_norm(RHS1_idx:RHS2_idx);
    F_R_Knee_AntPos_ciclo = F_R_Knee_AntPos_norm(RHS1_idx:RHS2_idx);
    
    F_R_Hip_PrxDis_ciclo = F_R_Hip_PrxDis_norm(RHS1_idx:RHS2_idx);
    F_R_Hip_MedLat_ciclo = F_R_Hip_MedLat_norm(RHS1_idx:RHS2_idx);
    F_R_Hip_AntPos_ciclo = F_R_Hip_AntPos_norm(RHS1_idx:RHS2_idx);
    
    % IZQUIERDO
    F_L_Ankle_PrxDis_ciclo = F_L_Ankle_PrxDis_norm(LHS1_idx:LHS2_idx);
    F_L_Ankle_MedLat_ciclo = F_L_Ankle_MedLat_norm(LHS1_idx:LHS2_idx);
    F_L_Ankle_AntPos_ciclo = F_L_Ankle_AntPos_norm(LHS1_idx:LHS2_idx);
    
    F_L_Knee_PrxDis_ciclo = F_L_Knee_PrxDis_norm(LHS1_idx:LHS2_idx);
    F_L_Knee_MedLat_ciclo = F_L_Knee_MedLat_norm(LHS1_idx:LHS2_idx);
    F_L_Knee_AntPos_ciclo = F_L_Knee_AntPos_norm(LHS1_idx:LHS2_idx);
    
    F_L_Hip_PrxDis_ciclo = F_L_Hip_PrxDis_norm(LHS1_idx:LHS2_idx);
    F_L_Hip_MedLat_ciclo = F_L_Hip_MedLat_norm(LHS1_idx:LHS2_idx);
    F_L_Hip_AntPos_ciclo = F_L_Hip_AntPos_norm(LHS1_idx:LHS2_idx);
    
    %% Crear figura con 9 subplots (3x3)
    figure('Position', [100, 100, 900, 600]);
    
    % PRIMERA COLUMNA: Lateral-Medial
    % Cadera
    subplot(3, 3, 1);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Hip_MedLat_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Hip_MedLat_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Cadera', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Lateral(-)/Medial(+) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % Rodilla
    subplot(3, 3, 4);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Knee_MedLat_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Knee_MedLat_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Rodilla', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Lateral(-)/Medial(+) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % Tobillo
    subplot(3, 3, 7);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Ankle_MedLat_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Ankle_MedLat_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Tobillo', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Lateral(-)/Medial(+) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % SEGUNDA COLUMNA: Posterior-Anterior
    % Cadera
    subplot(3, 3, 2);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Hip_AntPos_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Hip_AntPos_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5);
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5);
    title('Fuerza Cadera', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Post(+)/Ant(-) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % Rodilla
    subplot(3, 3, 5);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Knee_AntPos_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Knee_AntPos_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Rodilla', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Post(+)/Ant(-) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % Tobillo
    subplot(3, 3, 8);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Ankle_AntPos_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Ankle_AntPos_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Tobillo', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Post(+)/Ant(-) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % TERCERA COLUMNA: Distal-Proximal
    % Cadera
    subplot(3, 3, 3);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Hip_PrxDis_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Hip_PrxDis_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Cadera', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Distal(-)/Prox(+) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % Rodilla
    subplot(3, 3, 6);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Knee_PrxDis_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Knee_PrxDis_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Rodilla', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Distal(-)/Prox(+) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % Tobillo
    subplot(3, 3, 9);
    hold on; grid on;
    plot(porcentaje_derecho, F_R_Ankle_PrxDis_ciclo, 'Color', 'g', 'LineWidth', 1.5);
    plot(porcentaje_izquierdo, F_L_Ankle_PrxDis_ciclo, 'Color', 'r', 'LineWidth', 1.5);
    line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5); 
    line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5); 
    title('Fuerza Tobillo', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Distal(-)/Prox(+) [N]', 'FontSize', 10);
    xlabel('% CM', 'FontSize', 10);
    xlim([0, 100]);
    
    % Título general
    sgtitle('Fuerzas Articulares en Ejes Anatómicos [N/Peso Corporal]', ...
            'FontSize', 14, 'FontWeight', 'bold');
    
end

%% Funciones auxiliares
function l = calcularEjeFlotante(i_seg, k_seg)
    % Calcula el eje flotante como producto cruz normalizado
    % l = i_seg x k_seg (perpendicular a ambos)
    nFrames = size(i_seg, 1);
    l = zeros(nFrames, 3);
    
    for frame = 1:nFrames
        i_vec = i_seg(frame, :)';
        k_vec = k_seg(frame, :)';
        
        % Producto cruz
        l_vec = cross(i_vec, k_vec);
        
        % Normalizar
        l_norm = norm(l_vec);
        if l_norm > eps
            l_vec = l_vec / l_norm;
        end
        
        l(frame, :) = l_vec';
    end
end

function proyeccion = proyectarVector(F, eje)
    % Proyecta el vector fuerza F sobre el eje unitario
    % F · eje = |F| * cos(theta)
    nFrames = size(F, 1);
    proyeccion = zeros(nFrames, 1);
    
    for frame = 1:nFrames
        F_vec = F(frame, :)';
        eje_vec = eje(frame, :)';
        
        % Producto punto
        proyeccion(frame) = dot(F_vec, eje_vec);
    end
end