function MRP = ObtenerMRP(Hd_global, M_residual)
% Calcula momentos musculares netos proximales
% M_muscular = Hd_global - M_residual
% Ambos en coordenadas globales

    % MIEMBRO DERECHO
    MRP.tobilloD = Hd_global.pieD - M_residual.tobilloD;
    MRP.rodillaD = Hd_global.piernaD - M_residual.rodillaD;
    MRP.caderaD = Hd_global.musloD - M_residual.caderaD;
    
    % MIEMBRO IZQUIERDO
    MRP.tobilloI = Hd_global.pieI - M_residual.tobilloI;
    MRP.rodillaI = Hd_global.piernaI - M_residual.rodillaI;
    MRP.caderaI = Hd_global.musloI - M_residual.caderaI;
end