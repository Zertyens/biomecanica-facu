function CrudosVsFiltrados(datos_crudos, datos_filtrados)
figure;

% Crear vector de tiempo (asumiendo que son N muestras)
N = size(datos_crudos, 1);
t = 1:N;

% Plot de las 3 componentes
for i = 1:3
    subplot(1,3,i);
    hold on;
    
    % Datos crudos en rojo
    plot(t, datos_crudos(:,i), 'r-', 'LineWidth', 1.5, 'DisplayName', 'Crudos');
    
    % Datos filtrados en azul
    plot(t, datos_filtrados(:,i), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Filtrados');
    
    xlabel('Muestras');
    ylabel(sprintf('Componente %d', i));
    title(sprintf('r\_bar\_2 - Componente %d: Crudos vs Filtrados', i));
    legend('show');
    grid on;
    hold off;
end

% Ajustar el espaciado entre subplots
sgtitle('Comparación: Datos Crudos (Rojo) vs Filtrados (Azul) - r\_bar\_2');