function AE = ObtenerAE(i, j, k)
    %% Definir vectores globales
    frames = size(i, 1);
    I = zeros(frames, 3);
    I(:, 1) = 1;
    J = zeros(frames, 3);
    J(:, 2) = 1;
    K = zeros(frames, 3);
    K(:, 3) = 1;
    
    %% Definir Linea de Nodos
    LN = normalize(cross(K, k, 2), 2, 'norm');
    
    %% Ángulos de euler en RADIANES
    AE.alpha = normalize(dot(J, LN, 2), 2, 'norm') .* acos(dot(I, LN, 2));
    AE.beta = acos(dot(K, k, 2));
    AE.gamma = - normalize(dot(j, LN, 2), 2, 'norm') .* acos(dot(i, LN, 2));
    
    %% Aplicar unwrap
    AE.alpha = unwrap(AE.alpha);
    AE.beta = unwrap(AE.beta);
    AE.gamma = unwrap(AE.gamma);
    
    %% Convertir a grados al final
    AE.alpha = rad2deg(AE.alpha);
    AE.beta = rad2deg(AE.beta);
    AE.gamma = rad2deg(AE.gamma);
end