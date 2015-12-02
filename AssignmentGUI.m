function varargout = AssignmentGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AssignmentGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @AssignmentGUI_OutputFcn, ...
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


% --- Executes just before AssignmentGUI is made visible.
function AssignmentGUI_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for AssignmentGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AssignmentGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = AssignmentGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

descriptor=get(handles.text9,'String');
dataset=get(handles.text10,'String');

if strcmp(descriptor,'Euclidean Descriptor')
    if strcmp(dataset,'Clean Dataset')
        load('EDMAT_clean.mat');
        load('shapefileindex.mat');
        dataset=EDMAT_clean;
        fileind=shapefileindex;
        numberofshapes=size(dataset,1);
        infile=get(handles.text8,'String');
        inputD= Euclidian_Descriptor(infile);
        Gdist=zeros(1,numberofshapes);
    elseif strcmp(dataset,'Clean+Noisy Dataset')
        load('EDMAT_cleannoise.mat');
        load('shapefileindexnoise.mat');
        dataset=EDMAT_cleannoise;
        fileind=shapeindexnoise;
        numberofshapes=size(dataset,1);
        infile=get(handles.text8,'String');
        inputD= Euclidian_Descriptor(infile);
        Gdist=zeros(1,numberofshapes);
    elseif strcmp(dataset,'Clean+Incomplete Dataset')
        load('EDMAT_cleanincomplete.mat');
        load('shapefileincomplete.mat');
        dataset=EDMAT_cleanincomplete;
        fileind=shapefileindexincomplete;
        numberofshapes=size(dataset,1);
        infile=get(handles.text8,'String');
        inputD= Euclidian_Descriptor(infile);
        Gdist=zeros(1,numberofshapes);
    end
elseif strcmp(descriptor,'Geodesic Descriptor')
    if strcmp(dataset,'Clean Dataset')
        load('GDMAT_clean.mat');
        load('shapefileindex.mat');
        dataset=GDMAT_clean;
        fileind=shapefileindex;
        numberofshapes=size(dataset,1);
        infile=get(handles.text8,'String');
        inputD= Geodesic_Descriptor(infile,2);
        Gdist=zeros(1,numberofshapes);
    elseif strcmp(dataset,'Clean+Noisy Dataset')
        load('GDMAT_cleannoise.mat');
        load('shapefileindexnoise.mat');
        dataset=GDMAT_cleannoise;
        fileind=shapeindexnoise;
        numberofshapes=size(dataset,1);
        infile=get(handles.text8,'String');
        inputD= Geodesic_Descriptor(infile,2);
        Gdist=zeros(1,numberofshapes);
    elseif strcmp(dataset,'Clean+Incomplete Dataset')
        load('GDMAT_cleanincomplete.mat');
        load('shapefileincomplete.mat');
        dataset=GDMAT_cleanincomplete;
        fileind=shapefileindexincomplete;
        numberofshapes=size(dataset,1);
        infile=get(handles.text8,'String');
        inputD= Geodesic_Descriptor(infile,2);
        Gdist=zeros(1,numberofshapes);
    end
end

for j=1:1:numberofshapes
        Gdist(1,j)=Euclidean_distance(inputD(1,:),dataset(j,:));
end
    
    [sortGdist,index]=sort(Gdist);
    
    for j=1:1:numberofshapes
        retrieval{1,j}=fileind{index(1,j)};
    end
    %Important: To be changed to your path of the dataset
    path='C:\Users\Dishant\Documents\3D Computer Vision\Project 2 Submission\smallTOSCA\';
    input_file=strcat(path,retrieval{1,1});
    fid=fopen(input_file);
    fgetl(fid);
    nos=fscanf(fid, '%d %d %d',[3 1]);
    nopts=nos(1);
    

    coord=fscanf(fid, '%g %g %g',[3 nopts]);
    handles.coord=coord;
    axes(handles.axes1);
    axis equal;
    plot3(handles.coord(1,:),handles.coord(2,:),handles.coord(3,:));
    
    
    input_file=strcat(path,retrieval{1,1});
    fid=fopen(input_file);
    fgetl(fid);
    nos=fscanf(fid, '%d %d %d',[3 1]);
    nopts=nos(1);
    

    coord=fscanf(fid, '%g %g %g',[3 nopts]);
    handles.coord=coord;
    axes(handles.axes1);
    axis equal;
    plot3(handles.coord(1,:),handles.coord(2,:),handles.coord(3,:),'r.');
    
    input_file=strcat(path,retrieval{1,2});
    fid=fopen(input_file);
    fgetl(fid);
    nos=fscanf(fid, '%d %d %d',[3 1]);
    nopts=nos(1);
    

    coord=fscanf(fid, '%g %g %g',[3 nopts]);
    handles.coord=coord;
    axes(handles.axes2);
    axis equal;
    plot3(handles.coord(1,:),handles.coord(2,:),handles.coord(3,:),'b.');
    
    input_file=strcat(path,retrieval{1,3});
    fid=fopen(input_file);
    fgetl(fid);
    nos=fscanf(fid, '%d %d %d',[3 1]);
    nopts=nos(1);
    

    coord=fscanf(fid, '%g %g %g',[3 nopts]);
    handles.coord=coord;
    axes(handles.axes3);
    axis equal;
    plot3(handles.coord(1,:),handles.coord(2,:),handles.coord(3,:),'b.');
    
    input_file=strcat(path,retrieval{1,4});
    fid=fopen(input_file);
    fgetl(fid);
    nos=fscanf(fid, '%d %d %d',[3 1]);
    nopts=nos(1);
    

    coord=fscanf(fid, '%g %g %g',[3 nopts]);
    handles.coord=coord;
    axes(handles.axes4);
    axis equal;
    plot3(handles.coord(1,:),handles.coord(2,:),handles.coord(3,:),'b.');
    
    input_file=strcat(path,retrieval{1,5});
    fid=fopen(input_file);
    fgetl(fid);
    nos=fscanf(fid, '%d %d %d',[3 1]);
    nopts=nos(1);
    

    coord=fscanf(fid, '%g %g %g',[3 nopts]);
    handles.coord=coord;
    axes(handles.axes5);
    axis equal;
    plot3(handles.coord(1,:),handles.coord(2,:),handles.coord(3,:),'b.');
    
    input_file=strcat(path,retrieval{1,6});
    fid=fopen(input_file);
    fgetl(fid);
    nos=fscanf(fid, '%d %d %d',[3 1]);
    nopts=nos(1);
    

    coord=fscanf(fid, '%g %g %g',[3 nopts]);
    handles.coord=coord;
    axes(handles.axes6);
    axis equal;
    plot3(handles.coord(1,:),handles.coord(2,:),handles.coord(3,:),'b.');
    


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename pathname]=uigetfile({'*.off'},'File Selector');
infile=strcat(pathname,filename);
set(handles.text8,'String',infile);




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'));
set(handles.text9,'String',contents{get(hObject,'Value')});

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents1 = cellstr(get(hObject,'String'));
set(handles.text10,'String',contents1{get(hObject,'Value')});

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
