tic
clc
clear all
close all
warning off

% c=webcam;
% x=c.snapshot;

x=imread('Photo.jpg');
imshow(x);
clear c;
a=rgb2gray(x);
% subplot(1,3,1);
imshow(x);
title('Original Image');

% subplot(1,3,2);
w=edge(a,'canny');
imshow(w);
title('Canny Operation');

b=im2double(w);

[m,n] = size(b);
A = 2;
c = zeros(m,n);
for i = 2:m-1
    for j = 2:n-1
        c(i,j) = 1/9*(b(i-1,j-1) + b(i-1,j) + b(i-1,j+1) + b(i,j-1) + b(i,j) + b(i,j+1) + b(i+1,j-1) + b(i+1,j) + b(i+1,j+1));
        f(i,j) = b(i,j) - c(i,j);
        g(i,j) = (A - 1)*b(i,j) + f(i,j);
        
        Gx1 = b(i-1,j-1) - b(i,j);
        Gy1 = b(i-1,j) - b(i,j-1);
        h(i,j) = sqrt(Gx1.^2 + Gy1.^2);
        
        Gx2 = (b(i+1,j-1) + b(i+1,j) + b(i+1,j+1)) - (b(i-1,j-1) + b(i-1,j) + b(i-1,j+1));
        Gy2 = (b(i-1,j+1) + b(i,j+1) + b(i+1,j+1)) - (b(i-1,j-1) + b(i,j-1) + b(i+1,j-1));
        k(i,j) = sqrt(Gx2.^2 + Gy2.^2);
        
        Gx3 = (b(i+1,j-1) + 2*b(i+1,j) + b(i+1,j+1)) - (b(i-1,j-1) + 2*b(i-1,j) + b(i-1,j+1));
        Gy3 = (b(i-1,j+1) + 2*b(i,j+1) + b(i+1,j+1)) - (b(i-1,j-1) + 2*b(i,j-1) + b(i+1,j-1));
        l(i,j) = sqrt(Gx3.^2 + Gy3.^2);
    end
end

%Input Image

A=imread('Photo.jpg');

% A=c.snapshot;

%Preallocate the matrices with zeros
I=zeros(size(A));


%Filter Masks
F1=[-1 0 1;-2 0 2; -1 0 1];
F2=[-1 -2 -1;0 0 0; 1 2 1];

A=double(A);


for i=1:size(A,1)-2
    for j=1:size(A,2)-2
        %Gradient operations
        Gx=sum(sum(F1.*A(i:i+2,j:j+2)));
        Gy=sum(sum(F2.*A(i:i+2,j:j+2)));
               
        %Magnitude of vector
         I(i+1,j+1)=sqrt(Gx.^2+Gy.^2);
       
    end
end

% figure(8),imshow('Photo.jpg');

figure(8),imshow('Photo.jpg');

I=uint8(I);
figure(7),imshow(I);
title('Sobel filtered Image');

figure(1),imshow(c); 
title('low pass filtered image');

figure(2),imshow(f); 
title('high pass filtered image');

figure(3),imshow(g); 
title('High Boost Image');

figure(4),imshow(h); 
title('Roberts Derivative Filter');

figure(5),imshow(k); 
title('Prewitt Derivative Filter');

figure(6),imshow(l); 
title('Sobel Derivative Filter');

toc