function FP = ObtenerFP(Datos, Ciclo)
% Obtiene fuerzas de plataforma recortadas y calcula centro de presión
% Reemplaza cualquier NaN encontrado por 0.
% Convierte momentos de N·mm a N·m.
%
% FP = ObtenerFP(Datos, Ciclo)

    % Recortar datos al mismo rango temporal que los marcadores
    i_ini = Ciclo.PrimerFrame - Ciclo.AntesHS;
    i_fin = Ciclo.UltimoFrame + Ciclo.DespuesHS;
    
    %% Plataforma 1
    P1 = Datos.Pasada.Fuerzas.Plataforma1.Valores;
    
    % Llama a la función local para recortar y limpiar
    FP.P1.Fx = clean_slice(P1.Fx1, i_ini, i_fin);
    FP.P1.Fy = clean_slice(P1.Fy1, i_ini, i_fin);
    FP.P1.Fz = clean_slice(P1.Fz1, i_ini, i_fin);
    
    % Momentos (convertidos a N·m)
    FP.P1.Mx = clean_slice(P1.Mx1, i_ini, i_fin) / 1000;
    FP.P1.My = clean_slice(P1.My1, i_ini, i_fin) / 1000;
    FP.P1.Mz = clean_slice(P1.Mz1, i_ini, i_fin) / 1000;
    
    % Centro de Presión Plataforma 1 (ya está en metros)
    FP.P1.Cx = clean_slice(P1.CP1x, i_ini, i_fin);
    FP.P1.Cy = clean_slice(P1.CP1y, i_ini, i_fin);
    
    %% Plataforma 2
    P2 = Datos.Pasada.Fuerzas.Plataforma2.Valores;
    
    % Llama a la función local para recortar y limpiar
    FP.P2.Fx = clean_slice(P2.Fx2, i_ini, i_fin);
    FP.P2.Fy = clean_slice(P2.Fy2, i_ini, i_fin);
    FP.P2.Fz = clean_slice(P2.Fz2, i_ini, i_fin);
    
    % Momentos (convertidos a N·m)
    FP.P2.Mx = clean_slice(P2.Mx2, i_ini, i_fin) / 1000;
    FP.P2.My = clean_slice(P2.My2, i_ini, i_fin) / 1000;
    FP.P2.Mz = clean_slice(P2.Mz2, i_ini, i_fin) / 1000;
    
    % Centro de Presión Plataforma 2 (ya está en metros)
    FP.P2.Cx = clean_slice(P2.CP2x, i_ini, i_fin);
    FP.P2.Cy = clean_slice(P2.CP2y, i_ini, i_fin);
    
end

function data_out = clean_slice(data_in, i_ini, i_fin)
    % 1. Recorta el vector
    data_out = data_in(i_ini:i_fin);
    
    % 2. Reemplaza NaN por 0 usando indexación lógica
    data_out(isnan(data_out)) = 0;
end