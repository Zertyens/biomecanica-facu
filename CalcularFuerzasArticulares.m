function FA = CalcularFuerzasArticulares(FP, aCM, masas, Ciclo)
    % CalcularFuerzasArticulares - Resuelve el problema de dinámica inversa
    % para calcular fuerzas articulares usando la Segunda Ley de Newton
    %
    % Inputs:
    %   FP    - Estructura con fuerzas de plataforma (P1, P2) y gravedad (g)
    %   aCM   - Estructura con aceleraciones de centros de masa [533x3]
    %   masas - Estructura con masas de segmentos (kg)
    %   Ciclo - Estructura con información de eventos de marcha
    %
    % Output:
    %   FA - Estructura con fuerzas articulares para cada articulación

    % Número de frames
    nFrames = size(aCM.a_p_RThigh, 1);
    
    % Inicializar estructura de salida
    FA = struct();
    
    % Ajustar índices de eventos según offset
    offset = Ciclo.PrimerFrame - Ciclo.AntesHS;
    RHS1_idx = Ciclo.FrameRHS1 - offset;
    RHS2_idx = Ciclo.FrameRHS2 - offset;
    LHS1_idx = Ciclo.FrameLHS1 - offset;
    LHS2_idx = Ciclo.FrameLHS2 - offset;
    RTO_idx = Ciclo.FrameRTO - offset;
    LTO_idx = Ciclo.FrameLTO - offset;
    
    % Crear vectores lógicos de fase de apoyo
    apoyoDerecho = false(nFrames, 1);
    apoyoIzquierdo = false(nFrames, 1);
    
    % Pie derecho en apoyo desde RHS1 hasta RTO
    if RHS1_idx > 0 && RTO_idx <= nFrames
        apoyoDerecho(RHS1_idx:RTO_idx) = true;
    end
    % Si hay un segundo contacto derecho
    if RHS2_idx > 0 && RHS2_idx <= nFrames
        apoyoDerecho(RHS2_idx:end) = true;
    end
    
    % Pie izquierdo en apoyo desde LHS1 hasta LTO
    if LHS1_idx > 0 && LTO_idx <= nFrames
        apoyoIzquierdo(LHS1_idx:LTO_idx) = true;
    end
    % Si hay un segundo contacto izquierdo
    if LHS2_idx > 0 && LHS2_idx <= nFrames
        apoyoIzquierdo(LHS2_idx:end) = true;
    end
    
    %% MIEMBRO INFERIOR DERECHO (Distal a Proximal)
    
    % 1. TOBILLO DERECHO (entre Pie y Pierna)
    % Segmento: Pie Derecho
    % F_proximal + F_distal + m*g + F_externa = m*a_CG
    % F_proximal = m*a_CG - F_distal - m*g - F_externa
    
    FA.F_TobilloDerecho = zeros(nFrames, 3);
    
    for i = 1:nFrames
        m = masas.pieD;
        a_CG = aCM.a_p_RFoot(i, :)';  % Vector columna [3x1]
        mg = m * FP.g;  % Fuerza gravitacional
        
        % Fuerza distal (en el pie es cero, no hay segmento más distal)
        F_distal = [0; 0; 0];
        
        % Fuerza externa (GRF de plataforma P2 si está en apoyo)
        if apoyoDerecho(i)
            F_externa = [FP.P2.Fx(i); FP.P2.Fy(i); FP.P2.Fz(i)];
        else
            F_externa = [0; 0; 0];
        end
        
        % Calcular fuerza proximal (tobillo)
        F_proximal = m * a_CG - F_distal - mg - F_externa;
        FA.F_TobilloDerecho(i, :) = F_proximal';
    end
    
    % 2. RODILLA DERECHA (entre Pierna y Muslo)
    % Segmento: Pierna Derecha
    FA.F_RodillaDerecha = zeros(nFrames, 3);
    
    for i = 1:nFrames
        m = masas.piernaD;
        a_CG = aCM.a_p_RCalf(i, :)';
        mg = m * FP.g;
        
        % Fuerza distal = -Fuerza proximal del segmento anterior (3ra Ley)
        F_distal = -FA.F_TobilloDerecho(i, :)';
        
        % No hay fuerzas externas en la pierna
        F_externa = [0; 0; 0];
        
        % Calcular fuerza proximal (rodilla)
        F_proximal = m * a_CG - F_distal - mg - F_externa;
        FA.F_RodillaDerecha(i, :) = F_proximal';
    end
    
    % 3. CADERA DERECHA (entre Muslo y Pelvis)
    % Segmento: Muslo Derecho
    FA.F_CaderaDerecha = zeros(nFrames, 3);
    
    for i = 1:nFrames
        m = masas.musloD;
        a_CG = aCM.a_p_RThigh(i, :)';
        mg = m * FP.g;
        
        % Fuerza distal = -Fuerza proximal del segmento anterior
        F_distal = -FA.F_RodillaDerecha(i, :)';
        
        % No hay fuerzas externas en el muslo
        F_externa = [0; 0; 0];
        
        % Calcular fuerza proximal (cadera)
        F_proximal = m * a_CG - F_distal - mg - F_externa;
        FA.F_CaderaDerecha(i, :) = F_proximal';
    end
    
    %% MIEMBRO INFERIOR IZQUIERDO (Distal a Proximal)
    
    % 1. TOBILLO IZQUIERDO (entre Pie y Pierna)
    FA.F_TobilloIzquierdo = zeros(nFrames, 3);
    
    for i = 1:nFrames
        m = masas.pieI;
        a_CG = aCM.a_p_LFoot(i, :)';
        mg = m * FP.g;
        
        F_distal = [0; 0; 0];
        
        % Fuerza externa (GRF de plataforma P1 si está en apoyo)
        if apoyoIzquierdo(i)
            F_externa = [FP.P1.Fx(i); FP.P1.Fy(i); FP.P1.Fz(i)];
        else
            F_externa = [0; 0; 0];
        end
        
        F_proximal = m * a_CG - F_distal - mg - F_externa;
        FA.F_TobilloIzquierdo(i, :) = F_proximal';
    end
    
    % 2. RODILLA IZQUIERDA (entre Pierna y Muslo)
    FA.F_RodillaIzquierda = zeros(nFrames, 3);
    
    for i = 1:nFrames
        m = masas.piernaI;
        a_CG = aCM.a_p_LCalf(i, :)';
        mg = m * FP.g;
        
        F_distal = -FA.F_TobilloIzquierdo(i, :)';
        F_externa = [0; 0; 0];
        
        F_proximal = m * a_CG - F_distal - mg - F_externa;
        FA.F_RodillaIzquierda(i, :) = F_proximal';
    end
    
    % 3. CADERA IZQUIERDA (entre Muslo y Pelvis)
    FA.F_CaderaIzquierda = zeros(nFrames, 3);
    
    for i = 1:nFrames
        m = masas.musloI;
        a_CG = aCM.a_p_LThigh(i, :)';
        mg = m * FP.g;
        
        F_distal = -FA.F_RodillaIzquierda(i, :)';
        F_externa = [0; 0; 0];
        
        F_proximal = m * a_CG - F_distal - mg - F_externa;
        FA.F_CaderaIzquierda(i, :) = F_proximal';
    end
    
end