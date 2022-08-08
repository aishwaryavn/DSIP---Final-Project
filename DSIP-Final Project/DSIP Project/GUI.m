function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 12-Jan-2021 13:05:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
tic;

x=imread('Photo.jpg');
axes(handles.axes1);
imshow(x);

elapsed = toc;
fprintf('Elapsed time Original: %.2f sec\n', elapsed);

clear c;
a=rgb2gray(x);
b=im2double(a);

[m,n] = size(b);
A = 2;
c = zeros(m,n);
 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
tic;

x=imread('Photo.jpg');
a=rgb2gray(x);
b=im2double(a);

[m,n] = size(b);
A = 2;
c = zeros(m,n);
    for i = 2:m-1
        for j = 2:n-1
            Gx2 = (b(i+1,j-1) + b(i+1,j) + b(i+1,j+1)) - (b(i-1,j-1) + b(i-1,j) + b(i-1,j+1));
            Gy2 = (b(i-1,j+1) + b(i,j+1) + b(i+1,j+1)) - (b(i-1,j-1) + b(i,j-1) + b(i+1,j-1));
            k(i,j) = sqrt(Gx2.^2 + Gy2.^2);
        end
    end

axes(handles.axes2);
imshow(k);

title('Prewitt Derivative Filter');

elapsed = toc;
fprintf('Elapsed time Prewitt: %.2f sec\n', elapsed);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
tic;
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
I=uint8(I);

axes(handles.axes2);
imshow(I);
title('Sobel filtered Image');

elapsed = toc;
fprintf('Elapsed time Sobel: %.2f sec\n', elapsed);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
tic;

x=imread('Photo.jpg');
a=rgb2gray(x);
b=im2double(a);

[m,n] = size(b);
A = 2;
c = zeros(m,n);
for i = 2:m-1
    for j = 2:n-1
        f(i,j) = b(i,j) - c(i,j);
    end
end
 
axes(handles.axes2);
imshow(f);
title('high pass filtered image');

elapsed = toc;
fprintf('Elapsed time High pass: %.2f sec\n', elapsed);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
tic;

x=imread('Photo.jpg');
a=rgb2gray(x);
b=im2double(a);

[m,n] = size(b);
A = 2;
c = zeros(m,n);
for i = 2:m-1
    for j = 2:n-1
        c(i,j) = 1/9*(b(i-1,j-1) + b(i-1,j) + b(i-1,j+1) + b(i,j-1) + b(i,j) + b(i,j+1) + b(i+1,j-1) + b(i+1,j) + b(i+1,j+1));
    end
end


axes(handles.axes2);
imshow(c);
title('low pass filtered image');

elapsed = toc;
fprintf('Elapsed time Low pass: %.2f sec\n', elapsed);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
tic;

x=imread('Photo.jpg');
a=rgb2gray(x);
b=im2double(a);

[m,n] = size(b);
A = 2;
c = zeros(m,n);
for i = 2:m-1
    for j = 2:n-1
        Gx1 = b(i-1,j-1) - b(i,j);
        Gy1 = b(i-1,j) - b(i,j-1);
        h(i,j) = sqrt(Gx1.^2 + Gy1.^2);
    end
end

axes(handles.axes2);
imshow(h);
title('Roberts Derivative Filter');

elapsed = toc;
fprintf('Elapsed time Roberts: %.2f sec\n', elapsed);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
tic;

x=imread('Photo.jpg');
a=rgb2gray(x);
b=im2double(a);

w=edge(a,'canny');
axes(handles.axes2);
imshow(w);
title('Canny Edge Detector');

elapsed = toc;
fprintf('Elapsed time Canny: %.2f sec\n', elapsed);
