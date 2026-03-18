# Confocal_Analysis_Opto-PNS-project
Scripts for analysis and quantification of different cells and proteins for the scpinal cord injection project. 

---

## Pipeline Overview

### Step 1 — Separate 10X Images (`moving_10X.ipynb`)
Run this Jupyter notebook to scan the directory for all ND2 files and automatically move 10X objective images into a dedicated subfolder for separate handling.

**Output:** `10X_images/`

---

### Step 2 — Convert ND2 to TIFF by Channel (`split_nd2_to_tiff_max_z.ijm`)
Run this ImageJ macro to convert all remaining ND2 files to TIFF format. For each series (imaging location), the macro:
- Splits the file into 4 individual channel TIFFs
- Applies a max z-projection
- Saves all outputs into a dedicated folder

**Output:** `tiff_files/`

---

### Step 3 — Copy SNR Files (`tiff_SNR/`)
After TIFF conversion, SNR-passing files are copied into a separate folder for downstream analysis.

**Output:** `tiff_SNR/`

---

## Folder Structure
```
project_root/
├── 10X_images/               # 10X objective ND2 files (moved in Step 1)
├── tiff_files/               # Channel-split TIFFs from Step 2
├── tiff_SNR/                 # SNR-filtered TIFFs for analysis
├── moving_10X.ipynb          # Step 1: sort 10X images
└── split_nd2_to_tiff_max_z.ijm  # Step 2: ND2 → TIFF conversion macro
```

---

## Requirements

- Python (Jupyter Notebook) — for `moving_10X.ipynb`
- Fiji / ImageJ — for `split_nd2_to_tiff_max_z.ijm`
- ND2 files organized in a single input directory before running

---

## Usage

1. Place all ND2 files in the project root directory
2. Run `moving_10X.ipynb` to sort 10X files
3. Open Fiji and run `split_nd2_to_tiff_max_z.ijm` on the remaining ND2s
4. Copy or verify SNR files are in `tiff_SNR/`
```

Save this as `README.md` in your repo root, then:
```
git add README.md
git commit -m "Add README for confocal image processing pipeline"
git push origin main
