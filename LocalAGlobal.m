function M_global = LocalAGlobal(M_local, SL)
% Convierte los vectores en Hd_Local a coordenadas globales usando
% los sistemas de referencia en SL.

    M_global = struct();
    
    % --- Mapeo (Asumiendo esta correspondencia) ---
    mapa = {
        'musloD',  {'i1', 'j1', 'k1'};
        'musloI',  {'i2', 'j2', 'k2'};
        'piernaD', {'i3', 'j3', 'k3'};
        'piernaI', {'i4', 'j4', 'k4'};
        'pieD',    {'i5', 'j5', 'k5'};
        'pieI',    {'i6', 'j6', 'k6'};
    };

    % --- Cálculo Vectorizado ---
    for i = 1:size(mapa, 1)
        campoHd = mapa{i, 1};      % ej. 'musloD'
        camposSL = mapa{i, 2};     % ej. {'i1', 'j1', 'k1'}
        
        % Extraer los componentes locales (columnas 1, 2, 3)
        Hx_local = M_local.(campoHd)(:, 1);
        Hy_local = M_local.(campoHd)(:, 2);
        Hz_local = M_local.(campoHd)(:, 3);
        
        % Extraer los vectores base globales
        i_vec = SL.(camposSL{1});
        j_vec = SL.(camposSL{2});
        k_vec = SL.(camposSL{3});
        
        % Aplicar la transformación de base
        M_global.(campoHd) = (Hx_local .* i_vec) + ...
                             (Hy_local .* j_vec) + ...
                             (Hz_local .* k_vec);
    end
end