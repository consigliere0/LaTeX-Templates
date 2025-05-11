clear all; close all;
format long g

%% Codi MATLAB per introduir manualment dos vectors de dades

disp('Introduce the vector containing the white card data.');
white = input('White card vector: ');
if ~isnumeric(white) || isempty(white)
    error('Non-valid vector. Write commas or spaces between elements.');
end

disp('Introduce the vector containing the unknown card data.');
unknown = input('Unknown card vector: ');
if ~isnumeric(unknown) || isempty(unknown)
    error('Non-valid vector. Write commas or spaces between elements.');
end

%% Data processing
% Colour cards before normalitzation
red = [62 369 3135 6794 41];
orange = [53 273 1320 2145 39];
yellow = [50 254 1013 1218 22];
green = [211 1570 5260 5062 28];
blue = [206 1497 5456 5720 12];
black = [397 2363 9449 12697 53];

colors = zeros(7,5);
colors(1,:) = red;
colors(2,:) = orange;
colors(3,:) = yellow;
colors(4,:) = green;
colors(5,:) = blue;
colors(6,:) = black;
colors(7,:) = unknown;

colors_norm = zeros(7,5);
ilum_matrix = zeros(7,5);
sat_matrix = zeros(7,5);

for i=1:7
    % Normalization
    colors_norm(i,:) = white ./ colors(i,:);

    % Brightness
    j=1;
    avg_color = (colors_norm(i,j)+colors_norm(i,j+1)+colors_norm(i,j+2)+colors_norm(i,j+3)+colors_norm(i,j+4))/5;
        
    for k=1:5
        ilum_matrix(i,k) = colors_norm(i,k)/avg_color;
    end

    % Saturation
    a = min(ilum_matrix(i,:));
    for k=1:5
        sat_matrix(i,k)=ilum_matrix(i,k)-a;
    end
end

% Norm
norm_vec = [];
for i=1:6
    b = sat_matrix(i,:);
    d = sat_matrix(7,:);
    
    comp_vec = b - d;
    norma = sqrt(comp_vec(1)^2+comp_vec(2)^2+comp_vec(3)^2+comp_vec(4)^2+comp_vec(5)^2);
    norm_vec = [norm_vec norma];
end
norm_vec'