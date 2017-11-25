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


run-mxnet-cnn:
	$(call execute_notebook, deepc/mxnet36, notebooks/MXNet_CNN.ipynb)

run-chainer-cnn:
	$(call execute_notebook, deepc/chainer36, notebooks/Chainer_CNN.ipynb)

.PHONY: help start-notebook run-mxnet-cnn