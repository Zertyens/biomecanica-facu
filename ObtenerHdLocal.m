function Hd = ObtenerHdLocal(I, VA, aA)
%   Hd = ObtenerHdLocal(I, VA, aA) calcula H_dot basándose en
%   las ecuaciones de Euler (B.82, B.83, B.84) proporcionadas.
%
%   Entradas:
%     VA - Estructura con campos de velocidad angular (N x 3).
%     aA - Estructura con campos de aceleración angular (N x 3).
%     I  - Estructura con matrices de inercia (3 x 3).
%
%   Salida:
%     H  - Estructura con los resultados de H_dot (N x 3).
%

    % Inicializar la estructura de salida
    Hd = struct();
    
    % Definir los segmentos y lados a procesar
    segmentosBase = {'muslo', 'pierna', 'pie'};
    lados = {'D', 'I'}; % Derecho e Izquierdo
    
    % Iterar sobre cada segmento y lado (esto es para los campos del struct,
    % el cálculo interno es vectorizado).
    for s = 1:length(segmentosBase)
        for l = 1:length(lados)
            
            % Nombre del campo en VA y aA (ej. "musloD")
            campoSegmento = [segmentosBase{s}, lados{l}];
            
            % Nombre del campo en I (ej. "muslo")
            campoInercia = segmentosBase{s};
            
            % --- Extracción de Datos ---
            
            % Obtener matrices N x 3 de velocidad y aceleración angular
            % omega = [wx, wy, wz] (N x 3)
            % omega_dot = [ax, ay, az] (N x 3)    
            omega = VA.(campoSegmento) * pi/180;      % deg/s → rad/s
            omega_dot = aA.(campoSegmento) * pi/180;   % deg/s² → rad/s²
            
            % Obtener la matriz de inercia 3x3
            I_matrix = I.(campoInercia);
            
            % --- Mapeo Crucial de Inercias ---
            % Se crea un vector 1x3 de inercias principales (Ix, Iy, Iz)
            % basándonos en la asignación de las ecuaciones B.82-B.84 y
            % tu definición de Iii, Ijj, Ikk.
            %
            % Eq. B.82 (Eje x) usa I_IntExt -> Iii -> I(1,1)
            % Eq. B.83 (Eje y) usa I_FlxExt -> Ikk -> I(3,3)
            % Eq. B.84 (Eje z) usa I_AbdAdd -> Ijj -> I(2,2)
            
            I_vec = [I_matrix(1,1), I_matrix(2,2), I_matrix(3,3)];
            
            % --- Cálculo Vectorizado (Ecuaciones de Euler) ---
            % H = I * omega_dot + cross(omega, I * omega)
            
            % Término 1: I * omega_dot
            % (Multiplicación elemento a elemento usando broadcasting)
            termino_aceleracion = omega_dot .* I_vec;
            
            % Término 2: cross(omega, I * omega)
            % Primero calculamos (I * omega)
            I_omega = omega .* I_vec;
            
            % Luego el producto cruz giroscópico
            % cross(A, B, 2) calcula el producto cruz fila por fila
            termino_giroscopico = cross(omega, I_omega, 2);
            
            % Resultado final para este segmento
            Hd.(campoSegmento) = termino_aceleracion + termino_giroscopico;
            
        end
    end
end