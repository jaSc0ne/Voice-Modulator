function [slider_idx] = slidervalue(tbox_handle,slider_handle)

slider_idx = round( get(slider_handle,'value') )  %handles non-integer values of slider when we put the mouse pointer on the slider part, while changing the position of the slider with the mouse button depressed.
set(slider_handle,'value',slider_idx)

set(tbox_handle,'string',num2str(slider_idx));