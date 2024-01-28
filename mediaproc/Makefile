include ./user.mk

export PATH := $(PATH):$(UNIXCLOUD_ROOT_DIR/mediaproc/scripts)

.PHONY: start
start: setup .WAIT watch/$(UNIXCLOUD_UPLOAD_DIR)

.PHONY: setup
setup:
	mkdir -p "$(UNIXCLOUD_DOWNLOAD_DIR)"

export PROC_FILEPATH ?= /dev/null

proc/%: PROC_FILEPATH=$*
proc/%:
	# Forward call to user processing.
	$(MAKE) "userproc/$*"

watch/%:
	inotifywait \
		--monitor\
		-e modify,create,moved_to \
		-r "$*" \
		--format "%w%f" \
		| xargs -P $(shell nproc --all) -I {} $(MAKE) "proc/{}"
