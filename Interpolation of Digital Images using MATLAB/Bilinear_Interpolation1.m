clc;
clear all;
tic

% Store any RGB image as a matrix in 'im'
% Works with the following images:- onion.png, football.jpg, cameraman.tif,
% hestain.png, coins.png, office_3.jpg, & fabric.png
im = imread('hestain.png'); 

% Define the desired Re-sample size
out_dims = [512 512];

% Obtain the Bilinear Interpolated Image using the function 'Bilinear_Interpolation' 
out = Bilinear_Interpolation(im, out_dims);

% Plotting Original Image (Before Interpolation)
figure;
subplot(1,2,1)
imshow(im);
title('Original Image');
ylabel('Image Height (px)')
xlabel('Image Width (px)')
axis([0,512,0,512]);
axis on;

% Plotting the Bilinearly Interpolated Image (After Interpolation)
subplot(1,2,2)
imshow(out);
title('Bilinear Interpolated Image');
ylabel('Image Height (px)')
xlabel('Image Width (px)')
axis([0,512,0,512]);
axis on;

toc