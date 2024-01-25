include ./libproc.mk

userproc/%:
ifeq ($(dir $(PROC_FILE_TYPE)),image/)
	$(MAKE) userproc/image/$*
else
	echo "unexpected file type: $(PROC_FILE_TYPE)" >&2
endif

userproc/image/%:
	mkdir -p "$(shell dirname "$(UNIXCLOUD_DOWNLOAD_DIR)/$(PROC_FILEPATH_REL_UNIXCLOUD_UPLOAD_DIR)")"
	cp "$*" "$(UNIXCLOUD_DOWNLOAD_DIR)/$(PROC_FILEPATH_REL_UNIXCLOUD_UPLOAD_DIR)" \
		|| echo "copy failed: $* -> $(UNIXCLOUD_DOWNLOAD_DIR)/$(PROC_FILEPATH_REL_UNIXCLOUD_UPLOAD_DIR)"
