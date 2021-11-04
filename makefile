# Makefile

.PHONY: build_docker
build_docker:
	docker build \
	--rm -f Dockerfile \
	-t yolo_flore_totale:v1 .

.PHONY: run_docker
run_docker:
	docker run \
	--gpus all \
	--shm-size=2g \
	--ulimit memlock=-1 \
	--ulimit stack=67108864 \
	--mount type=bind,source=$(PWD)/runs,target=/usr/src/app/runs \
	-it --rm -P yolo_flore_totale:v1

.PHONY: train
train:
	python train.py \
	--img 1024 \
	--batch 16 \
	--epochs 3 \
	--data data.yaml \
	--weights yolov5s.pt

.PHONY: export_onnx
export_onnx:
	python export.py \
	--weights runs/train/exp/weights/best.pt \
	--img 1024 \
	--batch 1

.PHONY: docs
docs:
	mkdocs serve

.PHONY: site
site:
	mkdocs build

.PHONY: install-docs
install-docs:
	pip install -r requirements-doc.txt --no-cache-dir