# Create a montage from CellProfiler outline images
# to resemble a 96 or 384 well plate for QC purposes

from ij import IJ

plate_wells = 96
scale = 0.5

path = IJ.getDirectory("Choose outline directory")

if plate_wells == 96:
	rows, cols = [8, 12]
if plate_wells == 384:
	rows, cols = [16, 24]

IJ.run("Image Sequence...", "open="+path+" sort")
IJ.run("Make Montage...", "columns="+str(cols)+" rows="+str(rows)+" scale="+str(scale))
im=IJ.getImage()
IJ.saveAs("Tiff",path+'montage.tif')
