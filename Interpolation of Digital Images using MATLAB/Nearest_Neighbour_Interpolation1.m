clc;
clear all;
tic

% Store any RGB image as a matrix in A
% Works with the following images:- onion.png, football.jpg, greens,jpg,
% hestain.png, office_3.jpg, & fabric.png
im=imread('onion.png');

% Define the desired Re-sample size
out_dims=[512 512];

% Obtain the Nearest Neighbour Interpolated Image using the function 'Nearest_Neighbour_Interpolation' 
Interpolated_Img = Nearest_Neighbour_Interpolation(im, out_dims);

% Plotting Original Image (Before Interpolation)
figure;
subplot(121)
imshow(im);
title('Original Image');
ylabel('Image Height (px)')
xlabel('Image Width (px)')
axis([0,512,0,512]);
axis on;

% Plotting the Nearest Neighbour Interpolated Image (After Interpolation)
subplot(122)
imshow(Interpolated_Img)
title('Nearest Neighbour Interpolated Image');
ylabel('Image Height (px)')
xlabel('Image Width (px)')
axis([0,512,0,512]);
axis on;

toc