function MRP_anat = ObtenerMRP_anat(MR_Global, SL)
% Proyecta los momentos reactivos GLOBALES a los ejes ANATÓMICOS,
% siguiendo las convenciones de signos del "código que funciona".

    MRP_anat = struct();

    % --- Ejes Flotantes (calculados) ---
    % (Tu "código que funciona" los llama i_r_ajc, i_r_kjc, etc.)
    
    % Normalizar (vecnorm) evita la división por cero si ya son 0
    function e_norm = normalizar(v)
        normas = vecnorm(v, 2, 2);
        normas(normas < 1e-10) = 1; % Evitar div por cero
        e_norm = v ./ normas;
    end

    eje_flot_tob_D = normalizar(cross(SL.k3, SL.i5, 2)); % i_r_ajc
    eje_flot_rod_D = normalizar(cross(SL.k1, SL.i3, 2)); % i_r_kjc
    eje_flot_cad_D = normalizar(cross(SL.k_pelv, SL.i1, 2)); % i_r_hjc
    
    eje_flot_tob_I = normalizar(cross(SL.k4, SL.i6, 2)); % i_l_ajc
    eje_flot_rod_I = normalizar(cross(SL.k2, SL.i4, 2)); % i_l_kjc
    eje_flot_cad_I = normalizar(cross(SL.k_pelv, SL.i2, 2)); % i_l_hjc

    % --- Proyecciones (dot product) con SIGNOS CORREGIDOS ---
    
    % TOBILLO DERECHO (M5)
    M_vec = MR_Global.tobilloD;
    M5_flexext = sum(M_vec .* SL.k3, 2); % dot(M5, kPiernaDer, 2)
    M5_abdadd  = sum(M_vec .* eje_flot_tob_D, 2); % dot(M5, i_r_ajc, 2)
    M5_rot     = sum(M_vec .* SL.i5, 2); % dot(M5, iPieDer, 2)
    MRP_anat.tobilloD = [M5_flexext, M5_abdadd, M5_rot];
    
    % TOBILLO IZQUIERDO (M6)
    M_vec = MR_Global.tobilloI;
    M6_flexext = sum(M_vec .* SL.k4, 2);   % dot(M6, kPiernaIzq, 2)
    M6_abdadd  = -sum(M_vec .* eje_flot_tob_I, 2); % -dot(M6, i_l_ajc, 2)
    M6_rot     = -sum(M_vec .* SL.i6, 2);  % -dot(M6, iPieIzq, 2)
    MRP_anat.tobilloI = [M6_flexext, M6_abdadd, M6_rot];

    % RODILLA DERECHA (M3)
    M_vec = MR_Global.rodillaD;
    M3_flexext = sum(M_vec .* SL.k1, 2); % dot(M3, kMusloDer, 2)
    M3_abdadd  = sum(M_vec .* eje_flot_rod_D, 2); % dot(M3, i_r_kjc, 2)
    M3_rot     = sum(M_vec .* SL.i3, 2); % dot(M3, iPiernaDer, 2)
    MRP_anat.rodillaD = [M3_flexext, M3_abdadd, M3_rot];
    
    % RODILLA IZQUIERDA (M4)
    M_vec = MR_Global.rodillaI;
    M4_flexext = sum(M_vec .* SL.k2, 2);   % (Corregido de kMusloDer a kMusloIzq/k2)
    M4_abdadd  = -sum(M_vec .* eje_flot_rod_I, 2); % -dot(M4, i_l_kjc, 2)
    M4_rot     = -sum(M_vec .* SL.i4, 2);  % -dot(M4, iPiernaIzq, 2)
    MRP_anat.rodillaI = [M4_flexext, M4_abdadd, M4_rot];

    % CADERA DERECHA (M1)
    M_vec = MR_Global.caderaD;
    M1_flexext = sum(M_vec .* SL.k_pelv, 2); % dot(M1, kpelvis, 2)
    M1_abdadd  = sum(M_vec .* eje_flot_cad_D, 2); % dot(M1, i_r_hjc, 2)
    M1_rot     = sum(M_vec .* SL.i1, 2);   % dot(M1, iMusloDer, 2)
    MRP_anat.caderaD = [M1_flexext, M1_abdadd, M1_rot];
    
    % CADERA IZQUIERDA (M2)
    M_vec = MR_Global.caderaI;
    M2_flexext = sum(M_vec .* SL.k_pelv, 2); % dot(M2, kpelvis, 2)
    M2_abdadd  = -sum(M_vec .* eje_flot_cad_I, 2); % -dot(M2, i_l_hjc, 2)
    M2_rot     = -sum(M_vec .* SL.i2, 2);  % -dot(M2, iMusloIzq, 2)
    MRP_anat.caderaI = [M2_flexext, M2_abdadd, M2_rot];
end