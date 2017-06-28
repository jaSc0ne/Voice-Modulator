%% Voice Encoder - Mark 1
% Record audio sample from microphone and process the sample to modulate
% the frequency when playing it through the output audio device (e.g.
% speaker)

% Author: Jason Paix
% Last updated: 24/06/17

clear;
clc;
close all;

% Global Variables
Fs = 44100;         % Input audio sampling frequency (Hz)
num_bits = 16;      % Input audio sampling number of bits
                    % (increases resolution with higher bit numbers)
num_channels = 2;   % Input audio number of channels
                    % (1 - mono, 2 - stereo)
program_run = 1;    % Set the program to run continuously until otherwise terminated
                    
% Initialise the audio input set-up
mic = audiorecorder(Fs, num_bits, num_channels);


while program_run == 1
    % Introduce the input audio signal
    record_time = input('Specify length of recording:  ');
    recordblocking(mic, record_time); % Record using the microphone for time entered previously
    input_audio = getaudiodata(mic) % Save the audio data

    % Modulation of audio input data
    sound_check = input('Would you like to hear the audio sample? yes (1)  no (2)  ');
    if sound_check == 1
        sound(input_audio, Fs); % Play back the input audio sample at the input sampling frequency
    end
    modulation_direction = input('How should the audio be changed: increase (1) or decrease (2) ?    ');
    modulation_percentage = input('How much should the audio be changed by (%)?   ');

    % If the modulation direction is 'increase'
    if modulation_direction == 1 
        modulation_factor = 1 + modulation_percentage/100;  % Calculate the factor to multiply Fs by
        sound(input_audio, modulation_factor*Fs);           % Play the audio sample with the new Fs
    % If the modulation direction is 'decrease'
    elseif modulation_direction == 2
        modulation_factor = 1 - modulation_percentage/100;  % Calculate the factor to multiply Fs by
        sound(input_audio, modulation_factor*Fs);           % Play the audio sample with the new Fs
    end

    % Ask if the user would like to modulate again
    repeat = input('Would you like to modulate your audio signal again? (1) yes   (2) no');
    if repeat == 1
        program_run = 1; % If the user would like to repeat it, continue the while loop
    elseif repeat == 2
        program_run = 0; % If the user would not like to repeat it, break the while loop
    end

end


