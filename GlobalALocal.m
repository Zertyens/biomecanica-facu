function M_local = GlobalALocal(M_global, R)
% Convierte momentos de coordenadas globales a locales
% Usa la matriz de rotación del segmento DISTAL

    % Mapeo de articulaciones a segmentos DISTALES
    mapeo = struct(...
        'tobilloD', 'pieD', ...
        'rodillaD', 'piernaD', ...
        'caderaD', 'musloD', ...
        'tobilloI', 'pieI', ...
        'rodillaI', 'piernaI', ...
        'caderaI', 'musloI' ...
    );
    
    campos = fieldnames(M_global);
    
    for i = 1:length(campos)
        articulacion = campos{i};
        segmento = mapeo.(articulacion);  % Segmento distal
        
        M_glob = M_global.(articulacion);  % Nx3
        R_seg = R.(segmento);              % 3x3xN
        
        N = size(M_glob, 1);
        M_loc = zeros(N, 3);
        
        % Para cada instante: M_local = R^T * M_global
        for j = 1:N
            M_loc(j,:) = (R_seg(:,:,j)' * M_glob(j,:)')';
        end
        
        M_local.(articulacion) = M_loc;
    end
end