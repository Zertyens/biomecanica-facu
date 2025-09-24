function AE = obtenerAE(i, j, k)
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
    
    %% Ángulos de euler
    AE.alpha = normalize(dot(J, LN, 2), 2, 'norm') .* acosd(dot(I, LN, 2));
    AE.beta = acosd(dot(K, k, 2));
    AE.gamma = - normalize(dot(j, LN, 2), 2, 'norm') .* acosd(dot(i, LN, 2));
end
