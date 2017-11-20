## Results

Run on [Data Science Virtual Machine](https://azure.microsoft.com/en-us/services/virtual-machines/data-science-virtual-machines/) NC12

### ResNet-50 Feature Extraction (2048D vector)

| DL Library                               | Images/s GPU | Images/s CPU |
| ---------------------------------------- | ----------------- | ----------------- |
| [ONNX_Caffe2](ResNet50-Caffe(ONNX).ipynb)               | 74.9                | 6.4               |
| [Caffe2](ResNet50-Caffe2.ipynb)               | 68.1                | 5.8               |
| [MXNet](ResNet50-MXNet.ipynb)                 | 139.1                | 35.0               |
| [CNTK](ResNet50-CNTK.ipynb)                   | 79.0                | 12.2               |
| [PyTorch](ResNet50-PyTorch.ipynb)             | 125.5                | 6.2               |
| [Tensorflow](ResNet50-TF.ipynb)       | 145.3                | 15.0               |
| [Keras(CNTK)](ResNet50-Keras(CNTK).ipynb)      | 40.1                | 4.1               |
| [Keras(TF)](ResNet50-Keras(TF).ipynb)          | 93.4                | 13.0               |

