# Directories
TARGET_DIR := ./target
TARGET_MODULES_DIR := $(TARGET_DIR)/stdmods
TARGET_EXAMPLES_DIR := $(TARGET_DIR)/examples
STARK_FILES= $(wildcard $(SRC_DIR)/*.st)
C_FILES= $(wildcard $(SRC_DIR)/*.c)

# Stark configuration
STARKC := starkc
#STARK_OPTS := -d -m $(TARGET_MODULES_DIR)
STARK_OPTS := -m $(TARGET_MODULES_DIR)
STARK_LINK_OPTS := -l "cc:-lpthread -lcurl -fsanitize=address -I/usr/local/Cellar/allegro/5.2.7.0/include -L/usr/local/Cellar/allegro/5.2.7.0/lib -lallegro_font -lallegro_image -lallegro"

# Native module
CLANG := /usr/bin/clang
CLANG_OPTS := -O3 -emit-llvm -c

# Make parameters
MAKEFLAGS += --silent

# Console colors
RED := \033[0;31m
RED_BOLD := \033[1;31m
GREEN := \033[0;32m
GREEN_BOLD := \\033[1;32m
WHITE := \033[0;37m
WHITE_BOLD := \033[1;37m
NC := \033[0m # No Color

# Logs
LOG_HEADER := $(WHITE)[$$(date +'%H:%M:%S')]$(NC)

all: help
help:
	@echo "$(WHITE_BOLD)stdmods$(NC)program"
	@echo "Available build commands are: "
	@echo "- $(WHITE)clean$(NC): clean all generated target files"
	@echo "- $(WHITE)build$(NC): build stdmods and examples from sources"

clean:
	@echo "$(LOG_HEADER)Cleaning..."
	@-rm -rf ${TARGET_DIR}

setup:
	@-mkdir -p ${TARGET_DIR}
	@-mkdir -p ${TARGET_MODULES_DIR}
	@-mkdir -p ${TARGET_EXAMPLES_DIR}

#stdmods

fs: setup
	@echo "$(LOG_HEADER)Building fs..."
	@$(STARKC) $(STARK_OPTS) -o $(TARGET_MODULES_DIR) ./stdmods/fs/src/*.st
	@echo "$(LOG_HEADER)Done..."

str: setup
	@echo "$(LOG_HEADER)Building str..."
	@$(STARKC) $(STARK_OPTS) -o $(TARGET_MODULES_DIR) ./stdmods/str/src/*.st
	@echo "$(LOG_HEADER)Done..."

http: setup
	@echo "$(LOG_HEADER)Building http..."
	@$(STARKC) $(STARK_OPTS) -o $(TARGET_MODULES_DIR) ./stdmods/http/src/*.st
	@echo "$(LOG_HEADER)Done..."

_allegro5: setup
	@echo "$(LOG_HEADER)Building _allegro5..."
	@-mkdir -p $(TARGET_MODULES_DIR)/_allegro5
	@$(CLANG) $(CLANG_OPTS) -o $(TARGET_MODULES_DIR)/_allegro5/_allegro5.bc ./stdmods/_allegro5/src/*.c
	@cp ./stdmods/_allegro5/src/bridge.sth $(TARGET_MODULES_DIR)/_allegro5/_allegro5.sth
	@echo "$(LOG_HEADER)Done..."

gfx: _allegro5
	@echo "$(LOG_HEADER)Building gfx..."
	@$(STARKC) $(STARK_OPTS) -o $(TARGET_MODULES_DIR) ./stdmods/gfx/src/*.st
	@echo "$(LOG_HEADER)Done..."

json: str
	@echo "$(LOG_HEADER)Building json..."
	@$(STARKC) $(STARK_OPTS) -o $(TARGET_MODULES_DIR) ./stdmods/json/src/*.st
	@echo "$(LOG_HEADER)Done..."

perf: setup
	@echo "$(LOG_HEADER)Building perf..."
	@$(STARKC) $(STARK_OPTS) -o $(TARGET_MODULES_DIR) ./stdmods/perf/src/*.st
	@echo "$(LOG_HEADER)Done..."

stdmods: fs str http gfx json perf

#examples

readfile: stdmods
	@echo "$(LOG_HEADER)Building readfile..."
	@$(STARKC) $(STARK_OPTS) -o $(TARGET_EXAMPLES_DIR)/readfile ./examples/readfile/src/*.st
	@echo "$(LOG_HEADER)Done..."

httpdownload: stdmods
	@echo "$(LOG_HEADER)Building httpdownload..."
	@$(STARKC) $(STARK_LINK_OPTS) $(STARK_OPTS) -o $(TARGET_EXAMPLES_DIR)/httpdownload ./examples/httpdownload/src/*.st
	@echo "$(LOG_HEADER)Done..."

jsonbench: stdmods
	@echo "$(LOG_HEADER)Building jsonbench..."
	@$(STARKC) $(STARK_LINK_OPTS) $(STARK_OPTS) -o $(TARGET_EXAMPLES_DIR)/jsonbench ./examples/jsonbench/src/*.st
	@echo "$(LOG_HEADER)Done..."

gfxdemo: stdmods
	@echo "$(LOG_HEADER)Building gfxdemo..."
	@$(STARKC) $(STARK_LINK_OPTS) $(STARK_OPTS) -o $(TARGET_EXAMPLES_DIR)/gfxdemo ./examples/gfxdemo/src/*.st
	@echo "$(LOG_HEADER)Done..."


examples: readfile httpdownload jsonbench gfxdemo

build: examples
