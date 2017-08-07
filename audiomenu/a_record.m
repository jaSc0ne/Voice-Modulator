function a_record

% Global Variables


global menupage
global hs_rectime;

global b_audio_text


global Fs num_bits num_channels input_audio

Fs = 44100;         % Input audio sampling frequency (Hz)
num_bits = 16;      % Input audio sampling number of bits
                    % (increases resolution with higher bit numbers)
num_channels = 2;   % Input audio number of channels
                    % (1 - mono, 2 - stereo)

                    
% Initialise the audio input set-up
mic = audiorecorder(Fs, num_bits, num_channels);


% Introduce the input audio signal
record_time = get(hs_rectime,'value');

set(b_audio_text,'string','Now RECORDING ');

recordblocking(mic, record_time); % Record using the microphone for time entered previously
input_audio = getaudiodata(mic) % Save the audio data

set(b_audio_text,'string','Recorded Data AVAILABLE ');

%sound(input_audio, Fs); % Play back the input audio sample at the input sampling frequency