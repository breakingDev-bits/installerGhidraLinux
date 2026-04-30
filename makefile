# Настройки
NIM_SOURCE = main.nim
OUTPUT_BIN = binary/ghidra-installer

nimCommand = c -d:danger --mm:arc -d:ssl --opt:speed -o:$(OUTPUT_BIN) 

build:
	nim $(nimCommand) $(NIM_SOURCE)
	strip -s $(OUTPUT_BIN)
	@echo "Build complete. Binary size:"
	@du -h $(OUTPUT_BIN)

clean:
	rm -f $(OUTPUT_BIN)