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

setBatchMode(true);

run("Conversions...", " ");

name = getTitle();

d = nSlices();
w = getWidth();
h = getHeight();

for (z = 0; z < d - 1; z+=2)
{
	selectWindow(name);
	setSlice(z + 1);
	run("Duplicate...", "use");
	tmp1 = getTitle();
	
	selectWindow(name);
	setSlice(z + 2);
	run("Duplicate...", "use");
	tmp2 = getTitle();
	
	imageCalculator("Average create 32-bit", tmp1, tmp2);
	run("Bin...", "x=2 y=2 bin=Average");
	run("8-bit");
	run("Invert");
	saveAs("Tiff", outputPath + name + "_slice_" + z);
	tmp3 = getTitle();
	
	closeWindow(tmp1);
	closeWindow(tmp2);
	closeWindow(tmp3);
}

run("Image Sequence...", "open=[" + outputPath + "] sort use");

setBatchMode("exit and display");

function closeWindow(title)
{
	selectWindow(title);
	close();
}