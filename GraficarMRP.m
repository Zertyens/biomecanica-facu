function GraficarMRP(MRP, SL, Datos, Ciclo)
    %% Parámetros
    peso = Datos.antropometria.PESO.Valor; % kg
    
    %% Calcular índices del ciclo
    offset = Ciclo.PrimerFrame - Ciclo.AntesHS;
    RHS1_idx = Ciclo.FrameRHS1 - offset;
    RHS2_idx = Ciclo.FrameRHS2 - offset;
    LHS1_idx = Ciclo.FrameLHS1 - offset;
    LHS2_idx = Ciclo.FrameLHS2 - offset;
    RTO_idx = Ciclo.FrameRTO - offset;
    LTO_idx = Ciclo.FrameLTO - offset;
    
    %% Calcular ejes flotantes (l = k_proximal × i_distal)
    % DERECHO
    l_R_Ankle = calcularEjeArticular(SL.k3, SL.i5);   % k_pierna × i_pie
    l_R_Knee = calcularEjeArticular(SL.k1, SL.i3);    % k_muslo × i_pierna
    l_R_Hip = calcularEjeArticular(SL.k_pelv, SL.i1); % k_pelvis × i_muslo
    
    % IZQUIERDO
    l_L_Ankle = calcularEjeArticular(SL.k4, SL.i6);   % k_pierna × i_pie
    l_L_Knee = calcularEjeArticular(SL.k2, SL.i4);    % k_muslo × i_pierna
    l_L_Hip = calcularEjeArticular(SL.k_pelv, SL.i2); % k_pelvis × i_muslo
    
    %% TOBILLO (α, β, γ)
    % DERECHO
    M_R_Ankle_InvEve = proyectarVector(MRP.tobilloD, SL.i5) / peso;      % α
    M_R_Ankle_PlaDor = proyectarVector(MRP.tobilloD, SL.k3) / peso;      % β
    M_R_Ankle_VarVal = proyectarVector(MRP.tobilloD, l_R_Ankle) / peso;  % γ
    
    % IZQUIERDO
    M_L_Ankle_InvEve = proyectarVector(MRP.tobilloI, SL.i6) / peso;
    M_L_Ankle_PlaDor = -proyectarVector(MRP.tobilloI, SL.k4) / peso;     % Invertir signo
    M_L_Ankle_VarVal = proyectarVector(MRP.tobilloI, l_L_Ankle) / peso;
    
    %% RODILLA (α, β, γ)
    % DERECHO
    M_R_Knee_IntExt = proyectarVector(MRP.rodillaD, SL.i3) / peso;       % α
    M_R_Knee_FlxExt = proyectarVector(MRP.rodillaD, SL.k1) / peso;       % β
    M_R_Knee_AbdAdd = proyectarVector(MRP.rodillaD, l_R_Knee) / peso;    % γ
    
    % IZQUIERDO
    M_L_Knee_IntExt = proyectarVector(MRP.rodillaI, SL.i4) / peso;
    M_L_Knee_FlxExt = -proyectarVector(MRP.rodillaI, SL.k2) / peso;      % Invertir signo
    M_L_Knee_AbdAdd = proyectarVector(MRP.rodillaI, l_L_Knee) / peso;
    
    %% CADERA (α, β, γ)
    % DERECHO
    M_R_Hip_IntExt = proyectarVector(MRP.caderaD, SL.i1) / peso;         % α
    M_R_Hip_FlxExt = proyectarVector(MRP.caderaD, SL.k_pelv) / peso;     % β
    M_R_Hip_AbdAdd = proyectarVector(MRP.caderaD, l_R_Hip) / peso;       % γ
    
    % IZQUIERDO
    M_L_Hip_IntExt = proyectarVector(MRP.caderaI, SL.i2) / peso;
    M_L_Hip_FlxExt = -proyectarVector(MRP.caderaI, SL.k_pelv) / peso;    % Invertir signo
    M_L_Hip_AbdAdd = proyectarVector(MRP.caderaI, l_L_Hip) / peso;
    
    %% Calcular porcentaje del ciclo de marcha
    ciclo_derecho_frames = RHS2_idx - RHS1_idx + 1;
    porcentaje_derecho = linspace(0, 100, ciclo_derecho_frames);
    
    ciclo_izquierdo_frames = LHS2_idx - LHS1_idx + 1;
    porcentaje_izquierdo = linspace(0, 100, ciclo_izquierdo_frames);
    
    x_RTO = ((RTO_idx - RHS1_idx) / (ciclo_derecho_frames - 1)) * 100;
    x_LTO = ((LTO_idx - LHS1_idx) / (ciclo_izquierdo_frames - 1)) * 100;
    
    %% Organizar datos recortados (COLUMNAS: α, β, γ)
    data_R = {M_R_Hip_IntExt(RHS1_idx:RHS2_idx), M_R_Hip_FlxExt(RHS1_idx:RHS2_idx), M_R_Hip_AbdAdd(RHS1_idx:RHS2_idx);
              M_R_Knee_IntExt(RHS1_idx:RHS2_idx), M_R_Knee_FlxExt(RHS1_idx:RHS2_idx), M_R_Knee_AbdAdd(RHS1_idx:RHS2_idx);
              M_R_Ankle_InvEve(RHS1_idx:RHS2_idx), M_R_Ankle_PlaDor(RHS1_idx:RHS2_idx), []};  % Tobillo no tiene VarVal en gráfico
              
    data_L = {M_L_Hip_IntExt(LHS1_idx:LHS2_idx), M_L_Hip_FlxExt(LHS1_idx:LHS2_idx), M_L_Hip_AbdAdd(LHS1_idx:LHS2_idx);
              M_L_Knee_IntExt(LHS1_idx:LHS2_idx), M_L_Knee_FlxExt(LHS1_idx:LHS2_idx), M_L_Knee_AbdAdd(LHS1_idx:LHS2_idx);
              M_L_Ankle_InvEve(LHS1_idx:LHS2_idx), M_L_Ankle_PlaDor(LHS1_idx:LHS2_idx), []};
    
    titulos = {'Momentos Musculares Cadera', 'Momentos Musculares Rodilla', 'Momentos Musculares Tobillo'};
    ylabels = {'Flex(-)/Ext(+) [Nm/kg]', 'ABD(-)/ADD(+) [Nm/kg]', 'RotE(-)/RotInt(+) [Nm/kg]'};
    
    %% Crear figura
    figure('Position', [100, 100, 900, 600]);
    
    for fila = 1:3
        for col = 1:3
            plot_idx = (fila - 1) * 3 + col;
            subplot(3, 3, plot_idx);
            
            if fila == 3 && col == 3
                axis off;
                continue;
            end
            
            hold on; grid on;
            plot(porcentaje_derecho, data_R{fila, col}, 'Color', 'g', 'LineWidth', 1.5);
            plot(porcentaje_izquierdo, data_L{fila, col}, 'Color', 'r', 'LineWidth', 1.5);
            line([x_RTO x_RTO], ylim, 'LineStyle', '--', 'Color', 'red', 'LineWidth', 1.5, 'HandleVisibility', 'off');    
            line([x_LTO x_LTO], ylim, 'LineStyle', '--', 'Color', 'green', 'LineWidth', 1.5, 'HandleVisibility', 'off');    
            
            title(titulos{fila}, 'FontSize', 12, 'FontWeight', 'bold');
            ylabel(ylabels{col}, 'FontSize', 10);
            xlabel('% CM', 'FontSize', 10);
            xlim([0, 100]);
        end
    end
    
    sgtitle('Momentos Musculares Netos Proximales en Ejes Anatómicos [Nm/Masa Corporal (Nm/kg)]', ...
            'FontSize', 14, 'FontWeight', 'bold');
end

function l = calcularEjeArticular(k_prox, i_dist)
    % l = k_proximal × i_distal
    l = cross(k_prox, i_dist, 2);
    l_norm = vecnorm(l, 2, 2);
    l_norm(l_norm < eps) = 1; 
    l = l ./ l_norm;
end

function proyeccion = proyectarVector(M, eje)
    proyeccion = sum(M .* eje, 2);
end