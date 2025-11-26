function AE = ObtenerAE(i, j, k)
% AE = ObtenerAE(i, j, k) calcula los Ángulos de Euler de un segmento
% utilizando una secuencia Z-X'-Z'' a partir de los ejes del sistema 
% de coordenadas local (i, j, k) expresados en el sistema global (I, J, K).
%
% Entradas:
%   i  - Matriz (N x 3) que representa el eje 'x' local (vector i)
%        en coordenadas globales para N frames.
%   j  - Matriz (N x 3) que representa el eje 'y' local (vector j)
%        en coordenadas globales para N frames.
%   k  - Matriz (N x 3) que representa el eje 'z' local (vector k)
%        en coordenadas globales para N frames.
%
% Salida:
%   AE - Estructura con los ángulos de Euler en GRADOS, con 'unwrap' aplicado.
%        AE.alpha: Vector (N x 1) de rotación alrededor de Z global.
%        AE.beta:  Vector (N x 1) de rotación alrededor de la línea de nodos.
%        AE.gamma: Vector (N x 1) de rotación alrededor del eje z local.
%

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
    
    %% Aplicar unwrap para evitar saltos de discontinuidad
    AE.alpha = unwrap(AE.alpha);
    AE.beta = unwrap(AE.beta);
    AE.gamma = unwrap(AE.gamma);
    
    %% Convertir a grados al final
    AE.alpha = rad2deg(AE.alpha);
    AE.beta = rad2deg(AE.beta);
    AE.gamma = rad2deg(AE.gamma);
end