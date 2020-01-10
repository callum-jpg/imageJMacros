
dir = getDirectory("Select an image parent directory");
list = getFileList(dir);
dirName = File.getName(dir);

for (i=0; i<list.length; i++)	{
	path = dir + list[i]; // must pass single argument to bio-formats
	run("Bio-Formats Importer", "open=["+ path +"]"); // Imports individual image files. Does't adjust histogram
	setMinAndMax(0,4095); // Convert image to 12-bit
	run("8-bit"); // Convert images to 8-bit for LUTs
	imageTitle=getTitle(); // Record the title of the image
	if (indexOf(imageTitle, 'DAPI') >= 0) {
		selectWindow(imageTitle);
		run("Blue");
		setMinAndMax(0,255); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", dir+dirName + ' DAPI - adjusted.tiff');
		close();
	}
	if (indexOf(imageTitle, 'GFP') >= 0) {
		selectWindow(imageTitle);
		run("Green");
		setMinAndMax(25,200); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", dir+dirName + ' GFP - adjusted.tiff');
		close();
	}
	if (indexOf(imageTitle, 'mCherry') >= 0) {
		selectWindow(imageTitle);
		run("Magenta");
		setMinAndMax(20,100); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", dir+dirName + ' mCherry - adjusted.tiff');
		close();
	}
	if (indexOf(imageTitle, 'Cy5') >= 0) {
		selectWindow(imageTitle);
		run("Red");
		setMinAndMax(10,130); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", dir+dirName + ' Cy5 - adjusted.tiff');
		close();
	}
}
