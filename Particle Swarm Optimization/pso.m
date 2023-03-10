% simulasi PSO  

% inisialisasi 
tic;
clear all;
close all;
clc;

%setting parameters
x_min = -10;
x_max = 10;
y_min = -10; 
y_max = 10;
n_partikel = 20; 
iteration = 5; 

c1 = 2.05;
c2 = 4.1-c1;
phi = c1+c2;
k = 2/abs(2-phi-sqrt(phi^2-4*phi));

% Menyusun posisi awal partikel 
for i=1:n_partikel
    Pos_x(i,1) = rand*7; %((x_max-x_min)*rand)+x_min;
    Pos_y(i,1) = rand*7; %((y_max-y_min)*rand)+y_min;
    fbest(i,1) = 1000; % Inisialisasi vektor nilai fitness terbaik dalam iterasi (vector merekam nilai fitness)
end

% Kecepatan awal anggap v awal semua = 0
velocity_x = zeros(n_partikel,1);
velocity_y = zeros(n_partikel,1);

% Masuk ke algorithme iterasi (di atas adalah algoritma penentuan kondisi awal)

for iter = 1: iteration
    iterasi = iter;

% Update posisi partikel 
for i=1:n_partikel  
    Pos_x(i,1)= Pos_x(i,1) + velocity_x(i,1)*1.5; %angka pembagiiii
    Pos_y(i,1) = Pos_y(i,1) + velocity_y(i,1)*1.5;
    % Evaluasi posisi tiap partikel ke fungsi objektif
    fitness(i,1)=(Pos_x(i,1)-15).^2 + (Pos_y(i,1)-20).^2;
end
fitness;
[fbest, baris] = min(fitness);
Pbest_x = Pos_x(baris,1);
Pbest_y = Pos_y(baris,1);
record_Pbest_x(iter,1)=Pbest_x;
record_Pbest_y(iter,1)=Pbest_y;

record_fbest(iter,1) = fbest;
[fgbest,line] = min(record_fbest);
record_fgbest(iter,1) = fgbest;

record_Pgbest_x(iter,1) = record_Pbest_x(line,1);
record_Pgbest_y(iter,1) = record_Pbest_y(line,1);

% update velocity particle
for i=1:n_partikel
    % velocity sebelumnya seharusnya dikali konstanta konvergensi k, tetapi
    % ketika k digantikan dengan rand yang terdistribusi default lebih
    % stabil
    velocity_x (i,1) = (k.*velocity_x(i,1)) + (c1.*rand.*(Pbest_x-Pos_x(i,1))) + (c2.*rand.*(record_Pgbest_x - Pos_x(i,1)));
    velocity_y (i,1) = (k.*velocity_y(i,1)) + (c1.*rand.*(Pbest_y-Pos_y(i,1))) + (c2.*rand.*(record_Pgbest_y - Pos_y(i,1)));

end

% Plotting posisi partikel 
clf
plot(15,20,'ro');
hold on 
plot(Pos_x,Pos_y,'x');
axis([-10 30 -10 30])
pause(.2)

end

figure, plot(record_fgbest);
title('Particle Swarm Optimization');
fgbest;
Pgbest_x;
Pgbest_y;
toc

   




