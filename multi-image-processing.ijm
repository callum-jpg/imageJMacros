setBatchMode(true);
dir = getDirectory("Select an image parent directory");
list = getFileList(dir);
dirName = File.getName(dir);



// Create arrays for the desired histogram adjustments
// Histogram values will also be appended to new filenames
dapiHist = newArray(10, 140);
gfpHist = newArray(40, 255); // Create array
mcherryHist = newArray(10, 90);
cy5Hist = newArray(10, 150);
//Array.print(gfpHist); // Print contents of array
//print(gfpHist.length); //  Print length of array

for (i=0; i<list.length; i++)	{
	path = dir + list[i]; // must pass single argument to bio-formats

	run("Bio-Formats Importer", "open=["+ path +"]"); // Imports individual image files. Doesn't adjust histogram
	setMinAndMax(0,4095); // Convert image to 12-bit
	run("8-bit"); // Convert images to 8-bit for LUTs
	imageTitle=getTitle(); // Record the title of the image
	if (indexOf(imageTitle, 'DAPI') >= 0) {
		selectWindow(imageTitle);
		run("Blue");
		setMinAndMax(dapiHist[0], dapiHist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		dapiName = dirName+ ' - DAPI - adjusted (' + dapiHist[0] + ', ' + dapiHist[1] + ').tiff';
		//saveAs("Tiff", dir+dirName+ ' - DAPI - adjusted (' + dapiHist[0] + ',' + dapiHist[1] + ').tiff');
		saveAs("Tiff", dir+dapiName);
		selectWindow(dapiName);
		run("Set Scale...", "distance=3.1 known=1 pixel=[0] unit=micron global"); // Set scale for 20x
		run("Scale Bar...", "width=20 height=5 font=28 color=White background=None location=[Upper Left] hide overlay"); // Add scale bar
		run("Flatten"); // Flatten image to perserve LUT before stack. Creates a new image in a new window
		saveAs("Tiff", dir+dirName+ ' - DAPI - adjusted - Scale bar - (' + dapiHist[0] + ',' + dapiHist[1] + ').tiff');
		close();
	}
	if (indexOf(imageTitle, 'GFP') >= 0) {
		selectWindow(imageTitle);
		run("Green");
		setMinAndMax(gfpHist[0], gfpHist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", dir+dirName+ ' - GFP - adjusted (' + gfpHist[0] + ', ' + gfpHist[1] + ').tiff');
		close();
	}
	if (indexOf(imageTitle, 'mCherry') >= 0) {
		selectWindow(imageTitle);
		run("Magenta");
		setMinAndMax(mcherryHist[0], mcherryHist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", dir+dirName + ' - mCherry - adjusted (' + mcherryHist[0] + ', ' + mcherryHist[1] + ').tiff');
		close();
	}
	if (indexOf(imageTitle, 'Cy5') >= 0) {
		selectWindow(imageTitle);
		run("Red");
		setMinAndMax(cy5Hist[0], cy5Hist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", dir+dirName + ' - Cy5 - adjusted (' + cy5Hist[0] + ', ' + cy5Hist[1] + ').tiff');
		close();
	}
}


