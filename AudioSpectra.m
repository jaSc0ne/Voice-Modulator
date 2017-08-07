%% Real time voice modulation

clear;
clc;

%% Create and Initialise
SamplesPerFrame = 1024;
Microphone = dsp.AudioRecorder('SamplesPerFrame', SamplesPerFrame,...
    'OutputDataType','double');
Fs = Microphone.SampleRate;
%Mic.DeviceName = 'Microphone (Yeti Stereo Microphone)';
TimeScope = dsp.TimeScope('SampleRate',Fs,'TimeSpan',1,'ShowGrid',true);

high_pitch = dsp.AudioPlayer('SampleRate',1.1*Fs, 'BufferSize', 4*Fs);
higher_pitch = dsp.AudioPlayer('SampleRate', 1.2*Fs, 'BufferSize',4*Fs);
low_pitch = dsp.AudioPlayer('SampleRate', 0.9*Fs, 'BufferSize', 4*Fs);
lower_pitch = dsp.AudioPlayer('SampleRate', 0.8*Fs, 'BufferSize', 4*Fs);

Spectra = dsp.SpectrumAnalyzer('SampleRate',Fs,'PlotAsTwoSidedSpectrum', false,...
    'SpectralAverages',20,'FrequencyScale','Log');

%% Stream processing loop
run = true;
while run == true
    % Read frame from microphone
    audioIn = step(Microphone);
    
    audioOut = audioIn*0.8;
    
    % View spectrum analysis of audio
    step(Spectra, audioIn);
    
    % View audio waveform
    step(TimeScope, [audioIn,audioOut]);
    
    % Play the audio
  %  step(high_pitch,audioOut);
    step(higher_pitch, audioOut);
    %step(low_pitch, audioOut);
    %step(lower_pitch, audioOut);
   
end

%% Terminate
release(Microphone);
s = [];
release(Spectra);
s.Spectra = Spectra;