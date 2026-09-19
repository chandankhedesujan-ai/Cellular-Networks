clc;
clear all;
close all;

%% GIVEN DATA
channels = 55;              % channels per cell
Pb = 0.025;                 % blocking probability (2.5%)
Au = 0.03746;               % traffic per user (Erlangs)
city_area = 630;            % city area in km^2

% From Erlang B table (given in problem)
A = 45.9;                   % offered traffic per cell (Erlangs)

%% USERS PER CELL
users_per_cell = A / Au;

fprintf("Users per cell = %.0f\n\n", users_per_cell);

%% CELL RADII (meters)
R = [500 1000 1500];

fprintf("-------------------------------------------------\n");
fprintf("Radius(m)   Cell Area(km^2)   No. Cells   Total Users\n");
fprintf("-------------------------------------------------\n");

for i = 1:length(R)

    r_km = R(i)/1000;   % convert meter → km

    % Hexagonal cell area formula
    cell_area = (3*sqrt(3)/2) * (r_km^2);

    % Integer number of cells (NO rounding)
    num_cells = floor(city_area / cell_area);

    % Total supported users
    total_users = num_cells * users_per_cell;

    fprintf("%8d     %10.4f       %8d     %10.0f\n", ...
            R(i), cell_area, num_cells, total_users);
end

fprintf("-------------------------------------------------\n");

