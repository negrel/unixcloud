include ./libproc.mk

userproc/%:
ifeq ($(dir $(PROC_FILE_TYPE)),image/)
	$(MAKE) "userproc/image/$*"
else
	echo "unexpected file type: $(PROC_FILE_TYPE)" >&2
endif

userproc/image/%:
	mkdir -p "$(shell dirname "$(PROC_FILEPATH_TIMELINE)")"
	cp "$*" "$(PROC_FILEPATH_TIMELINE)" \
		|| echo "copy failed: $* -> $(PROC_FILEPATH_TIMELINE)"
