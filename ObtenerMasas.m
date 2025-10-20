function masas = ObtenerMasas(ant)
% Calcula las masas de los segmentos según tabla 3.8
% masas = CalcularMasas(ant)

    A1 = ant.A1.Valor;  % Masa corporal total
    
    % Muslo Derecho
    masas.musloD = (0.1032) * A1 + (12.76) * ant.A3 * ant.A5 * ant.A5 - 1.023;
    
    % Muslo Izquierdo
    masas.musloI = (0.1032) * A1 + (12.76) * ant.A4 * ant.A6 * ant.A6 - 1.023;
    
    % Pierna Derecha
    masas.piernaD = (0.0226) * A1 + (31.33) * ant.A7 * ant.A9 * ant.A9 + 0.016;
    
    % Pierna Izquierda
    masas.piernaI = (0.0226) * A1 + (31.33) * ant.A8 * ant.A10 * ant.A10 + 0.016;
    
    % Pie Derecho
    masas.pieD = (0.0083) * A1 + (254.5) * ant.A13 * ant.A15 * ant.A17 - 0.065;
    
    % Pie Izquierdo
    masas.pieI = (0.0083) * A1 + (254.5) * ant.A14 * ant.A16 * ant.A18 - 0.065;
    
end