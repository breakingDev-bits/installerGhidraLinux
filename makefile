# Settings
NIM_SOURCE = src/main.nim
FOLDER_BIN = binary/
OUTPUT_BIN = $(FOLDER_BIN)ghidra-installer

# Compile flags
NIM_FLAGS = c -d:danger --mm:arc --opt:speed -o:$(OUTPUT_BIN) 

build:
	nim $(NIM_FLAGS) $(NIM_SOURCE)
	mkdir -p $(FOLDER_BIN)
	@echo "Build complete. Binary size:"
	@du -h $(OUTPUT_BIN)

clean:
	rm -f $(OUTPUT_BIN)