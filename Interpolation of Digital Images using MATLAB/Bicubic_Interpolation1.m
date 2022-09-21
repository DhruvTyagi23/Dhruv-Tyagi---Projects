clc;
clear all;
tic

% Store any RGB image as a matrix in variable 'image'
% Works with the following images:- onion.png, football.jpg, cameraman.tif,
% hestain.png, coins.png, office_3.jpg, & fabric.png
image = imread('cameraman.tif');

% Define the desired magnification factor in variable im_zoom
im_zoom = Bicubic_Interpolation(image,2);

% Plotting Original Image (Before Interpolation)
figure;
subplot(1,2,1)
imshow(image);
title('Original Image');
ylabel('Image Height (px)')
xlabel('Image Width (px)')
axis([0,512,0,512]);
axis on;

% Plotting the Bilinearly Interpolated Image (After Interpolation)
subplot(1,2,2)
imshow(im_zoom);
title('Bicubic Interpolated Image');
ylabel('Image Height (px)')
xlabel('Image Width (px)')
axis([0,512,0,512]);
axis on;

toc
