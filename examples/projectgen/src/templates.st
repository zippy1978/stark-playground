/**
 * File templates.
 */
 
func mainStTemplate(): string {
    return
"
func main(): int {
    println(\"Hello world !\")
    return 0
}
"
}

func makefileTemplate(): string {
    return
"
# Project settings
PROJECT_NAME=$(shell basename \"$(PWD)\")
PID=/tmp/.$(PROJECT_NAME).pid

# Directories
TARGET_DIR := ./target
SRC_DIR := ./src
STARK_FILES= $(wildcard $(SRC_DIR)/*.st)

# Stark configuration
RUNTIME := /usr/local/lib/stark/libstark.a
STARKC := starkc

# Make parameters
MAKEFLAGS += --silent

# Console colors
RED := \\033[0;31m
RED_BOLD := \\033[1;31m
GREEN := \\033[0;32m
GREEN_BOLD := \\033[1;32m
WHITE := \\033[0;37m
WHITE_BOLD := \\033[1;37m
NC := \\033[0m # No Color

# Logs
LOG_HEADER := $(WHITE)[$$(date +'%H:%M:%S') $(PROJECT_NAME)]$(NC)

all: help
help:
	@echo \"$(WHITE_BOLD)$(PROJECT_NAME)$(NC)program\"
	@echo \"Available build commands are: \"
	@echo \"- $(WHITE)clean$(NC): clean all generated target files\"
	@echo \"- $(WHITE)build$(NC): build program from sources\"
	@echo \"- $(WHITE)run$(NC)\t: run program\"
	@echo \"- $(WHITE)watch$(NC): rebuild and re-run program on source files change\"

clean:
	@echo \"$(LOG_HEADER)Cleaning...\"
	@-rm -rf ${TARGET_DIR}

build: clean
	@echo \"$(LOG_HEADER)Building...\"
	@-mkdir -p ${TARGET_DIR}
	@$(STARKC) -r $(RUNTIME) -o $(TARGET_DIR)/$(PROJECT_NAME) $(SRC_DIR)/*.st

run: build
	@echo \"$(LOG_HEADER)Runinng...\"
	@-$(TARGET_DIR)/$(PROJECT_NAME) $(ARGS)
	
stop-watch:
	@-touch $(PID)
	@-kill `cat $(PID)` 2> /dev/null || true
	@-rm $(PID)

run-watch: build
	@-$(TARGET_DIR)/$(PROJECT_NAME) 2>&1 & echo $$! > $(PID)

watch: run-watch
	@echo \"$(LOG_HEADER)Watching...\"
	@trap 'make stop-watch' EXIT; fswatch -0 $(SRC_DIR) | xargs -0 -n1 -I {} make stop-watch run-watch

"
}