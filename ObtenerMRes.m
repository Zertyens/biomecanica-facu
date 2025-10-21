function MRes = ObtenerMRes(CA, CM, FA, FP, Hd_global)
% Calcula momentos residuales en tobillo, rodilla y cadera para ambos lados
% Devuelve estructura MR con campos: tobilloD, rodillaD, caderaD, tobilloI, rodillaI, caderaI

    %% MIEMBRO DERECHO
    % Centro de presión de la plataforma derecha
    COP_D = [FP.P2.Cx, FP.P2.Cy, zeros(size(FP.P2.Cx))];
    F_plat_D = [FP.P2.Fx, FP.P2.Fy, FP.P2.Fz];
    T_plat_D = [zeros(size(FP.P2.Mz)), zeros(size(FP.P2.Mz)), FP.P2.Mz];
    
    % PIE DERECHO
    p_dist = COP_D - CM.p_RFoot;
    p_prox = CA.p_RAnkle - CM.p_RFoot;
    MRes.tobilloD = -Hd_global.pieD ...
                  - cross(p_dist, F_plat_D, 2) ...
                  + cross(p_prox, FA.tobillo_D, 2) ...
                  + T_plat_D;
    
    % PIERNA DERECHA
    p_dist = CA.p_RAnkle - CM.p_RCalf;
    p_prox = CA.p_RKnee - CM.p_RCalf;
    MRes.rodillaD = -Hd_global.piernaD ...
                  - cross(p_dist, -FA.tobillo_D, 2) ...
                  + cross(p_prox, FA.rodilla_D, 2);
    
    % MUSLO DERECHO
    p_dist = CA.p_RKnee - CM.p_RThigh;
    p_prox = CA.p_RHip - CM.p_RThigh;
    MRes.caderaD = -Hd_global.musloD ...
                 - cross(p_dist, -FA.rodilla_D, 2) ...
                 + cross(p_prox, FA.cadera_D, 2);
    
    %% MIEMBRO IZQUIERDO
    % Centro de presión de la plataforma izquierda
    COP_I = [FP.P1.Cx, FP.P1.Cy, zeros(size(FP.P1.Cx))];
    F_plat_I = [FP.P1.Fx, FP.P1.Fy, FP.P1.Fz];
    T_plat_I = [zeros(size(FP.P1.Mz)), zeros(size(FP.P1.Mz)), FP.P1.Mz];
    
    % PIE IZQUIERDO
    p_dist = COP_I - CM.p_LFoot;
    p_prox = CA.p_LAnkle - CM.p_LFoot;
    MRes.tobilloI = -Hd_global.pieI ...
                  - cross(p_dist, F_plat_I, 2) ...
                  + cross(p_prox, FA.tobillo_I, 2) ...
                  + T_plat_I;
    
    % PIERNA IZQUIERDA
    p_dist = CA.p_LAnkle - CM.p_LCalf;
    p_prox = CA.p_LKnee - CM.p_LCalf;
    MRes.rodillaI = -Hd_global.piernaI ...
                  - cross(p_dist, -FA.tobillo_I, 2) ...
                  + cross(p_prox, FA.rodilla_I, 2);
    
    % MUSLO IZQUIERDO
    p_dist = CA.p_LKnee - CM.p_LThigh;
    p_prox = CA.p_LHip - CM.p_LThigh;
    MRes.caderaI = -Hd_global.musloI ...
                 - cross(p_dist, -FA.rodilla_I, 2) ...
                 + cross(p_prox, FA.cadera_I, 2);
end