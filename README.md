# CMRxRecon2024

## About
**Welcome to the Cardiac MRI Reconstruction Challenge 2024 (CMRxRecon2024)！**  
The CMRxRecon2024 (also known as CMRxUniversalRecon) Challenge is a part of the 27th International Conference on Medical Image Computing and Computer Assisted Intervention, MICCAI 2024, which will be held from October 6th to 10th 2024 in Marrakesh, Morocco.


[Website](https://cmrxrecon.github.io/2024) |
[Dataset_TODO](https://www.synapse.org/#!Synapse:syn51471091/wiki/) |
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

**2) Note:** In TASK 1, participants are allowed to train **three individual contrast-universal models** to respectively reconstruct multi-contrast data at the aforementioned three acceleration factors.

![Task 1](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Task1.png)

**TASK 2: Random sampling CMR reconstruction**

**1) Goal:** To develop a sampling-universal model that can robustly reconstruct CMR images 1) from different k-space trajectories (uniform, Guassian, and pseudo radial undersampling with temporal/parametric interleaving); 2) at different acceleration factors (acceleration factors from 4x to 24x, ACS not included for calculations). The proposed method is supposed to leverage deep learning algorithms to exploit the potential of random sampling, enabling faster acquisition times while maintaining high-quality image reconstructions.

**2) Note:** In TASK 2, participants are allowed to train **only one universal model** to reconstruct various data at the aforementioned different undersampling scenarios.

![Task 2](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Task2.png)

## Documentation

### The CMRxRecon Dataset
A total of 330 healthy volunteers are recruited for multi-contrast CMR imaging in our imaging center. The dataset include multi-contrast k-space data, consist of cardiac cine, T1/T2mapping, tagging, phase-contrast (i.e., flow2d), and dark-blood imaging. It also includes imaging of different anatomical views like long-axis (2-chamber, 3-chamber, and 4-chamber), short-axis (SAX), left ventricul outflow tract (LVOT), and aorta (transversal and sagittal views).

The released dataset includes 200 training data, 60 validation data, and 70 test data.

Training cases including fully sampled k-space data will be provided in '.mat' format.

Validation cases include under-sampled k-space data, sampling trajectories, and autocalibration signals (ACS, 16 lines or 16x16 regions) with various acceleration factors in '.mat' format.

Test cases include fully sampled k-space data, undersampled k-space data, sampling trajectories and autocalibration signals (ACS, 16 lines or 16x16 regions). Test cases will not be released before the challenge ends.

![Image](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Showimage.png)

## Package Structure
* `CMRxReconDemo`: contains parallel imaging reconstruction code
* `ChallengeDataFormat`: Explain the challenge data and the rules for data submission
* `Evaluation`: contains image quality evaluation code for validation and testing
* `Submission`: contains the structure for challenge submission

## Contact
The code is provided to support reproducible research. If the code is giving syntax error in your particular configuration or some files are missing then you may open an issue or email us at CMRxRecon@outlook.com

## Publication references
You are free to use and/or refer to the CMRxRecon challenge and datasets in your own research after the embargo period (Dec 2024), provided that you cite the following manuscripts: 

Reference of the imaging acquisition protocol: 
1. Wang C, Lyu J, Wang S, et al. CMRxRecon: An open cardiac MRI dataset for the competition of accelerated image reconstruction[J]. arXiv preprint arXiv:2309.10836, 2023.
2. Wang C, Li Y, Lv J, et al. Recommendation for Cardiac Magnetic Resonance Imaging-Based Phenotypic Study: Imaging Part. Phenomics. 2021, 1(4): 151-170. https://doi.org/10.1007/s43657-021-00018-x

Other reference (optional for citation):
1. Wang C, Jang J, Neisius U, et al. Black blood myocardial T2 mapping. Magnetic resonance in medicine. 2019, 81(1): 153-166. https://doi.org/10.1002/mrm.27360
2. Lyu J, Li G, Wang C, et al. Region-focused multi-view transformer-based generative adversarial network for cardiac cine MRI reconstruction[J]. Medical Image Analysis, 2023: 102760. https://doi.org/10.1016/j.media.2023.102760
3. Qin C, Schlemper J, Caballero J, et al. Convolutional recurrent neural networks for dynamic MR image reconstruction. IEEE transactions on medical imaging, 2018, 38(1): 280-290. https://doi.org/10.1109/TMI.2018.2863670.
4. Qin C, Duan J, Hammernik K, et al. Complementary time‐frequency domain networks for dynamic parallel MR image reconstruction. Magnetic Resonance in Medicine, 2021, 86(6): 3274-3291. https://doi.org/10.1002/mrm.28917
5. Lyu J, Tong X, Wang C. Parallel Imaging With a Combination of SENSE and Generative Adversarial Networks (GAN). Quantitative Imaging in Medicine and Surgery. 2020, 10(12): 2260–2273. https://doi.org/10.21037/qims-20-518.
6. Lyu J, Sui B, Wang C, et al. DuDoCAF: Dual-Domain Cross-Attention Fusion with Recurrent Transformer for Fast Multi-contrast MR Imaging. International Conference on Medical Image Computing and Computer-Assisted Intervention. Springer, Cham, 2022: 474-484. https://link.springer.com/chapter/10.1007/978-3-031-16446-0_45
7. Wang S, Qin C, Wang C, et al. The Extreme Cardiac MRI Analysis Challenge under Respiratory Motion (CMRxMotion). arXiv preprint arXiv:2210.06385, 2022. https://arxiv.org/abs/2210.06385
8. Gao S, Zhou H, Gao Y, Zhuang X. BayeSeg: Bayesian Modeling for Medical Image Segmentation with Interpretable Generalizability. Medical Image Analysis Volume 89, 102889, 2023 (Elsevier-MedIA 1st Prize & MICCAl Best Paper Award 2023) https://www.sciencedirect.com/science/article/pii/S1361841523001494
9. Wang Z, Qian C, Guo D, Sun H, Li R, Zhao B, Qu X, One-dimensional Deep Low-rank and Sparse Network for Accelerated MRI, IEEE Transactions on Medical Imaging, 42: 79-90, 2023. https://doi.org/10.1109/TMI.2022.3203312
10. Wang Z, et al., Deep Separable Spatiotemporal Learning for Fast Dynamic Cardiac MRI, arXiv preprint arXiv:2402.15939, 2024. https://arxiv.org/abs/2402.15939
