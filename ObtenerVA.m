function VA = ObtenerVA(alpha, beta, gamma, fm)
    %% Calculo de las derivadas
    wa = diff(alpha)*fm;
    wb = diff(beta)*fm;
    wg = diff(gamma)*fm;
    
    % Extrapolación lineal del último valor
    wa = [wa; 2*wa(end) - wa(end-1)];
    wb = [wb; 2*wb(end) - wb(end-1)];
    wg = [wg; 2*wg(end) - wg(end-1)];
    
    %% Calculo de la velocidad
    VA.wx = wa .* sind(beta) .* sind(gamma) + wb .* cosd(gamma);
    VA.wy = wa .* sind(beta) .* cosd(gamma) - wb .* sind(gamma);
    VA.wz = wa .* cosd(beta) + wg;
    
end