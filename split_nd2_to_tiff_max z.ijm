// Split ND2 files by location — saves max projection per channel as a single TIFF

inputDir = getDirectory("Choose folder containing ND2 files");
outputDir = inputDir + "tiff_SC" + File.separator;
if (!File.exists(outputDir)) File.makeDirectory(outputDir);

run("Bio-Formats Macro Extensions");

fileList = getFileList(inputDir);

for (i = 0; i < fileList.length; i++) {
    if (!endsWith(toLowerCase(fileList[i]), ".nd2")) continue;

    filePath = inputDir + fileList[i];
    baseName = replace(fileList[i], ".nd2", "");

    Ext.setId(filePath);
    Ext.getSeriesCount(nSeries);

    print("Processing: " + fileList[i] + " — " + nSeries + " location(s)");

    for (s = 0; s < nSeries; s++) {
        run("Bio-Formats Importer", "open=[" + filePath + "] color_mode=Default view=Hyperstack stack_order=XYCZT series_" + (s+1));
        run("Z Project...", "projection=[Max Intensity] all");
        close("\\Others");
        saveAs("Tiff", outputDir + baseName + "_loc" + IJ.pad(s+1, 2) + ".tif");
        close();
    }
}

print("Done! Files saved to: " + outputDir);
showMessage("Done!", "TIFFs saved to:\n" + outputDir);