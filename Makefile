TARGET := bfi

CC := gcc

SRC_DIR := src

BUILD_DIR := build
BIN_DIR := bin

SRCS := $(shell find $(SRC_DIR) -name '*.c')

OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

DEPS := $(OBJS:.o=.d)
-include $(DEPS)

STD_FLAGS := -std=c11
WARN_FLAGS := -Wall -Wextra -Wpedantic -Werror
DBG_FLAGS  := -g
DEP_FLAGS := -MMD -MP

CFLAGS := $(STD_FLAGS) $(WARN_FLAGS) $(DBG_FLAGS) $(DEP_FLAGS)

LDLIBS :=
LDFLAGS :=

.DEFAULT_GOAL := all

all: $(BIN_DIR)/$(TARGET)

$(BIN_DIR)/$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ -o $@ $(LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR) $(BIN_DIR):
	@mkdir -p $@

gdb: all
	@gdb ./$(BIN_DIR)/$(TARGET)

clean:
	@rm -rf $(BUILD_DIR) $(BIN_DIR)

compile-db:
	@bear -- make -B all

.PHONY: all gdb clean compile-db
