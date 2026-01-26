# CMRxRecon2024

## About
**Welcome to the Cardiac MRI Reconstruction Challenge 2024 (CMRxRecon2024)！**  
The CMRxRecon2024 (also known as CMRxUniversalRecon) Challenge is a part of the 27th International Conference on Medical Image Computing and Computer Assisted Intervention, MICCAI 2024, which will be held from October 6th to 10th 2024 in Marrakesh, Morocco.


[Website](https://cmrxrecon.github.io/2024) |
[Dataset](https://www.synapse.org/#!Synapse:syn57407073/datasets/) |
[GitHub](https://github.com/CmrxRecon/CMRxRecon2024/) |
[Publications](#Publication-references)

## Motivation
The objective of establishing the CMRxUniversalRecon challenge (Toward Universal Reconstruction) is to provide a benchmark that enables the broader research community to contribute to the important work of accelerated CMR imaging with universal approaches that allow more diverse applications and better performance in real-world deployment in various environments.

## Background
Cardiac magnetic resonance imaging (CMR) has emerged as a crucial imaging technique for diagnosing cardiac diseases, thanks to its excellent soft tissue contrast and non-invasive nature. **However, a notable limitation of MRI is its slow imaging speed, which causes patient discomfort and introduces motion artifacts into the images.**

To accelerate image acquisition, CMR image reconstruction (recovering high-quality clinical interpretable images from highly under-sampled k-space data) has gained significant attention in recent years. Particularly, AI-based image reconstruction algorithms have shown great potential in improving imaging performance by utilizing highly under-sampled data. Currently, the field of CMR reconstruction lacks publicly available, standardized, and high-quality datasets for the development and assessment for AI-based CMR reconstruction. In the first run of the 'CMRxRecon' challenge (MICCAI 2023), we have provided cine and mapping data from a total of 300 subjects and the technical infrastructure as well as a baseline model for CMR reconstructions. The results of 'CMRxRecon' 2023 demonstrated that deep learning methods demonstrated significantly superior performance compared to traditional methods such as SENSE and GRAPPA in a single task scenario.

As we all know, CMR imaging has the nature of multi-contrast, e.g., cardiac cine, mapping, tagging, phase-contrast, and dark-blood imaging. It also includes imaging of different anatomical views such as long-axis (2-chamber, 3-chamber, and 4-chamber), short-axis, outflow tract, and aortic (cross-sectional and sagittal views). Additionally, accelerated imaging trajectories, including uniformly undersampling and variable-density sampling, are employed. **Unfortunately, conventional CNN-based reconstruction models often require training and deployment for each specific imaging scenario (imaging sequence, view, and device vendor), limiting their clinical application in the real world.**

Thus, in this second run of the CMR reconstruction challenge we aim to make an important step towards clinical implementation by extending the challenge scope in two directions:
**1) Trustworthy reconstruction on multi-contrast CMR imaging (two will be unseen in the training dataset) using a universal pre-trained reconstruction model;**
**2) Robust reconstruction with diverse k-space trajectory and various acceleration factors using a universal model.**  

This repository contains Matlab code for data loaders, undersampling functions, evaluation metrics, and reference implementations of simple baseline methods. It also contains implementations for methods in some of the publications of the CMRxRecon project.

## Challenge tasks
The 'CMRxRecon2024' challenge includes two independent tasks. Each team can choose to participate one of them or both:

**TASK 1: Multi-contrast CMR reconstruction**

**1) Goal:** To develop a contrast-universal model that can 1) provide high-quality image reconstruction for highly-accelerated uniform undersampling (acceleration factors are 4x, 8x and 10x, ACS not included for calculations); 2) being able to process multiple contrast reconstructions with different sequences, views, and scanning protocols using a single universal model. The proposed method is supposed to offer a unified framework that can handle various imaging contrasts, allowing for faster and more robust reconstructions across different CMR protocols.

**2) Note:** In TASK 1, participants are allowed to train **three individual contrast-universal models** to respectively reconstruct multi-contrast data at the aforementioned three acceleration factors; **TrainingSet includes Cine, Aorta, Mapping, and Tagging; ValidationSet and TestSet include Cine, Aorta, Mapping, Tagging, and other two unseen contrasts (Flow2d and BlackBlood)**; the data size of Cine, Aorta, Mapping, Tagging, and Flow2d is 5D (nx,ny,nc,nz,nt); the data size of BlackBlood is 4D (nx,ny,nc,nz); **the size of all undersampling masks is 2D (nx,ny)**, the central 16 lines (ny) are always fully sampled to be used as autocalibration signals (ACS).

![Task 1](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Overview_Task1.png)

**TASK 2: Random sampling CMR reconstruction**

**1) Goal:** To develop a sampling-universal model that can robustly reconstruct CMR images 1) from different k-space trajectories (uniform, Guassian, and pseudo radial undersampling with temporal/parametric interleaving); 2) at different acceleration factors (acceleration factors from 4x to 24x, ACS not included for calculations). The proposed method is supposed to leverage deep learning algorithms to exploit the potential of random sampling, enabling faster acquisition times while maintaining high-quality image reconstructions.

**2) Note:** In TASK 2, participants are allowed to train **only one universal model** to reconstruct various data at the different undersampling scenarios (including different k-space trajectories: uniform, Guassian, and pseudo radial undersampling with temporal/parametric interleaving; and different acceleration factors: 4x, 8x, 12x, 16x, 20x, 24x, ACS not included for calculations); **TrainingSet includes Cine, Aorta, Mapping, and Tagging; ValidationSet and TestSet also include Cine, Aorta, Mapping, and Tagging**; the data size of Cine, Aorta, Mapping, and Tagging is 5D (nx,ny,nc,nz,nt); **the size of all undersampling masks is 3D (nx,ny,nt)**, the central 16 lines (ny, in ktUniform and ktGaussian) or central 16x16 regions (nx*ny, in ktRadial) are always fully sampled to be used as autocalibration signals (ACS).

![Task 2](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Overview_Task2.png)

## Documentation

### The CMRxRecon2024 Dataset
A total of 330 healthy volunteers are recruited for multi-contrast CMR imaging in our imaging center (3.0T Siemens Vida). **The dataset include multi-contrast k-space data, consist of cardiac cine, T1/T2mapping, tagging, phase-contrast (i.e., flow2d), and dark-blood imaging. It also includes imaging of different anatomical views like long-axis (2-chamber, 3-chamber, and 4-chamber), short-axis (SAX), left ventricul outflow tract (LVOT), and aorta (transversal and sagittal views)**.

![Task 1&2 Image](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Task1&2_ContrastImageCMR.png)

**The released dataset includes 200 training data, 60 validation data, and 70 test data.**

Training cases including fully sampled k-space data and sampling trajectories will be provided in '.mat' format.

Validation cases include under-sampled k-space data, sampling trajectories, and autocalibration signals (ACS, 16 lines or 16x16 regions) with various acceleration factors in '.mat' format.

Test cases include fully sampled k-space data, undersampled k-space data, sampling trajectories, and autocalibration signals (ACS, 16 lines or 16x16 regions). Test cases will not be released before the challenge ends.

![Task 1&2 Mask](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Task1&2_MaskCMR.png)

## Package Structure
* `CMRxReconDemo`: contains parallel imaging reconstruction code
* `ChallengeDataFormat`: explains the challenge data and the rules for data submission
* `CMRxReconMaskGeneration`: contains code for varied undersampling mask generation in Task 1&2
* `Evaluation`: contains image quality evaluation code for validation and testing
* `Submission`: contains the structure for challenge submission

## Contact
The code is provided to support reproducible research. If the code is giving syntax error in your particular configuration or some files are missing then you may open an issue or email us at CMRxRecon@outlook.com

## Publication references
You are free to use and/or refer to the CMRxRecon challenge and datasets in your own research after the embargo period (Dec 2024), provided that you cite the following manuscripts: 

**References of the CMRx Series Dataset**
1. Wang C, Lyu J, Wang S, et al. CMRxRecon: A publicly available k-space dataset and benchmark to advance deep learning for cardiac MRI. Scientific Data, 2024, 11(1): 687. Doi: https://doi.org/10.1038/s41597-024-03525-4 
2. Wang Z, Wang F, Qin C, et al. CMRxRecon2024: A Multimodality, Multiview k-Space Dataset Boosting Universal Machine Learning for Accelerated Cardiac MRI, Radiology: Artificial Intelligence, 2025, 7(2): e240443. Doi: https://doi.org/10.1148/ryai.240443
3. Wang Z, Huang M, Shi Z, et al. Enabling Ultra-Fast Cardiovascular Imaging Across Heterogeneous Clinical Environments with a Generalist Foundation Model and Multimodal Database. arXiv preprint arXiv:2512.21652, 2025. Doi: https://doi.org/10.48550/arXiv.2512.21652 
4. Wang C, Li Y, Lv J, et al. Recommendation for Cardiac Magnetic Resonance Imaging-Based Phenotypic Study: Imaging Part. Phenomics. Doi: 2021, 1(4): 151-170. https://doi.org/10.1007/s43657-021-00018-x 

**CMRx Series Challenge Summary Papers**
1. Lyu J, Qin C, Wang S, et al. The state-of-the-art in cardiac MRI reconstruction: Results of the CMRxRecon challenge in MICCAI 2023. Medical Image Analysis, 2025, 101: 103485. Doi: https://doi.org/10.1016/j.media.2025.103485 
2. Wang K, Qin C, Shi Z, et al. Extreme cardiac MRI analysis under respiratory motion: Results of the CMRxMotion Challenge. Medical Image Analysis, 2025: 103883. Doi: https://doi.org/10.1016/j.media.2025.103883
3. Wang F, Wang Z, Li Y, et al. Towards Modality-and Sampling-Universal Learning Strategies for Accelerating Cardiovascular Imaging: Summary of the CMRxRecon2024 Challenge. IEEE Transactions on Medical Imaging, 2025. Doi: 10.1109/TMI.2025.3641610

**Reference for previously algorithms from the organizers:**
1. Wang C, Li Y, Lv J, et al. Recommendation for Cardiac Magnetic Resonance Imaging-Based Phenotypic Study: Imaging Part. Phenomics. 2021, 1(4): 151-170. Doi: https://doi.org/10.1007/s43657-021-00018-x 
2. Lyu J, Li G, Wang C, et al. Region-focused multi-view transformer-based generative adversarial network for cardiac cine MRI reconstruction. Medical Image Analysis, 2023: 102760. Doi: https://doi.org/10.1016/j.media.2023.102760
3. Lyu J, Tian Y, Cai Q, et al. Adaptive channel-modulated personalized federated learning for magnetic resonance image reconstruction. Computers in Biology and Medicine, 2023, 165: 107330. Doi: https://doi.org/10.1016/j.compbiomed.2023.107330
4. Wang Z, Qian C, Guo D, et al. One-dimensional Deep Low-rank and Sparse Network for Accelerated MRI, IEEE Transactions on Medical Imaging, 42: 79-90, 2023. Doi: https://doi.org/10.1109/TMI.2022.3203312
5. Qin C, Schlemper J, Caballero J, et al. Convolutional recurrent neural networks for dynamic MR image reconstruction. IEEE transactions on medical imaging, 2018, 38(1): 280-290. Doi: https://doi.org/10.1109/TMI.2018.2863670
6. Lyu J, Wang S, Tian Y, et al. STADNet: Spatial-Temporal Attention-Guided Dual-Path Network for cardiac cine MRI super-resolution. Medical Image Analysis, 2024;94:103142. Doi: https://doi.org/10.1016/j.media.2024.103142
7. Wang Z, Xiao M, Zhou Y, et al. Deep separable spatiotemporal learning for fast dynamic cardiac MRI. IEEE Transactions on Biomedical Engineering, 2025.  Doi: https://doi.org/10.1109/TBME.2025.3574090 
8. Huang J, Yang L, Wang F, et al. Enhancing global sensitivity and uncertainty quantification in medical image reconstruction with Monte Carlo arbitrary-masked mamba. Medical Image Analysis, 2025, 99: 103334. Doi: https://doi.org/10.1016/j.media.2024.103334
9. Wang Z, Yu X, Wang C, et al. One for multiple: Physics-informed synthetic data boosts generalizable deep learning for fast MRI reconstruction. Medical Image Analysis, 2025, 103: 103616. Doi: https://doi.org/10.1016/j.media.2025.103616
10. Lyu J, Wang G, Wang Z, et al. Diffusion-prior based implicit neural representation for arbitrary-scale cardiac cine MRI super-resolution. Information Fusion, 2025: 103510. Doi: https://doi.org/10.1016/j.inffus.2025.103510
