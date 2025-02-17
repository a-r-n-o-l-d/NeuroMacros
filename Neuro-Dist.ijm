macro "Distance to Action Tool - C170DbfC9c8DbdDccC6a3D6aD79D89Cdd8D37C675DfaC7adDc3Cf55D54CefeD1cD1eDa1Db1Dc1Dd1De1C565D01D10De0Df1Cbc9D7aC8b5Db8Cde9D3aC666D07D08D09D0aD0bD0cD0dD2fD3fD4fD5fD6fD7fD8fD9fDa0Db0Dc0Dd0DefDf2Df3Df4Df5Df6Df7Df8Df9DfdDfeCabdDc7Ccc5D72CfffD11D15D16D17D18D19D1aD21D61D81D91C491D7dCac9D7bD7cD8aD9aDaaDb9C676DdfCff8D64C9bdD95Ce75D77CfffD12D13D14D1bD31D41D51D71C575DcfDfcCcd9D2bC8c6D5bCdedD4eD5eD6eD7eD8eD9eDe7De8DeeCdedD2eD3eDe3De4De5De6Cdd6D74C380DeaCac8D5dC6a3D69Da7Cfd8D44C8adDb5Ce55D78CefeD1dC665D02D03D04D05D06D0eD1fD20D30D40D50D60D70D80D90Cdd7D35C8b6DbcCffaD26D48CaceDb6Cbc7D59C693D6bDb7C79cDd3C7a4Dc9Cfe9D68C9bdDd7Ccc4D73C6a4DcdCbccD96C9c7D5aCffbD2aCdedDe2Ced7D76C280DddC9c8DdbCdd8D39C8adD93Dd5Ce64D55Cad9D2cC8b6DabDbbDcbCff9D22D24D46CabeDd6Cdd5D75D98C592Dc8Cad8D4cC787D00D0fDf0Cee9D25D38D49C8bdDa3Cd95D53CbdaD2dC9b7DbaCdd7D33D57D86C481D8dCac8D3dD8cC6a4DdaCee8D23D36D47D58C8adD92Dd4Cf66D66Ccd9D84C8b6D8bD9bCffaD28CaceDa4Dc6Ccc7Dd8C5a3DebC79dDb3C7a5Da9C9beD94Ce96D65C6a4DdcCbdbDdeC9c7D5cCbdfDa6Cee7D63C270DafDfbCed7D56C7adDd2Cff9D27C9beDa5Dc4Ccc5D85C592D6dCff8D62Cdd6D87C381DceDecCac8D9cDcaC8adDb2CaceD82C593DadC9beDb4Cbb7D97C380DaeC9c8D4bCee8D34D45Cf65D43Cbd9D4dC592D6cC9bdDc5Ce96D67CbdaDedC9c7D3bC481Dd9C8aeDc2Cf76D42Cbe9D4aC6a3Da8CabbD83C887DffC9beDa2Ceb6D32CdecDe9C9c7D3cC380D9dCee8D52Ced8D88CeeaD29C9c8DacC692D99C5a4Dbe"
{
	img = getTitle();
	getVoxelSize(width, height, depth, unit);
	
    Dialog.create("Distance from");
    Dialog.addNumber("distance", 30, 2, 5, unit);
	Dialog.addCheckbox("toward inside", true);
	Dialog.addCheckbox("propagate labels", true);
	Dialog.show();

	d = Dialog.getNumber();
	i = Dialog.getCheckbox();
	p = Dialog.getCheckbox();

	setBatchMode(true);
	distMask(img, d, i, p);
	setBatchMode("exit and display");
}

macro "Intersect with Action Tool - C251DdeCfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD0fD10D11D12D13D14D15D16D17D18D19D1aD1eD1fD20D21D22D23D24D25D26D27D28D2fD30D31D32D33D34D35D36D37D3fD40D41D42D43D45D46D47D4fD50D51D52D55D56D5fD60D61D6cD6dD6eD6fD70D7bD7cD7dD7eD7fD80D8bD8cD8dD8eD8fD90D91D9cD9dD9eD9fDa0Da1Da2Da6DafDb0Db1Db2Db3Db5Db6Db7DbfDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7DcfDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8DdfDe0De1De2De3De4De5De6De7De8De9DeaDeeDefDf0Df1Df2Df3Df4Df5Df6Df7Df8Df9DfaDfbDfcDfdDfeDffC8b7Db4C5a5D65C9b9D6bC483D3eC9b8D9bC7a7D7aCdedDa7C373D5eDc9C8b8Db8C6b5D54Cad9D84C5a4D58C9c8D3bD44D4aD59D69D77D78D86D87C7b7D64D68D79D92DbbDbcDcbCefeD38C262DadDddC8c7D63D72C6a5D2aD67C9c9D76C594D2dDabC8c8D4bD71D88C7b6D93CeeeDc8DebDecDedC383D4eD5dC8c8D3cD4cD5aD81D99C7b6D98Da3CbdbDd9C5a5D2bD39D66Da4CefeD1bD1cD1dC262DaeC7c7D53D82C6a5D5bD6aD95Db9C9c9D48C483D2eD5cDa8C7b7D49D89CdedD57Da5C8c8D3dC6a6DcaCad9D73D74D83C595D97D9aC372DacDdbDdcC7c7DaaDbaC9d9D75D85C594D2cD96C7b7DccC373DdaC7b6DbdDcdCcecD29C262DbeDceC8b7D3aD94C8c7D4dD62Da9C7a6D8a"
{
	imgs = getImageList();
	
	Dialog.create("Intersection");
	Dialog.addChoice("Mask 1", imgs);
	Dialog.addChoice("Mask 2", imgs);
	Dialog.show();

	img1 = Dialog.getChoice();
	img2 = Dialog.getChoice();
	//print(img1, img2);

	setBatchMode(true);
	intersect(img1, img2);
	setBatchMode("exit and display");
}
/*
 * Select in src only the pairs (obj1, obj2) defined in lst
 * src: volume with the object labels to filter (e.g. synaptic clefts)
 * lbl1: volume with the obj1 labels
 * lbl2: volume with the obj2 labels
 * list: path to the file containing the pairs (obj1, obj2)
 * 
 * => I1 = intersect(lbl1, lbl2): intersection with the labels of lbl1
 * => I2 = intersect(lbl2, lbl1): intersection with the labels of lbl2
 * Res = zeros()
 * For each pair (obj1_i, obj2_i): 
 * 	1) M = (I1==obj1_i) && (I2==obj2_i)
 * 	2) Res = max(Res, M)
 * label Res
macro "Filter by pair Action Tool - C251DdeCfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD0fD10D11D12D13D14D15D16D17D18D19D1aD1eD1fD20D21D22D23D24D25D26D27D28D2fD30D31D32D33D34D35D36D37D3fD40D41D42D43D45D46D47D4fD50D51D52D55D56D5fD60D61D6cD6dD6eD6fD70D7bD7cD7dD7eD7fD80D8bD8cD8dD8eD8fD90D91D9cD9dD9eD9fDa0Da1Da2Da6DafDb0Db1Db2Db3Db5Db6Db7DbfDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7DcfDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8DdfDe0De1De2De3De4De5De6De7De8De9DeaDeeDefDf0Df1Df2Df3Df4Df5Df6Df7Df8Df9DfaDfbDfcDfdDfeDffC8b7Db4C5a5D65C9b9D6bC483D3eC9b8D9bC7a7D7aCdedDa7C373D5eDc9C8b8Db8C6b5D54Cad9D84C5a4D58C9c8D3bD44D4aD59D69D77D78D86D87C7b7D64D68D79D92DbbDbcDcbCefeD38C262DadDddC8c7D63D72C6a5D2aD67C9c9D76C594D2dDabC8c8D4bD71D88C7b6D93CeeeDc8DebDecDedC383D4eD5dC8c8D3cD4cD5aD81D99C7b6D98Da3CbdbDd9C5a5D2bD39D66Da4CefeD1bD1cD1dC262DaeC7c7D53D82C6a5D5bD6aD95Db9C9c9D48C483D2eD5cDa8C7b7D49D89CdedD57Da5C8c8D3dC6a6DcaCad9D73D74D83C595D97D9aC372DacDdbDdcC7c7DaaDbaC9d9D75D85C594D2cD96C7b7DccC373DdaC7b6DbdDcdCcecD29C262DbeDceC8b7D3aD94C8c7D4dD62Da9C7a6D8a"
{
	imgs = getImageList();
}
*/
function getImageList()
{
	count = nImages();
	if (count == 0) then return -1;

	setBatchMode(true);
	currentID = getImageID();
	id = newArray(count);
	names = newArray(count);
	for (i = 0; i < count; i++)
	{
		selectImage(i+1);
		id[i] = getImageID();
		names[i] = getTitle();
	}
	selectImage(currentID);
	setBatchMode(false);

	return names;
}

function propagateVoxelSize(src, dst)
{
	selectWindow(src);
	getVoxelSize(width, height, depth, unit);
	selectWindow(dst);
	run("Properties...", "unit=&unit pixel_width=&width pixel_height=&height voxel_depth=&depth");
}

function stretchHistogram(img)
{
	selectWindow(img);
	Stack.getStatistics(voxelCount, mean, min, max, stdDev);
	setMinAndMax(0, max);
}

function checkVolumeMetaData(img)
{
	selectWindow(img);
	getVoxelSize(width, height, depth, unit);
	if(unit == "pixels")
	{
		exit("Physical dimension of the volume is not set. Check voxel size with [Image>Properties...].");
	}
}

function distMask(img, dist, inside, propagate)
{
	run("Conversions...", " ");
	checkVolumeMetaData(img);
	selectWindow(img);
	getVoxelSize(width, height, depth, unit);
	run("Duplicate...", "title=tmp duplicate");
	run("8-bit");
	run("8-bit");
	if (inside)
	{
		run("Euclidean Distance Transform MT", "threshold=1");
	}
	else
	{
		run("Euclidean Distance Transform MT", "threshold=1 inverse");
	}
	run("Macro...", "code=[v = (v > 0) && (v <= " + dist + ");] stack");
	run("16-bit");
	res = "" + dist + unit + "From" + img;
	rename(res);
	close("tmp");
	if(propagate)
	{
		sx = floor(dist / width + 0.5);
		sy = floor(dist / height + 0.5);
		sz = floor(dist / depth + 0.5);
		if(inside)
		{
			imageCalculator("Multiply stack", res, img);
		}
		else
		{
			selectWindow(img);
			run("Morphological Filters (3D)", "operation=Dilation element=Cube x-radius=&sx y-radius=&sy z-radius=&sz");
			tmp = getTitle();
			imageCalculator("Multiply stack", res, tmp);
			close(tmp);
		}
	}
	stretchHistogram(res);
	propagateVoxelSize(img, res);
	return res;
}

function intersect(dm1, dm2)
{
	//print(dm1, dm2);
	checkVolumeMetaData(dm1);
	checkVolumeMetaData(dm2);
	selectWindow(dm1);
	n1 = getTitle();
	selectWindow(dm2);
	n2 = getTitle();
	res = "IntersectOf" + n1 + "And" + n2;
	selectWindow(dm2);
	Stack.getStatistics(voxelCount, mean, min, max, stdDev);
	if (max > 1)
	{
		run("Duplicate...", "title=tmp duplicate");
		run("Max...", "value=1 stack");
		dm2 = "tmp";
	}
	imageCalculator("Multiply create stack", dm1, dm2);
	rename(res);
	stretchHistogram(res);
	propagateVoxelSize(dm1, res);
	close("tmp");
	return res;
}

