## ImageJ processing macros to make creating IF figures a little easier

### multi-image-processing.ijm
This macro is designed to allow for uniform histogram adjustments of a single
frame for 1-4 channels.

Currently, it recognises DAPI, GFP, mCherry or Cy5 within the file name and
colours the image blue, green, magenta, or red, respectively.

To adjust the output image intensity, alter the setMinAndMax command within the
if statement for the channel of interest.

Macro currently crops the histogram of all images to 12-bit (0, 4095). Images
are later converted to 8-bit to maintain applied LUT.

To do:
- [ ] Add GUI
