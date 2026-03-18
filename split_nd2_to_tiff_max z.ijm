// Split ND2 files by location — saves max projection per channel as a single TIFF
// Routes files to tiff_SNR/ or tiff_SC/ based on filename

inputDir = getDirectory("Choose folder containing ND2 files");

// Define output folders
snrDir = inputDir + "tiff_SNR" + File.separator;
scDir  = inputDir + "tiff_SC"  + File.separator;

if (!File.exists(snrDir)) File.makeDirectory(snrDir);
if (!File.exists(scDir))  File.makeDirectory(scDir);

run("Bio-Formats Macro Extensions");
fileList = getFileList(inputDir);

for (i = 0; i < fileList.length; i++) {
    if (!endsWith(toLowerCase(fileList[i]), ".nd2")) continue;

    filePath = inputDir + fileList[i];
    baseName = replace(fileList[i], ".nd2", "");

    // Route based on filename
    if (indexOf(fileList[i], "SNR") >= 0) {
        outputDir = snrDir;
    } else if (indexOf(fileList[i], "SC") >= 0) {
        outputDir = scDir;
    } else {
        print("Skipping (no SNR or SC in name): " + fileList[i]);
        continue;
    }

    Ext.setId(filePath);
    Ext.getSeriesCount(nSeries);
    print("Processing: " + fileList[i] + " — " + nSeries + " location(s) → " + outputDir);

    for (s = 0; s < nSeries; s++) {
        run("Bio-Formats Importer", "open=[" + filePath + "] color_mode=Default view=Hyperstack stack_order=XYCZT series_" + (s+1));
        run("Z Project...", "projection=[Max Intensity] all");
        close("\\Others");
        saveAs("Tiff", outputDir + baseName + "_loc" + IJ.pad(s+1, 2) + ".tif");
        close();
    }
}

print("Done!");
showMessage("Done!", "SNR TIFFs → " + snrDir + "\nSC TIFFs → " + scDir);