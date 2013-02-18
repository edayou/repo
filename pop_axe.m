function varargout = pop_axe(varargin)
% POP_AXE MATLAB code for pop_axe.fig
%      POP_AXE, by itself, creates a new POP_AXE or raises the existing
%      singleton*.
%
%      H = POP_AXE returns the handle to a new POP_AXE or the handle to
%      the existing singleton*.
%
%      POP_AXE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POP_AXE.M with the given input arguments.
%
%      POP_AXE('Property','Value',...) creates a new POP_AXE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pop_axe_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pop_axe_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pop_axe

% Last Modified by GUIDE v2.5 15-Feb-2013 15:33:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pop_axe_OpeningFcn, ...
                   'gui_OutputFcn',  @pop_axe_OutputFcn, ...
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


% --- Executes just before pop_axe is made visible.
function pop_axe_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pop_axe (see VARARGIN)

% Choose default command line output for pop_axe
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load mat.mat;%データ読み込み
axes(handles.axes1);
for i=1:1:fig_num
    plot(coefs(:,i));
    hold all;
    Leg{i,1}=[text, num2str(i)];
end
legend(Leg);
legend('show');
hleg1=legend(Leg);%handls of legend
set(hleg1,'Location','EastOutside');

axes(handles.axes3);
a = imread('hexa_orientation.tif');
[wid,hei]=size(a);
colormap(gray);
Img=image(a); 
set(gca, ...
    'Visible', 'off' ...
    ,'YDir'   ,'reverse' ...
    ,'XLim'   ,get(Img,'XData') ...
    ,'YLim'   ,get(Img,'YData')  ...
    ,'Position', [0.6 0.069 0.36/hei*wid 0.36] ....
    );
%disp(get(handles.axes3,'Position')); setで'Position'をいじってやれば大きさ変えられる？

% UIWAIT makes pop_axe wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pop_axe_OutputFcn(hObject, eventdata, handles) 
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
Co = str2double(get(handles.edit1, 'String'));
x = 0:0.01:10*pi*Co;
y = sin(x);
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(handles.axes1,x,y);
    case 2
        plot(handles.axes2,x,y);
    case 3
        plot(handles.axes1,x,y);
        plot(handles.axes2,x,y);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        axes(handles.axes1);
        cla;
    case 2
        axes(handles.axes2);
        cla;
    case 3
        cla (handles.axes1);
        cla (handles.axes2);
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として popupmenu1 の内容を返します。
%        contents{get(hObject,'Value')} は popupmenu1 から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'1', '2', '3', '4'});
