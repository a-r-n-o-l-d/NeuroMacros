/*
 * Copyright or © or Copr. Arnold Fertin (2019)
 * 
 * arnold.fertin@univ-grenoble-alpes.fr
 * 
 * This software is a computer program whose purpose is to [describe functionalities and technical features of your 
 * software].
 * 
 * This software is governed by the CeCILL-C license under French law and abiding by the rules of distribution of free 
 * software. You can use, modify and/ or redistribute the software under the terms of the CeCILL-C license as 
 * circulated by CEA, CNRS and INRIA at the following URL "http://www.cecill.info". 
 * 
 * As a counterpart to the access to the source code and rights to copy, modify and redistribute granted by the 
 * license, users are provided only with a limited warranty and the software's author, the holder of the economic 
 * rights, and the successive licensors have only limited liability.
 * 
 * In this respect, the user's attention is drawn to the risks associated with loading, using, modifying and/or 
 * developing or reproducing the software by the user in light of its specific status of free software, that may mean 
 * that it is complicated to manipulate, and that also therefore means that it is reserved for developers and 
 * experienced professionals having in-depth computer knowledge. Users are therefore encouraged to load and test the 
 * software's suitability as regards their requirements in conditions enabling the security of their systems and/or data
 * to be ensured and, more generally, to use and operate it in the same conditions as regards security. 
 * 
 * The fact that you are presently reading this means that you have had knowledge of the CeCILL-C license and that you 
 * accept its terms.
 */

outputPath = getDirectory("Choose output directory");

Dialog.create("Crop of final stack");
Dialog.addCheckbox("Crop", true);
Dialog.show();
crop = Dialog.getCheckbox();

name = getTitle();

d = nSlices();
w = getWidth();
h = getHeight();

enlargeSize = getNextPowerOfTwo(maxOf(w,h));
padding = false;
if(w != enlargeSize || h != enlargeSize)
{
	padding = true;
}
dX = newArray(d);
dY = newArray(d);
zVal = newArray(d);

setBatchMode(true);

// CALCUL DES DECALAGES
// Premier slice
selectWindow(name);
setSlice(1);
run("Duplicate...", "use");
zPrevious = getTitle();
if (padding)
{
	run("Canvas Size...", "width=&enlargeSize height=&enlargeSize position=Center zero");
	getNonZeroROI(zPrevious);
	fillWithNoise(zPrevious);
}

for (z = 1; z < d; z++)
{
	selectWindow(name);
	setSlice(z + 1);
	run("Select None");
	run("Duplicate...", "use");
	zCurrent = getTitle();
	if (padding)
	{
		run("Canvas Size...", "width=&enlargeSize height=&enlargeSize position=Center zero");
		getNonZeroROI(zCurrent);
		fillWithNoise(zCurrent);
	}
	translation = register(zPrevious, zCurrent);
	dX[z] = dX[z - 1] + translation[0];
	dY[z] = dY[z - 1] + translation[1];
	zVal [z] = z;
	closeWindow(zPrevious);
	zPrevious = zCurrent;
	showProgress(z / d);
}
closeWindow(zCurrent);

// Sorties graphiques pour vérification
Plot.create("DXCUMUL", "X-axis Label", "Y-axis Label", zVal, dX);
Plot.show();
Plot.create("DYCUMUL", "X-axis Label", "Y-axis Label", zVal, dY);
Plot.show();

// RECALAGE
// Estimation 
Array.getStatistics(dX, dXmin, dXmax);
left = 0;
right = 0;
if (dXmin < 0)
{
	left += abs(dXmin);
}
else
{
	right += abs(dXmin);
}
if (dXmax < 0)
{
	left += abs(dXmax);
}
else
{
	right += abs(dXmax);
}

Array.getStatistics(dY, dYmin, dYmax);
top = 0;
bottom = 0;
if (dYmin < 0)
{
	top += abs(dYmin);
}
else
{
	bottom += abs(dYmin);
}
if (dYmax < 0)
{
	top += abs(dYmax);
}
else
{
	bottom += abs(dYmax);
}

w1 = w + left;
h1 = h + top;
w2 = w1 + right;
h2 = h1 + bottom;

for (z = 0; z < d; z++)
{
	selectWindow(name);
	setSlice(z + 1);
	run("Select None");
	run("Duplicate...", "use");
	run("Canvas Size...", "width="+ w1 + " height=" + h1 + " position=Bottom-Right zero");
	run("Canvas Size...", "width="+ w2 + " height=" + h2 + " position=Top-Left zero");
	run("Translate...", "x=" + dX[z] + " y=" + dY[z] + " interpolation=Bicubic");
	saveAs("Tiff", outputPath + getTitle() + "_slice_" + z);
	close();
	showProgress(z / d);
}

run("Image Sequence...", "open=[" + outputPath + "] sort use");
if (crop)
{
	// Crop
	tmp1 = getTitle();
	run("Z Project...", "projection=[Min Intensity]");
	tmp2 = getTitle();
	getNonZeroROI(tmp2);
	roiManager("reset");
	roiManager("Add");
	selectWindow(tmp1);
	roiManager("Select", 0);
	for (z = 0; z < d; z++)
	{
		setSlice(z + 1);
		run("Duplicate...", "use");
		saveAs("Tiff", outputPath + getTitle() + "_slice_" + z);
		close();
		showProgress(z / d);
	}
	closeWindow(tmp1);
	closeWindow(tmp2);
	
	run("Image Sequence...", "open=[" + outputPath + "] sort use");
}

setBatchMode("exit and display");

function getNextPowerOfTwo(x)
{
	power = 1;
	while(power < x)
	{
		power *= 2;
	}
	return power;
}

function closeWindow(title)
{
	selectWindow(title);
	close();
}

function register(img1, img2)
{
	print("\\Clear");
	run("Phase Correlator 2D", "image_1=" + img2 + " image_2=" + img1 + " window_type=HAMMING");
	deltas = split(getInfo("log"), " ");

	dX = 0.0 + deltas[0];
	dY = 0.0 + deltas[1];
	
	return newArray(dX, dY, 0);
}

function getNonZeroROI(img)
{
	selectWindow(img);
	w = getWidth();
	h = getHeight();
	
	getStatistics(area, mean, min, max);
	if (min==0 && max==0)// image avec que dalle
	{
		return 0;
	}

	flag = true;
	xMin = 0;
	do
	{
		makeRectangle(xMin, 0, 1, h);
		getStatistics(area, mean, min, max);
		xMin++;
		if (mean != 0)
		{
			xMin--;
			flag = false;
		}
	} while(flag)

	flag = true;
	xMax = w - 1;
	do
	{
		makeRectangle(xMax, 0, 1, h);
		getStatistics(area, mean, min, max);
		xMax--;
		if (mean != 0)
		{
			xMax++;
			flag = false;
		}
	} while(flag)

	flag = true;
	yMin = 0;
	do
	{
		makeRectangle(0, yMin, w, 1);
		getStatistics(area, mean, min, max);
		yMin++;
		if (mean != 0)
		{
			yMin--;
			flag = false;
		}
	} while(flag)


	flag = true;
	yMax = h - 1;
	do
	{
		makeRectangle(0, yMax, w, 1);
		getStatistics(area, mean, min, max);
		yMax--;
		if (mean != 0)
		{
			yMax++;
			flag = false;
		}
	} while(flag)

	width = xMax - xMin;
	height = yMax - yMin;
	makeRectangle(xMin, yMin, width, height);
	
	return width * height;
}

function fillWithNoise(img)
{
	getStatistics(area, mean, min, max, std);
	run("Make Inverse");
	run("Set...", "value=&mean");
	run("Add Specified Noise...", "standard=&std");
}