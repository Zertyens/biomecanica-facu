function VA = ObtenerVA(alpha, beta, gamma, fm)
% VA = ObtenerVA(alpha, beta, gamma, fm) calcula la velocidad angular (w)
% del segmento en el sistema de coordenadas local.
%
% Esta función transforma las tasas de cambio de los ángulos de Euler
% (calculadas por diferencias finitas) a la velocidad angular del cuerpo
% [wx, wy, wz] usando la matriz de transformación estándar.
%
% Entradas:
%   alpha - Vector (N x 1) del ángulo de Euler alpha (Precesión) en GRADOS.
%   beta  - Vector (N x 1) del ángulo de Euler beta (Nutación) en GRADOS.
%   gamma - Vector (N x 1) del ángulo de Euler gamma (Spin) en GRADOS.
%   fm    - Escalar. Frecuencia de muestreo (en Hz) para calcular la
%           derivada de los ángulos (ej. 100).
%
% Salida:
%   VA    - Matriz (N x 3) de la velocidad angular [wx, wy, wz] expresada
%           en el sistema de coordenadas global, en GRADOS/SEGUNDO.
%

    %% Calculo de las derivadas
    wa = diff(alpha)*fm;
    wb = diff(beta)*fm;
    wg = diff(gamma)*fm;
    
    % Extrapolación lineal del último valor
    wa = [wa; 2*wa(end) - wa(end-1)];
    wb = [wb; 2*wb(end) - wb(end-1)];
    wg = [wg; 2*wg(end) - wg(end-1)];
    
    %% Calculo de la velocidad angular como matriz Nx3
    VA = [wa .* sind(beta) .* sind(gamma) + wb .* cosd(gamma), ...
          wa .* sind(beta) .* cosd(gamma) - wb .* sind(gamma), ...
          wa .* cosd(beta) + wg];
    
end