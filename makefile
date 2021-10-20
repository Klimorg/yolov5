# Makefile

# https://stackoverflow.com/questions/43133670/getting-docker-container-id-in-makefile-to-use-in-another-command
# I ran into the same problem and realised that makefiles take output from shell variables with the use of $$.

build_docker:
	docker build --rm -f Dockerfile -t yolo_flore_totale:v2 .

# docker run --gpus all --shm-size=2g --ulimit memlock=-1 --ulimit stack=67108864 -it --rm -P --mount type=bind,source=$(PWD),target=/media/vorph/Datas/template_segmentation -e TF_FORCE_GPU_ALLOW_GROWTH=true -e XLA_FLAGS='--xla_gpu_autotune_level=2' segmentation_project:v1
run_docker:
	docker run --gpus all --shm-size=2g --ulimit memlock=-1 --ulimit stack=67108864 -it --rm -P yolo_flore_totale:v2
#  --mount type=bind,source=$(PWD)/runs,target=/usr/src/app/runs