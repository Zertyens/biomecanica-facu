function R = ObtenerMatricesRotacion(AE)
% Calcula matrices de rotación para todos los segmentos
    campos = fieldnames(AE);
    
    for i = 1:length(campos)
        segmento = campos{i};
        R.(segmento) = ObtenerMatrizRotacion(AE.(segmento).alpha, ...
                                              AE.(segmento).beta, ...
                                              AE.(segmento).gamma);
    end
end

function R = ObtenerMatrizRotacion(alpha, beta, gamma)
% Calcula matriz de rotación 3x3xN usando ángulos de Euler (secuencia 3-1-3: Z-X-Z)
% alpha, beta, gamma: vectores Nx1 con ángulos en grados
% R: matriz 3x3xN con las matrices de rotación para cada instante

    N = length(alpha);
    R = zeros(3, 3, N);
    
    % Convertir a radianes
    a = deg2rad(alpha);
    b = deg2rad(beta);
    g = deg2rad(gamma);
    
    for i = 1:N
        % Primera rotación en Z (alpha)
        Rz1 = [cos(a(i))  -sin(a(i))  0;
               sin(a(i))   cos(a(i))  0;
               0           0           1];
        
        % Rotación en X (beta)
        Rx = [1   0            0;
              0   cos(b(i))   -sin(b(i));
              0   sin(b(i))    cos(b(i))];
        
        % Segunda rotación en Z (gamma)
        Rz2 = [cos(g(i))  -sin(g(i))  0;
               sin(g(i))   cos(g(i))  0;
               0           0           1];
        
        % R = Rz1 * Rx * Rz2 (secuencia Z-X-Z)
        R(:,:,i) = Rz1 * Rx * Rz2;
    end
end