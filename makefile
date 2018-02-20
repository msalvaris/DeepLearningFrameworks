.ONESHELL:
SHELL := /bin/bash

define PROJECT_HELP_MSG
Usage:
	make help                           show this message
	make mxnet_nb                  		run mxnet notebook server
	make keras_nb                  		run keras notebook server
	make tensorflow_nb                  run keras notebook server
	make cntk_nb                  		run cntk notebook server
	make pytorch_nb                  	run pytorch notebook server
	make chainer_nb                  	run chainer notebook server
endef
export PROJECT_HELP_MSG

NOTEBOOKS_DIR:=$(shell pwd)
GPU_TYPE:=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader|head -1| cut -d ' ' -f 2|cut -d '-' -f 1)

CNTK_IMAGE:=""masalvar/cnkt:p36-cuda9-cudnn7-devel"
PYTORCH_IMAGE:="masalvar/pytorch:p36-cuda9-cudnn7-devel"
KERAS_IMAGE:="masalvar/keras:p36-cuda9-cudnn7-devel"
CHAINER_IMAGE="masalvar/chainer:p36-cuda9-cudnn7-devel"
MXNET_IMAGE="masalvar/mxnet:p36-cuda9-cudnn7-devel"
CAFFE2_IMAGE=""masalvar/caffe2:p36-cuda9-cudnn7-devel"
TF_IMAGE=""masalvar/tensorflow:p36-cuda9-cudnn7-devel"

define serve_notebbook
 nvidia-docker run -it \
 -v $(1):/workspace/notebooks \
 -p 9999:9999 \
 $(2) \
 jupyter notebook --port=9999 --ip=* --allow-root --no-browser --notebook-dir=/workspace/notebooks
endef


define execute_notebook
 nvidia-docker run -it \
 -v $(1):/workspace/notebooks \
 $(2) \
 /bin/bash -c "cd /workspace/notebooks; jupyter nbconvert --ExecutePreprocessor.timeout=-1 --to notebook --execute $(3).ipynb --output $(3)_$(GPU_TYPE).ipynb"
endef

help:
	@echo "$$PROJECT_HELP_MSG" | less


#------ NOTEBOOKS --------------------------------------------------------

mxnet_nb:
	$(call serve_notebbook, $(NOTEBOOKS_DIR), $(MXNET_IMAGE))

keras_nb:
	$(call serve_notebbook, $(NOTEBOOKS_DIR), $(KERAS_IMAGE))

cntk_nb:
	$(call serve_notebbook, $(NOTEBOOKS_DIR), $(CNTK_IMAGE))

pytorch_nb:
	$(call serve_notebbook, $(NOTEBOOKS_DIR), $(PYTORCH_IMAGE))

chainer_nb:
	$(call serve_notebbook, $(NOTEBOOKS_DIR), $(CHAINER_IMAGE))

caffe2_nb:
	$(call serve_notebbook, $(NOTEBOOKS_DIR), $(CAFFE2_IMAGE))

tensorflow_nb:
	$(call serve_notebbook, $(NOTEBOOKS_DIR), $(TF_IMAGE))


#------ EXECUTION --------------------------------------------------------

exec_all: chainer_cnn_exec cntk_cnn_exec mxnet_cnn_exec gluon_cnn_exec keras_cntk_cnn_exec keras_tf_cnn_exec \
			pytorch_exec tensorflow_exec

caffe2_cnn_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(CAFFE2_IMAGE), Caffe2_CNN)

chainer_cnn_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(CHAINER_IMAGE), Chainer_CNN)

cntk_cnn_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(CNTK_IMAGE), CNTK_CNN)

mxnet_cnn_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(MXNET_IMAGE), MXNet_CNN)

gluon_cnn_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(MXNET_IMAGE), Gluon_CNN)

keras_cntk_cnn_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(KERAS_IMAGE), Keras_CNTK_CNN)

keras_tf_cnn_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(KERAS_IMAGE), Keras_TF_CNN)

pytorch_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(PYTORCH_IMAGE), Pytorch_CNN)

tensorflow_exec:
	$(call execute_notebook, $(NOTEBOOKS_DIR), $(PYTORCH_IMAGE), Tensorflow_CNN)


.PHONY: help
