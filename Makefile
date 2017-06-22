CURL ?= curl

SVN_DIR ?= trunk
URL ?= https://llvm.org/svn/llvm-project/llvm/${SVN_DIR}

UTILS_DIR = utils/vim


DIRS += ftdetect/ ftplugin/ syntax/ indent/

SOURCES = ftdetect/llvm.vim ftdetect/tablegen.vim ftdetect/llvm-lit.vim \
          ftplugin/llvm.vim ftplugin/tablegen.vim \
            syntax/llvm.vim   syntax/tablegen.vim \
            indent/llvm.vim
FILES += ${SOURCES}

MISC = vimrc README
FILES += ${MISC}

FILES += LICENSE.TXT

all: ${DIRS} ${FILES}


%/:
	-mkdir -p '$@'

LICENSE.TXT:
	${CURL} '${URL}/$@' > '$@'

%:
	${CURL} '${URL}/${UTILS_DIR}/$@' > '$@'


distclean:
	-rm ${MISC}

clean:
	-rm ${FILES}
	-rmdir ${DIRS}


.PHONY: all clean distclean
