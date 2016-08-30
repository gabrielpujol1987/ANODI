function varargout = front_form(varargin)
% FRONT_FORM M-file for front_form.fig
%      FRONT_FORM, by itself, creates a new FRONT_FORM or raises the existing
%      singleton*.
%
%      H = FRONT_FORM returns the handle to a new FRONT_FORM or the handle to
%      the existing singleton*.
%
%      FRONT_FORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRONT_FORM.M with the given input arguments.
%
%      FRONT_FORM('Property','Value',...) creates a new FRONT_FORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before front_form_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to front_form_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help front_form

% Last Modified by GUIDE v2.5 15-Jul-2016 17:12:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @front_form_OpeningFcn, ...
                   'gui_OutputFcn',  @front_form_OutputFcn, ...
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



% --- Executes just before front_form is made visible.
function front_form_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to front_form (see VARARGIN)

% Choose default command line output for front_form
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes front_form wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = front_form_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in btn_load_training_image.
function btn_load_training_image_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_training_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fileName_TI path_TI fullPath_TI

% [fileName_TI,path_TI] = uigetfile('*.bmp|*.sgems','Select the Training Image file');
[fileName_TI,path_TI] = uigetfile('*.*','All supported files');
fullPath_TI = [path_TI fileName_TI];

if ~(path_TI == 0)
    t = findobj('Tag', 'text9');
    set(t, 'string', fileName_TI);
    
% 	A = imread(fullPath_TI);
	A = read_eas_sq(fullPath_TI);		% read the TI
%     image(A);

    theAxe = findobj('Tag', 'axes1');
    
    set(theAxe,'visible','on') %hide the current axes
    set(get(theAxe,'children'),'visible','on') %hide the current axes contents
    
    axes(theAxe);

    
    
    imshow(A);
    
end




% --- Executes on button press in btn_load_algorithm_1.
function btn_load_algorithm_1_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_algorithm_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path_TI path_A1

if ~(path_TI == 0)
	path_A1 = uigetdir(path_TI);
else
	path_A1 = uigetdir();
end

if ~(path_A1 == 0)
    t = findobj('Tag', 'text2');
    set(t, 'string', ExtractNameFromPath(path_A1));
end



% --- Executes on button press in btn_load_algorithm_2.
function btn_load_algorithm_2_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_algorithm_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path_TI path_A2

if ~(path_TI == 0)
	path_A2 = uigetdir(path_TI);
else
	path_A2 = uigetdir();
end

if ~(path_A2 == 0)
    t = findobj('Tag', 'text3');
    set(t, 'string', ExtractNameFromPath(path_A2));
end



% --- Executes on button press in btn_load_algorithm_3.
function btn_load_algorithm_3_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_algorithm_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path_TI path_A3

if ~(path_TI == 0)
	path_A3 = uigetdir(path_TI);
else
	path_A3 = uigetdir();
end

if ~(path_A3 == 0)
    t = findobj('Tag', 'text4');
    set(t, 'string', ExtractNameFromPath(path_A3));
end


function name = ExtractNameFromPath(path)
    [~,name,~] = fileparts(path);
    



function edit_pattern_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pattern_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pattern_size as text
%        str2double(get(hObject,'String')) returns contents of edit_pattern_size as a double



% --- Executes during object creation, after setting all properties.
function edit_pattern_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pattern_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_about.
function btn_about_Callback(hObject, eventdata, handles)
% hObject    handle to btn_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox({'Application developed by' 
	'Gabriel Santiago Pujol Farina'
	'gfarina@inf.puc-rio.br'
	'gabrielpujol87@gmail.com'
	'Department of Informatics, PUC-Rio,'
	'Rio de Janeiro, Brazil'
	'Special thanks to github.com/SCRFpublic/ANODI'
	}, 'About','help');



% --- Executes on button press in btn_process_images.
function btn_process_images_Callback(hObject, eventdata, handles)
% hObject    handle to btn_process_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path_A1 path_A2 path_A3 fullPath_TI %path_TI fileName_TI 

%% Pattern Size:
% get the pattern size, from the Edit Text control.
hEditPatt = findobj('Tag', 'edit_pattern_size');
str_pat_size = get(hEditPatt,'String');


% validating the Pattern Size
if isempty(str2num(str_pat_size))
    set(hEditPatt,'string','0');
    warndlg('Input must be numerical');
elseif (~isequal(fullPath_TI,zeros(1,2)) && ~isempty(path_A1) && ~isempty(path_A2))
    pattern_size = str2num(str_pat_size);
    
    if pattern_size < 2
        warndlg('The pattern size must be at least 2s');
    else
        Process_Paths_Gabriel(fullPath_TI, pattern_size, path_A1, path_A2, path_A3);    
    end
    
end


% --- Executes on button press in btn_go_debug.
function btn_go_debug_Callback(hObject, eventdata, handles)
% hObject    handle to btn_go_debug (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% original path!!!
% lePath = 'C:\Users\gfarina\Dropbox\De la Universidad\2015.2\Investigación Laber\Distance Functions and Ranking\!ANODI! - Matlab\ComparingGSAlgorithms\DataCSV\';
% secondary path!
lePath = 'C:\Users\gfarina\Desktop\Realizations\ti_strebelle.sgems\';


path_A1 = [lePath 'CSV1'];
path_A2 = [lePath 'CSV2'];
path_A3  = [lePath 'CSV3'];
% fullPath_TI = [lePath 'strebelle 101x101 BW.bmp'];
fullPath_TI = [lePath 'ti_strebelle.sgems'];

hEditPatt = findobj('Tag', 'edit_pattern_size');
str_pat_size = get(hEditPatt,'String');
pattern_size = str2num(str_pat_size);
pattern_size = 20;

% Process_Paths_Gabriel(fullPath_TI, pattern_size, path_A1, path_A2, path_A3);    
Process_Paths_Gabriel(fullPath_TI, pattern_size, path_A1, path_A2);%, path_A3);    



