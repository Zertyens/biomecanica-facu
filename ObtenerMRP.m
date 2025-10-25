function MRP = ObtenerMRP(CA, CM, FA, FP, Hd_global)
% Calcula los momentos reactivos (Net Joint Moments) en tobillo, rodilla y
% cadera para ambos lados en una sola función secuencial.
%
% ENTRADAS:
%   CA, CM, FA, FP: Estructuras con datos cinemáticos y cinéticos.
%   Hd_global: Tasa de cambio del momento angular (H_dot) en coord. globales.
%
% SALIDA:
%   MR: Estructura con los momentos reactivos finales (MR.tobilloD,
%       MR.rodillaD, MR.caderaD, etc.)

    MRP = struct(); % Struct de salida con Momentos Reactivos

    %% === MIEMBRO DERECHO ===
    
    % --- 1. PIE / TOBILLO (Segmento 5) ---
    
    % Datos de la plataforma Derecha (P2)
    COP_D = [FP.P2.Cx, FP.P2.Cy, zeros(size(FP.P2.Cx))];
    F_plat_D = [FP.P2.Fx, FP.P2.Fy, FP.P2.Fz];
    T_plat_D = [FP.P2.Mx, FP.P2.My, FP.P2.Mz];
    
    % Vectores brazo desde el CM del pie
    p_dist_pie_D = COP_D - CM.p_RFoot;        % (p_Dis.5)
    p_prox_pie_D = CA.p_RAnkle - CM.p_RFoot;  % (p_Prx.5)

    % Cálculo intermedio: M_Res.5 (Ecuación B.91)
    MRes_pie_D = T_plat_D ...
                 + cross(p_prox_pie_D, FA.tobillo_D, 2) ...
                 + cross(p_dist_pie_D, F_plat_D, 2);
    
    % Resultado final para tobillo: MR.tobilloD (Ecuación B.96)
    MRP.tobilloD = Hd_global.pieD - MRes_pie_D;

    
    % --- 2. PIERNA / RODILLA (Segmento 3) ---
    
    % Vectores brazo desde el CM de la pierna
    p_dist_pierna_D = CA.p_RAnkle - CM.p_RCalf; % (p_Dis.3)
    p_prox_pierna_D = CA.p_RKnee - CM.p_RCalf;  % (p_Prx.3)
    
    % Cálculo intermedio: M_Res.3 (Ecuación B.109)
    % (Usa el MR.tobilloD que acabamos de calcular)
    MRes_pierna_D = -MRP.tobilloD ...
                    - cross(p_dist_pierna_D, FA.tobillo_D, 2) ...
                    + cross(p_prox_pierna_D, FA.rodilla_D, 2);
    
    % Resultado final para rodilla: MR.rodillaD
    MRP.rodillaD = Hd_global.piernaD - MRes_pierna_D;

    
    % --- 3. MUSLO / CADERA (Segmento 1) ---
    
    % Vectores brazo desde el CM del muslo
    p_dist_muslo_D = CA.p_RKnee - CM.p_RThigh;
    p_prox_muslo_D = CA.p_RHip - CM.p_RThigh;
    
    % Cálculo intermedio: M_Res.1
    % (Usa el MR.rodillaD que acabamos de calcular)
    MRes_muslo_D = -MRP.rodillaD ...
                   - cross(p_dist_muslo_D, FA.rodilla_D, 2) ...
                   + cross(p_prox_muslo_D, FA.cadera_D, 2);
                   
    % Resultado final para cadera: MR.caderaD
    MRP.caderaD = Hd_global.musloD - MRes_muslo_D;

    
    %% === MIEMBRO IZQUIERDO ===
    % (Se repite exactamente la misma lógica)

    % --- 1. PIE / TOBILLO (Segmento 6) ---
    COP_I = [FP.P1.Cx, FP.P1.Cy, zeros(size(FP.P1.Cx))];
    F_plat_I = [FP.P1.Fx, FP.P1.Fy, FP.P1.Fz];
    T_plat_I = [FP.P1.Mx, FP.P1.My, FP.P1.Mz];

    p_dist_pie_I = COP_I - CM.p_LFoot;
    p_prox_pie_I = CA.p_LAnkle - CM.p_LFoot;
    
    MRes_pie_I = T_plat_I ...
                 + cross(p_prox_pie_I, FA.tobillo_I, 2) ...
                 + cross(p_dist_pie_I, F_plat_I, 2);
    
    MRP.tobilloI = Hd_global.pieI - MRes_pie_I;
    
    % --- 2. PIERNA / RODILLA (Segmento 4) ---
    p_dist_pierna_I = CA.p_LAnkle - CM.p_LCalf;
    p_prox_pierna_I = CA.p_LKnee - CM.p_LCalf;
    
    MRes_pierna_I = -MRP.tobilloI ...
                    - cross(p_dist_pierna_I, FA.tobillo_I, 2) ...
                    + cross(p_prox_pierna_I, FA.rodilla_I, 2);
                    
    MRP.rodillaI = Hd_global.piernaI - MRes_pierna_I;
    
    % --- 3. MUSLO / CADERA (Segmento 2) ---
    p_dist_muslo_I = CA.p_LKnee - CM.p_LThigh;
    p_prox_muslo_I = CA.p_LHip - CM.p_LThigh;
    
    MRes_muslo_I = -MRP.rodillaI ...
                   - cross(p_dist_muslo_I, FA.rodilla_I, 2) ...
                   + cross(p_prox_muslo_I, FA.cadera_I, 2);
                   
    MRP.caderaI = Hd_global.musloI - MRes_muslo_I;
    
end