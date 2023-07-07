.PHONY: all

# ----------------------------------------------------------------------------
# Local Variables
#
# ============================================================================

LIMIT ?= 100m
IMAGE_NAME = krasninja/python-oom:0.1.0

build:
	@docker rmi ${IMAGE_NAME} 2>/dev/null || true
	@docker build -t ${IMAGE_NAME} --rm --force-rm .

run:
	@docker run --rm -m ${LIMIT} ${IMAGE_NAME}
