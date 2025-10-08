function VAd = ObtenerVAd(VA, fm)
% Calcula aceleraciones angulares derivando las velocidades angulares
    campos = fieldnames(VA);
    
    for i = 1:length(campos)
        seg = VA.(campos{i});
        w = [seg.wx, seg.wy, seg.wz];  % Matriz Nx3
        wd = diff(w, 1, 1) * fm;  % N-1 filas
        wd = [wd; 2*wd(end,:) - wd(end-1,:)];  % Extrapola última fila
        
        VAd.(campos{i}).wdx = wd(:,1);
        VAd.(campos{i}).wdy = wd(:,2);
        VAd.(campos{i}).wdz = wd(:,3);
    end
end