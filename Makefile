define PROJECT_HELP_MSG
Usage:
    make help                           show this message
    make pytorch                    	remove model
endef
export PROJECT_HELP_MSG

registry:=deepc
notebooks_dir?=$(PWD)
port?=9999
image:=$(registry)/pytorch36

define execute_notebook
 nvidia-docker run -it \
 -v $(notebooks_dir):/workspace/notebooks \
 $(1) \
 jupyter nbconvert --ExecutePreprocessor.timeout=-1 --inplace --to notebook --execute $(2)
endef

help:
	@echo "$$PROJECT_HELP_MSG" | less


start-notebook:
	nvidia-docker run -p $(port):$(port) -it -v $(notebooks_dir):/workspace/notebooks $(image) \
	jupyter notebook --port=$(port) --ip=* --no-browser --allow-root

all-cnn: mxnet-cnn gluon-cnn chainer-cnn pytorch-cnn cntk-cnn keras-tf-cnn keras-cntk-cnn tf-cnn
	@echo "All CNN notebooks run"

mxnet-cnn:
	$(call execute_notebook, deepc/mxnet36, notebooks/MXNet_CNN.ipynb)

gluon-cnn:
	$(call execute_notebook, deepc/mxnet36, notebooks/Gluon_CNN.ipynb)

chainer-cnn:
	$(call execute_notebook, deepc/chainer36, notebooks/Chainer_CNN.ipynb)

pytorch-cnn:
	$(call execute_notebook, deepc/pytorch36, notebooks/Pytorch_CNN.ipynb)

cntk-cnn:
	$(call execute_notebook, deepc/cntk36, notebooks/CNTK_CNN.ipynb)

keras-tf-cnn:
	$(call execute_notebook, deepc/tensorflow36, notebooks/Keras_TF_CNN.ipynb)

keras-cntk-cnn:
	$(call execute_notebook, deepc/keras36, notebooks/Keras_CNTK_CNN.ipynb)

tf-cnn:
	$(call execute_notebook, deepc/keras36, notebooks/Tensorflow_CNN.ipynb)

.PHONY: help start-notebook run-mxnet-cnn