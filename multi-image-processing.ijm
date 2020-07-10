setBatchMode(true);
dir = getDirectory("Select an image parent directory");
list = getFileList(dir);
dirName = File.getName(dir);

// Create arrays for the desired histogram adjustments
// Histogram values will also be appended to new filenames
dapiHist = newArray(15, 255);
gfpHist = newArray(55, 255); // Create array
mcherryHist = newArray(15, 255);
cy5Hist = newArray(30, 255);
//Array.print(gfpHist); // Print contents of array
//print(gfpHist.length); //  Print length of array

// Create directory in which to save adjusted images
outputDir = dir + 'Adjusted images' + File.separator;
File.makeDirectory(outputDir);
fileList = fileListOnly(list); // Create file list and exclude folders from array
//print(list.length, fileList.length);


for (i=0; i<fileList.length; i++)	{
	path = dir + fileList[i]; // must pass single argument to bio-formats
	//run("Bio-Formats Importer", "open=["+ path +"]"); // Imports individual image files. Doesn't adjust histogram
	open(path);
	setMinAndMax(0,4095); // Convert image to 12-bit
	//setMinAndMax(0,7095);
	run("8-bit"); // Convert images to 8-bit for LUTs
	imageTitle=getTitle(); // Record the title of the image
	if (indexOf(imageTitle, 'DAPI') >= 0) {
		selectWindow(imageTitle);
		run("Blue");
		setMinAndMax(dapiHist[0], dapiHist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		dapiName = dirName+ ' - DAPI - adjusted (' + dapiHist[0] + ', ' + dapiHist[1] + ').tiff';
		//saveAs("Tiff", dir+dirName+ ' - DAPI - adjusted (' + dapiHist[0] + ',' + dapiHist[1] + ').tiff');
		saveAs("Tiff", outputDir+dapiName);
		selectWindow(dapiName);
		run("Set Scale...", "distance=3.1 known=1 pixel=[0] unit=micron global"); // Set scale for 20x
		run("Scale Bar...", "width=20 height=5 font=28 color=White background=None location=[Upper Left] hide overlay"); // Add scale bar
		run("Flatten"); // Flatten image to perserve LUT before stack. Creates a new image in a new window
		saveAs("Tiff", outputDir+dirName+ ' - DAPI - adjusted - Scale bar - (' + dapiHist[0] + ',' + dapiHist[1] + ').tiff');
		close();
	}
	if (indexOf(imageTitle, 'GFP') >= 0) {
		selectWindow(imageTitle);
		run("Green");
		setMinAndMax(gfpHist[0], gfpHist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", outputDir+dirName+ ' - GFP - adjusted (' + gfpHist[0] + ', ' + gfpHist[1] + ').tiff');
		close();
	}
	if (indexOf(imageTitle, 'mCherry') >= 0) {
		selectWindow(imageTitle);
		run("Magenta");
		setMinAndMax(mcherryHist[0], mcherryHist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", outputDir+dirName + ' - mCherry - adjusted (' + mcherryHist[0] + ', ' + mcherryHist[1] + ').tiff');
		close();
	}
	if (indexOf(imageTitle, 'Cy5') >= 0) {
		selectWindow(imageTitle);
		run("Red");
		setMinAndMax(cy5Hist[0], cy5Hist[1]); // Change to increase/decrease exposure
		run("Apply LUT");
		saveAs("Tiff", outputDir+dirName + ' - Cy5 - adjusted (' + cy5Hist[0] + ', ' + cy5Hist[1] + ').tiff');
		close();
	}
}

function fileListOnly(inputList) {
	// Returns a list of files within and EXCLUDES subdirectories and .nd files from list
	fileOnlyList = newArray;
	for (i=0; i<inputList.length; i++) {
		//print(inputList[i], "= before filter");
		if (!endsWith(inputList[i], File.separator) && !endsWith(inputList[i], '.nd')) {
			//print(inputList[i]);
			//fileOnlyList[i] = inputList[i];
			fileOnlyList = Array.concat(fileOnlyList, inputList[i]);
		}
	}
	return fileOnlyList;
}


//test = fileListOnly(list);
//for (i=0; i<test.length; i++) {
//	print(test[i]);
//}


