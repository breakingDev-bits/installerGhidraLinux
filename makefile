NIM_SOURCE = src/main.nim
FOLDER_BIN = binary
OUTPUT_BIN = $(FOLDER_BIN)/ghidra-installer

NIM_FLAGS = c -d:danger --mm:arc --opt:speed --hints:off -o:$(OUTPUT_BIN)

all: buildForEveryone

prepare:
	@mkdir -p $(FOLDER_BIN)

buildForEveryone: prepare
	nim $(NIM_FLAGS) $(NIM_SOURCE)
	@echo "Build complete (Static/Universal). Binary size:"
	@du -h $(OUTPUT_BIN)

buildForMe: prepare
	nim $(NIM_FLAGS) -d:ForMe $(NIM_SOURCE)
	@echo "Build complete (Native optimization). Binary size:"
	@du -h $(OUTPUT_BIN)

clean:
	rm -rf $(FOLDER_BIN)
	@echo "Cleaned up."