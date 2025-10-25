function resultado = Derivar(datos, fm, orden, prefijo)
% Deriva estructuras de datos usando DIFERENCIAS CENTRALES
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
            wd = derivada_central(w, fm);
            
            resultado.(campos{i}).alphax = wd(:,1);
            resultado.(campos{i}).alphay = wd(:,2);
            resultado.(campos{i}).alphaz = wd(:,3);
            
        % Si es matriz/vector (caso posiciones)
        else
            temp = dato_actual;
            
            % Derivar n veces con diferencias centrales
            for j = 1:orden
                temp = derivada_central(temp, fm);
            end
            
            nombre_campo = [prefijo campos{i}];
            resultado.(nombre_campo) = temp;
        end
    end
end

function deriv = derivada_central(x, fm)
% Calcula la derivada usando diferencias centrales
% x: matriz N x M (N puntos, M columnas)
% fm: frecuencia de muestreo
% deriv: matriz N x M

    [n_filas, n_cols] = size(x);
    deriv = zeros(n_filas, n_cols);
    
    % Diferencias centrales para puntos interiores
    for n = 2:(n_filas-1)
        deriv(n,:) = (x(n+1,:) - x(n-1,:)) * fm / 2;
    end
    
    % Extrapolar primer y último punto
    deriv(1,:) = deriv(2,:);
    deriv(end,:) = deriv(end-1,:);
end