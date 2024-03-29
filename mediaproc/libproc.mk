# Variables derived from PROC_FILEPATH.
PROC_FILEPATH_REL_UNIXCLOUD_ROOT_DIR = $(shell realpath --relative-to "$(UNIXCLOUD_ROOT_DIR)" "$(PROC_FILEPATH)")
PROC_FILEPATH_REL_UNIXCLOUD_UPLOAD_DIR = $(shell realpath --relative-to "$(UNIXCLOUD_UPLOAD_DIR)" "$(PROC_FILEPATH)")
PROC_FILEPATH_ABS = $(shell realpath "$(PROC_FILEPATH)")
PROC_FILENAME = $(shell basename "$(PROC_FILEPATH)")
PROC_FILE_TYPE = $(shell file -b --mime-type "$(PROC_FILEPATH)")
PROC_IMAGE_DATE = $(shell extract_date "$(PROC_FILEPATH_ABS)")
PROC_FILEPATH_TIMELINE = $(UNIXCLOUD_IMAGES_TIMELINE_DIR)/$(shell tr ' ' '/' <<< "$(PROC_IMAGE_DATE)")/$(PROC_FILENAME)
