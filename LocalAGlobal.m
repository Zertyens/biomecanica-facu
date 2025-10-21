function M_global = LocalAGlobal(M_local, R)
    campos = fieldnames(M_local);
    
    for i = 1:length(campos)
        segmento = campos{i};
        M_loc = M_local.(segmento);  % Nx3
        R_seg = R.(segmento);         % 3x3xN
        
        N = size(M_loc, 1);
        M_glob = zeros(N, 3);
        
        % Multiplicación vectorizada por columnas
        for j = 1:N
            M_glob(j,:) = M_loc(j,:) * R_seg(:,:,j)';  % (1x3) * (3x3) = (1x3)
        end
        
        M_global.(segmento) = M_glob;
    end
end