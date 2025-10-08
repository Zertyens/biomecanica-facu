function CMdd = ObtenerCMdd(CM, fm)
% Calcula aceleraciones lineales de centros de masa por doble derivación
    campos = fieldnames(CM);
    
    for i = 1:length(campos)
        pos = CM.(campos{i});
        vel = diff(pos) * fm;  % 532 filas
        acc = diff(vel) * fm;  % 531 filas
        
        % Extrapolación lineal de los últimos 2 valores
        acc_extrap1 = 2*acc(end,:) - acc(end-1,:);
        acc_extrap2 = 2*acc_extrap1 - acc(end,:);
        acc = [acc; acc_extrap1; acc_extrap2];  % 533 filas
        
        CMdd.(['a_' campos{i}]) = acc;
    end
end