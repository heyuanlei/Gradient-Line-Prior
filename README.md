# Efficient Single Image Dehazing Based on Gradient Line Prior 
Gradient Line Prior For Image Restoration (dehazing, low-light image enhancement and underwater image enhancement)

## Demo
When the input image is a haze image, directly running demo.m can directly obtain the image restoration result; When the input image is a low-light image, it is necessary to reverse the input image, that is, 255-input, and then directly run demo.m to obtain the low-light image enhancement result; When the input image is an underwater image, firstly, the red channel prior (RCP) is used to determine the water light, and then the color correction is carried out on the recovered result.It is recommended to use a color compensation method (Ancuti et al. doi: 10.1109/TIP.2017.2759252) for correcting color.



## Acknowledgements
- https://github.com/LPengYang/Saturation_Line_Prior