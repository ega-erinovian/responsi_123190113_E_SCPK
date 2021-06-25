function varargout = responsi_SAW(varargin)
% RESPONSI_SAW MATLAB code for responsi_SAW.fig
%      RESPONSI_SAW, by itself, creates a new RESPONSI_SAW or raises the existing
%      singleton*.
%
%      H = RESPONSI_SAW returns the handle to a new RESPONSI_SAW or the handle to
%      the existing singleton*.
%
%      RESPONSI_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SAW.M with the given input arguments.
%
%      RESPONSI_SAW('Property','Value',...) creates a new RESPONSI_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before responsi_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to responsi_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help responsi_SAW

% Last Modified by GUIDE v2.5 25-Jun-2021 15:31:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @responsi_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @responsi_SAW_OutputFcn, ...
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


% --- Executes just before responsi_SAW is made visible.
function responsi_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to responsi_SAW (see VARARGIN)

% Choose default command line output for responsi_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes responsi_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = responsi_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%import data dari file excel
tabel = readmatrix('DATA RUMAH.xlsx');
noR = tabel(:,1);
data = tabel(:,3:8);
dataR = [noR data];
set(handles.uitable1,'data',dataR);
disp(data);

%atribut tiap-tiap kriteria
k = [0,1,1,1,1,1];

%bobot tiap-tiap kriteria
w=[0.30,0.20,0.23,0.10,0.07,0.10];

%tahapan 1. normalisasi matriks
%matriks m x n dengan ukuran sebanyak variabel x (input)
[m n]=size (data);

%membuat matriks R, yang merupakan matriks kosong
R=zeros (m,n);

%membuat matriks Y, yang merupakan titik kosong
Y=zeros (m,n);

%statement untuk kriteria dengan atribut keuntungan
for j=1:n
    if k(j)==1 %statement untuk kriteria dengan atribut keuntungan
         R(:,j)=data(:,j)./max(data(:,j));
    else
        R(:,j)=min(data(:,j))./data(:,j);
    end
end

%proses perangkingan
for i=1:m
    V(i,:)= sum(w.*R(i,:));
end

V=[noR V];
hasil = sortrows(V, 2,'descend');
rank = hasil(1:20, :);

set(handles.uitable3,'data',rank);


% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
