function resultado = Derivar(datos, fm, orden, prefijo)
% Deriva estructuras de datos n veces
% datos: estructura con campos que contienen datos numéricos
% fm: frecuencia de muestreo
% orden: número de derivadas a calcular (1 o 2)
% prefijo: prefijo opcional para los nombres de campos de salida
    
    if nargin < 4
        prefijo = '';
    end
    
    campos = fieldnames(datos);
    
    for i = 1:length(campos)
        dato_actual = datos.(campos{i});
        
        % Si es estructura con wx, wy, wz (caso velocidades angulares)
        if isstruct(dato_actual) && isfield(dato_actual, 'wx')
            w = [dato_actual.wx, dato_actual.wy, dato_actual.wz];
            wd = diff(w, 1, 1) * fm;
            wd = [wd; 2*wd(end,:) - wd(end-1,:)];
            
            resultado.(campos{i}).alphax = wd(:,1);
            resultado.(campos{i}).alphay = wd(:,2);
            resultado.(campos{i}).alphaz = wd(:,3);
            
        % Si es matriz/vector (caso posiciones)
        else
            temp = dato_actual;
            
            % Derivar n veces
            for j = 1:orden
                temp = diff(temp, 1, 1) * fm;
            end
            
            % Extrapolar según el orden
            for k = 1:orden
                temp = [temp; 2*temp(end,:) - temp(end-1,:)];
            end
            
            nombre_campo = [prefijo campos{i}];
            resultado.(nombre_campo) = temp;
        end
    end
end