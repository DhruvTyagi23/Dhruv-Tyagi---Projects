function [Output] = Nearest_Neighbour_Interpolation(im, out_dims)

%This function given the Inputs 'A' & 'out_dims' performs Nearest Neighbour
%Interpolation & zooms into or out of based on the input 'out_dims'. Input
%'A' must be a image stored as a matrix using preferably the 'imread'
%function. %'out_dims' variable must be defined as a [1x2] matrix with the
%two elements of this matrix defining the new height & the new width of the
%desired image, respectively.
%Note that this function only interpolates images that are in RGB mode, so
%certain images such as .tif format images do not work with this function

% Obtain the no. of Rows/Columns (or Height/Width) of the desired
% interpolated image
Row = out_dims(1);
Col = out_dims(2);

% Computing the Ratio's of the New Size to the Old Size
rtR = Row/size(im,1);
rtC = Col/size(im,2);

% Obtain the Interpolated Positions
IR = ceil([1:(size(im,1)*rtR)]./(rtR));
IC = ceil([1:(size(im,2)*rtC)]./(rtC));

% Now each channel Red, Green, & Blue of the RGB image are interpolated
% seperately as done below.

% RED CHANNEL 
Temp= im(:,:,1);
% Row-Wise Interpolation
Red = Temp(IR,:);
% Columnwise Interpolation
Red = Red(:,IC);


% GREEN CHANNEL
Temp= im(:,:,2);
% Row-Wise Interpolation
Green = Temp(IR,:);
% Columnwise Interpolation
Green = Green(:,IC);


% BLUE CHANNEL
Temp= im(:,:,3);
% Row-Wise Interpolation
Blue = Temp(IR,:);
% Columnwise Interpolation
Blue = Blue(:,IC);

% The interpolated values are initialized back into the target 'output'
% variable where we want to obtain the Nearest neighbourhood interpolated
% image.
Output=zeros([Row,Col,3]);
Output(:,:,1)=Red;
Output(:,:,2)=Green;
Output(:,:,3)=Blue;

%uint8 function used to turn variable 'Output' into uint8 format
Output = uint8(Output);

end

