# Submission Guidelines

Please ensure to maintain the current directory structure and save the data into the corresponding subfolders as specified.

Name your zip file as `Submission.zip`.

## Task 1

### Directory Structure
For each modality, follow this structure:
{Modality}/ValidationSet/Task1/PXXX/{ModalityFilename}_kus_Uniform{R}.mat


### Modalities
- **Seen Modalities:** Aorta, Cine, Mapping, Tagging
- **Unseen Modalities:** BlackBlood, Flow2d
  - Note: For BlackBlood, the data dimensions are `[nx, ny, nc, nz]`, which differ from the other modalities.

### Processing Instructions
All data should be coil-combined and cropped using the MATLAB script `run4Ranking.m`, available in the `CMRxReconDemo` subdirectory.

## Task 2

### Directory Structure
For each modality, follow this structure:
{Modality}/ValidationSet/Task2/PXXX/{ModalityFilename}_kus_kt{SamplingR}.mat



### Modalities
- **Seen Modalities:** Aorta, Cine, Mapping, Tagging

### Processing Instructions
All data should be coil-combined and cropped using the MATLAB script `run4Ranking.m`, provided in the `CMRxReconDemo` subdirectory.

