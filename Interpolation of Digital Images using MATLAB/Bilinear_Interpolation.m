function [out] = Bilinear_Interpolation(im, out_dims)

%This function given the inputs 'im' & 'out_dims' carries out bilinear
%interpolation on the image stored in variable 'im'. The output image will
%either be zoomed into or zoomed out of based on the dimensions specified
%by the user in the input variable 'out_dims'.
%'out_dims' variable must be defined as a [1x2] matrix with the
%two elements of this matrix defining the new height & the new width of the
%desired image, respectively.

%Note that this interpolation algorithm has been configured to work with
%RGB images, attempting to use this function with tagged image file
%formats such as .tif might lead to ustable results.

    % Obtaining required variables
    in_rows = size(im,1); %No. of Rows of the Image
    in_cols = size(im,2); %No. of columns of the Image
    out_rows = out_dims(1); %No. of Rows desired in Interpolated Image
    out_cols = out_dims(2); %No. of columns desired in Interpolated Image

    % Let S_R = R / R'        
    S_R = in_rows / out_rows; %Ratio of Rows of original Image:Rows of Interpolated Image 
    % Let S_C = C / C'
    S_C = in_cols / out_cols; %Ratio of Columns of original Image: Columns of Interpolated Image

    % Define grid of co-ordinates in our image
    % Generate (x,y) pairs for each point in our image
    % Creating a meshgrid from the desired dimensions of the interpolated
    % image
    [cf, rf] = meshgrid(1 : out_cols, 1 : out_rows);

    % Let r_f = r'*S_R for r = 1,...,R'
    % Let c_f = c'*S_C for c = 1,...,C'
    rf = rf * S_R;
    cf = cf * S_C;

    % Let r = floor(rf) and c = floor(cf)
    % Floor used to rounds the elements to the nearest integers less than
    % or equal to rf/cf
    r = floor(rf);
    c = floor(cf);
    
    % Any values out of range, cap
    % Since we dont want any 2D grid coordinates to extend beyond orginal
    % image dim.
    r(r < 1) = 1;
    c(c < 1) = 1;
    r(r > in_rows - 1) = in_rows - 1;
    c(c > in_cols - 1) = in_cols - 1;

    % Let delta_R = rf - r and delta_C = cf - c
    delta_R = rf - r; %// Unfloored Values - Floored & Capped Values
    delta_C = cf - c;

    % Final line of algorithm
    % Get column major indices for each point we wish
    % to access
    % The sub2ind command determines the equivalent single index
    % corresponding to a set of subscript values. IND = sub2ind(siz,I,J)
    % returns the linear index equivalent to the row and column subscripts
    % I and J for a matrix of size siz.
    in1_ind = sub2ind([in_rows, in_cols], r, c);
    in2_ind = sub2ind([in_rows, in_cols], r+1,c);
    in3_ind = sub2ind([in_rows, in_cols], r, c+1);
    in4_ind = sub2ind([in_rows, in_cols], r+1, c+1);       

    % Now interpolation process begins
    % Go through each channel for the case of 3 different colour channels
    % Create output image that is the same class as input
    out = zeros(out_rows, out_cols, size(im, 3));
    out = cast(out, class(im)); %The cast function converts out to the data type of im (data type of im= class(im))
    
    for idx = 1 : size(im, 3) % size(im, 3)=3 since RGB has 3 corresponding modes/channels
        chan = double(im(:,:,idx)); % Get i'th channel (This gives the matrix corresponding to R,G & B channels)
        % Also, double here is used to convert to double precision
% Interpolate the channel
        tmp = chan(in1_ind).*(1 - delta_R).*(1 - delta_C) + ...
                       chan(in2_ind).*(delta_R).*(1 - delta_C) + ...
                       chan(in3_ind).*(1 - delta_R).*(delta_C) + ...
                       chan(in4_ind).*(delta_R).*(delta_C);
        out(:,:,idx) = cast(tmp, class(im));
    end
