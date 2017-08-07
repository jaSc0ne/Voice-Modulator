function a_record

% Global Variables


global menupage
global hs_shift;


global Fs num_bits num_channels input_audio


shift = get(hs_shift,'value')
sound(input_audio, Fs+Fs*(shift/100)); % Play back the input audio sample at the input sampling frequency