function im_zoom = Bicubic_interpolation(image, zoom);

%This function given the inputs 'image' & 'zoom' carries out bicubic
%interpolation on the image stored in variable 'image'. The output image will
%either be zoomed into or zoomed out of based on the magnification factor
%input into the variable 'zoom'
%'zoom' variable must be defined as a integer value, which defines the
%desired magnification factor of the image. (Preferably in the range 1-10
%as large magnification factors might cause low end systems to crash)

%Note that this function has been configured to interpolate images encoded
%in RGB mode. Attempting to interpolate gray-scale, binary or .tif file
%formats might lead to unstable outputs.

% Obtaining some required variables from the input image stored in 'image'
[r c d] = size(image);
rn = floor(zoom*r); % Multiplying the rows of img by zoom factor
cn = floor(zoom*c); % Multiplying the columns of img by zoom factor
s = zoom;
% Cast function used to convert zeroes(rn,cn,d) to the data class type int8 
im_zoom = cast(zeros(rn,cn,d),'uint8');
im_pad = zeros(r+4,c+4,d);
im_pad(2:r+1,2:c+1,:) = image;
im_pad = cast(im_pad,'double');
% For loop used to begin mapping through each one of the 16 pixels in the
% [4 x 4] environment around target pixel. For more info behind the
% algorithm being implememted take a look at the bicubic interpolation
% algorithm explained in the previous sections
for m = 1:rn
    x1 = ceil(m/s); x2 = x1+1; x3 = x2+1;
    p = cast(x1,'uint16');
    if(s>1)
       m1 = ceil(s*(x1-1));
       m2 = ceil(s*(x1));
       m3 = ceil(s*(x2));
       m4 = ceil(s*(x3));
    else
       m1 = (s*(x1-1));
       m2 = (s*(x1));
       m3 = (s*(x2));
       m4 = (s*(x3));
    end
    X = [ (m-m2)*(m-m3)*(m-m4)/((m1-m2)*(m1-m3)*(m1-m4)) ...
          (m-m1)*(m-m3)*(m-m4)/((m2-m1)*(m2-m3)*(m2-m4)) ...
          (m-m1)*(m-m2)*(m-m4)/((m3-m1)*(m3-m2)*(m3-m4)) ...
          (m-m1)*(m-m2)*(m-m3)/((m4-m1)*(m4-m2)*(m4-m3))];
    for n = 1:cn
        y1 = ceil(n/s); y2 = y1+1; y3 = y2+1;
        if (s>1)
           n1 = ceil(s*(y1-1));
           n2 = ceil(s*(y1));
           n3 = ceil(s*(y2));
           n4 = ceil(s*(y3));
        else
           n1 = (s*(y1-1));
           n2 = (s*(y1));
           n3 = (s*(y2));
           n4 = (s*(y3));
        end
        Y = [ (n-n2)*(n-n3)*(n-n4)/((n1-n2)*(n1-n3)*(n1-n4));...
              (n-n1)*(n-n3)*(n-n4)/((n2-n1)*(n2-n3)*(n2-n4));...
              (n-n1)*(n-n2)*(n-n4)/((n3-n1)*(n3-n2)*(n3-n4));...
              (n-n1)*(n-n2)*(n-n3)/((n4-n1)*(n4-n2)*(n4-n3))];
        q = cast(y1,'uint16');  % Cast function used to convert y1 to the data class type uint8 
        sample = im_pad(p:p+3,q:q+3,:); % p & q are basically x1 & y1 cast into uint8 data type
        im_zoom(m,n,1) = X*sample(:,:,1)*Y;
        if(d~=1)
              im_zoom(m,n,2) = X*sample(:,:,2)*Y;
              im_zoom(m,n,3) = X*sample(:,:,3)*Y;
        end
    end
end
% Cast function used here to convert im_zoom to the data class type int8
im_zoom = cast(im_zoom,'uint8'); % im_zoom is the required bicubic interpolated image