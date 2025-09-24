function GraficarSistemasCoordenadas(SL, CM, config_general)
    % Grafica sistemas de coordenadas específicos usando graficar_vectores
    % Parámetros:
    %   SL              - Estructura con todos los vectores (i1,j1,k1,i2,j2,k2,etc.)
    %   CM              - Estructura con todos los centros de masa (p_RThigh, p_LThigh, etc.)
    %   config_general  - Configuración general (Titulo, Frecuencia, etc.)
    
    % Valores por defecto
    if ~isfield(config_general, 'Titulo'), config_general.Titulo = 'Sistemas de Coordenadas Corporales'; end
    if ~isfield(config_general, 'Frecuencia'), config_general.Frecuencia = 10; end
    if ~isfield(config_general, 'MostrarOrigen'), config_general.MostrarOrigen = true; end
    if ~isfield(config_general, 'EscalaVectores'), config_general.EscalaVectores = 1.0; end  % Escala por defecto
    
    % Graficar cada sistema con su correspondencia específica
    graficar_sistema('Pelvis', 'i_pelv', 'j_pelv', 'k_pelv', {'r', 'g', 'b'});
    graficar_sistema('p_RThigh', 'i1', 'j1', 'k1', {'r', 'g', 'b'});   % Muslo derecho
    graficar_sistema('p_LThigh', 'i2', 'j2', 'k2', {'r', 'g', 'b'});   % Muslo izquierdo
    graficar_sistema('p_RCalf', 'i3', 'j3', 'k3', {'r', 'g', 'b'});    % Pierna derecha
    graficar_sistema('p_LCalf', 'i4', 'j4', 'k4', {'r', 'g', 'b'});    % Pierna izquierda
    graficar_sistema('p_RFoot', 'i5', 'j5', 'k5', {'r', 'g', 'b'});    % Pie derecho
    graficar_sistema('p_LFoot', 'i6', 'j6', 'k6', {'r', 'g', 'b'});    % Pie izquierdo
    
    % ========== FUNCIÓN AUXILIAR PARA SIMPLIFICAR ==========
    function graficar_sistema(nombre_cm, vec_i, vec_j, vec_k, colores)
        % Preparar vectores (aplicar escala)
        escala = config_general.EscalaVectores;
        vectores.u = SL.(vec_i) * escala;
        vectores.v = SL.(vec_j) * escala;
        vectores.w = SL.(vec_k) * escala;
        
        % Configurar colores y etiquetas
        config = config_general;
        config.ColorU = colores{1};
        config.ColorV = colores{2};
        config.ColorW = colores{3};
        config.EtiquetaO = ['CM\_' nombre_cm];
        config.EtiquetaU = [nombre_cm '\_i'];
        config.EtiquetaV = [nombre_cm '\_j'];
        config.EtiquetaW = [nombre_cm '\_k'];
        
        % Graficar
        graficar_vectores(CM.(nombre_cm), vectores, config);
    end
end