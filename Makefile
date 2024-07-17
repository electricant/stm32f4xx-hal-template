CC=arm-none-eabi-gcc
MCUFLAGS=-mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -fsingle-precision-constant -finline-functions -Wdouble-promotion -std=gnu99
COMMONFLAGS=-Wall -ffunction-sections -fdata-sections

LINKER_FILE=$(CURDIR)/vendor/stm32f437xGxx.ld
LDFLAGS=-T $(LINKER_FILE)

INCLUDE=-I$(CURDIR)/inc
INCLUDE+=-I$(CURDIR)/vendor/stm32f4xx_hal_driver/Inc
INCLUDE+=-I$(CURDIR)/vendor/cmsis_core/Core/Include
INCLUDE+=-I$(CURDIR)/vendor/cmsis_device_f4/Include

BUILD_DIR=$(CURDIR)/build
BIN_DIR=$(CURDIR)

# vpath is used so object files are written to the current directory instead
# of the same directory as their source files
vpath %.c $(CURDIR)/src \
		  $(CURDIR)/vendor/stm32f4xx_hal_driver/Src

# Project Source Files
SRC=main.c
SRC+=startup.c
SRC+=system_stm32f4xx.c
SRC+=stm32f4xx_interrupts.c

# Standard Peripheral Source Files
SRC+=stm32f4xx_hal.c
SRC+=stm32f4xx_hal_gpio.c
SRC+=stm32f4xx_hal_cortex.c
SRC+=stm32f4xx_hal_rcc.c

# Compiler and linker flags
CFLAGS=$(COMMONFLAGS) $(MCUFLAGS) $(INCLUDE)
LDFLAGS=$(MCUFLAGS) -fno-exceptions -Wl,--gc-sections -T$(LINKER_FILE)

# Build list of object files
OBJ = $(SRC:%.c=$(BUILD_DIR)/%.o)

$(BUILD_DIR)/%.o: %.c
	@echo [CC] $(notdir $<)
	@$(CC) $(CFLAGS) $< -c -o $@

all: $(OBJ)
	@$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $(BUILD_DIR)/firmware.elf

clean:
	@echo [RM] OBJ
	@rm -f $(OBJ)
	@echo [RM] firmware.elf
	@rm -f firmware.elf
