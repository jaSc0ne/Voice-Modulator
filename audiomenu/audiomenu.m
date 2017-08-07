function audiomenu()

global tbox_rectime tbox_shift hs_rectime hs_shift;

global b_audio_text

global workpath workpath_new
workpath = pwd; %this defines the path in which the core files are stored. It should be defined here only.

%globals related to the function 'thecallback' which calls function audio_run



global menupage
menupage = figure('menubar','figure','toolbar','none');
set(menupage,'deletefcn','close_audiomenu');
drawnow;

%set(menupage,'position',[3 13 800 553]);
%drawnow;  %this is placed here otherwise title screen goes crazy.

set(menupage,'tag','menu');
%s21edit = figure;
%s11edit = figure;


%figure(menupage);
b_record = uicontrol;
b_play = uicontrol;



bt_close_audiomenu = uicontrol;

set(bt_close_audiomenu,'style', 'pushbutton','units','normalized','position',[0.91 0.0 0.09 0.05]); %set units used to reference position information
% position information has format : [left_X,lower_Y,width_X,height_Y]
set(bt_close_audiomenu,'string','Close'); %set the text to appear in the button
set(bt_close_audiomenu,'callback', 'close_audiomenu'); %callback for the button 'h'


x1 = 0.20; y1 = 0.800; gap1 = 0.05; %for label boxes
x2 = 0.50; y2 = y1; gap2 = 0.05; %for text box to display results

%-------------

% header boxes
h_record_time = uicontrol('tag','record_time_header','style','text','units','normalized','position',[0.15 0.16        0.13 0.03],'string','record time (s)','HorizontalAlignment','left');
h_Fs_offset = uicontrol('tag','Fs_offset_header','style','text','units','normalized','position',[0.33 0.16        0.13 0.03],'string','Fs offset (%)','HorizontalAlignment','left');

% text boxes

b_audio_text = uicontrol('tag','audio_text','style','text','units','normalized','position',[x2 y2        0.25 0.03],'string','No Recorded Data Yet ','HorizontalAlignment','right');



%-------------

%label boxes

b_audio_label = uicontrol('tag','audio_label','style','text','units','normalized','position',[x1 y1        0.25 0.03],'string','buffer status:','HorizontalAlignment','left');



%-------------

set(b_record,'style', 'pushbutton','units','normalized','position',[0.0 0.0 0.1 0.05]); %set units used to reference position information
% position information has format : [left_X,lower_Y,width_X,height_Y]
set(b_record,'string','a_record'); %set the text to appear in the button
set(b_record,'callback', 'a_record'); %callback for the button 'a_record' - audio record


set(b_play,'style', 'pushbutton','units','normalized','position',[0.5 0.0 0.1 0.05]); %set units used to reference position information
% position information has format : [left_X,lower_Y,width_X,height_Y]
set(b_play,'string','a_play'); %set the text to appear in the button
set(b_play,'callback', 'a_play'); %callback for the button 'a_play' - audio play


%wmax(menupage);

set(menupage,'Renderer','painters','DoubleBuffer','on')
%set(menupage,'position',[1 29 800 534]);


%set(menupage,'toolbar','none');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SLIDERS
hs_rectime=uicontrol;  %handle for record time slider
hs_shift=uicontrol;  %handle for pitch shift slider

%hui=findobj('type','uicontrol');
%get(hui)

maxrec = 60;
minrec = 1;
length_setting_maxrec = maxrec - minrec;
set(hs_rectime,'style','slider');
set(hs_rectime,'units','normalized','position',[0.15 0.0 0.15 0.05]);  %3rd val controls x-width; 1st value controls x location
set(hs_rectime,'min',minrec,'max',length_setting_maxrec,'value',10); %last value is initial value of slider
set(hs_rectime,'sliderstep',[1/(length_setting_maxrec-1) 1/(length_setting_maxrec-1)*5]);  %increments when click on arrows, or click on parts between the arrows and the sliding square; first value graphical movement for single clicks, while second value graphical movement for large steps associated with using the mouse to bump the slider along. 
set(hs_rectime,'callback', 'call_slidervalue_rec');


maxshift = 30;
minshift = -20;
length_setting_maxshift = maxshift - minshift;
set(hs_shift,'style','slider');
set(hs_shift,'units','normalized','position',[0.33 0.0 0.15 0.05]);  %3rd val controls x-width; 1st value controls x location
set(hs_shift,'min',minshift,'max',maxshift,'value',0); %last value is initial value of slider
set(hs_shift,'sliderstep',[1/(length_setting_maxshift-1) 1/(length_setting_maxshift-1)*5]);  %increments when click on arrows, or click on parts between the arrows and the sliding square; first value graphical movement for single clicks, while second value graphical movement for large steps associated with using the mouse to bump the slider along. 
set(hs_shift,'callback', 'call_slidervalue_shift');


%tbox_mkr1_head_21 = uicontrol('style','text','units','normalized','position',[0.15 0.965 0.25 0.03],'string','Mkr1 x (idx,Re,Im)','backgroundcolor','white');
%tbox_mkr1idx_21=uicontrol('style','text','units','normalized','position',[0.45 0.965 0.05 0.03],'string','pos','backgroundcolor','white');


%note that this text box below has been set here because it needed to be defined in order to
%reference that text box which we use to place the index of the selected point (using mouse)
tbox_rectime=uicontrol('style','text','units','normalized','position',[0.15 0.08 0.05 0.03],'string','10');  %this "string" setting should be set to the initial value of the slider. The initial slider value is set elsewhere.
set(tbox_rectime,'backgroundcolor','white');

tbox_shift=uicontrol('style','text','units','normalized','position',[0.33 0.08 0.05 0.03],'string','0');
set(tbox_shift,'backgroundcolor','white');