# STM32 Project with ST HAL and GitHub Submodules

This project is a template for developing STM32F4xx applications using the ST
ST HAL libraries and CMSIS files. It is structured to be built with any IDE or
build system using gnu make, without the need for the STM32CubeIDE.

The ST HAL and CMSIS files are included as GitHub submodules for ease of
management and version control. It also includes a `shell.nix` file to provide a
reproducible development environment using the Nix package manager.

## Getting Started

### Prerequisites

- [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm)
- [Make](https://www.gnu.org/software/make/)
- [OpenOCD](http://openocd.org/) (for flashing and debugging)
- [Nix Package Manager](https://nixos.org/download.html) (optional, for reproducible development environments)

#### Note on `shell.nix`

This project includes a `shell.nix` file to provide a reproducible development
environment using the Nix package manager. Nix ensures that all necessary tools
and dependencies are available in a consistent manner, avoiding potential issues
with differing system configurations. If you have Nix installed, you can enter
the development environment by running `nix-shell` in the project directory.

### Cloning the Repository

To clone the repository and initialize the submodules, run:

```sh
git clone --recurse-submodules <repository URL>
```

If you have already cloned the repository without submodules, you can initialize them with:

```sh
git submodule update --init --recursive
```

### Before compiling

Copy vendor/cmsis_device_f4/Include/stm32f4xx.h into inc and select the target
STM32F4xx device used in your application (in stm32f4xx.h file). In this case,
STM32F437.

You will also need to copy system_stm32f4xx.c from
vendor\cmsis_device_f4\Source\Templates and put it into src/

Within vendor\cmsis_device_f4\Source\Templates there are also the startup files
for each microcontroller. I decided to roll my own, written in C (kindly taken
from https://kleinembedded.com/stm32-without-cubeide-part-1-the-bare-necessities/)
but you can use those if you prefer.

## Building the project

1. Navigate to the project directory:
	```sh
	cd stm32hal_example
	```
2. (Optional) Enter the Nix shell for a reproducible development environment:
	```sh
	nix-shell
	```
3. Build the project using Make:
	```sh
	make
	```

## Flashing the Firmware

Flash the firmware using OpenOCD:
```sh
make flash
```

### NOTE:
`make flash` is not implemented yet. The following procedure probably works:
1.Connect your STM32 board to your computer via USB.
2. Start OpenOCD with the appropriate configuration file for your board:
	```sh
	openocd -f board/<board>.cfg
	```
3. In another terminal, use telnet or nc to connect to the OpenOCD server:
	`telnet localhost 4444` or `nc localhost 4444`
4. Once connected, reset the board and halt the CPU: `reset halt`
5. Flash the firmware onto the board: `flash write_image erase firmware.elf`
6. Restart the board to run the new firmware: `reset run`

## Debugging

To start a debugging session:
1. Open a terminal and start OpenOCD:
	```sh
	openocd -f board/<board>.cfg
	```
2. In another terminal, start GDB:
	```sh
	arm-none-eabi-gdb firmware.elf
	```
3. Connect to the OpenOCD GDB server: `target remote localhost:3333`
4. Load the firmware: `load`
5. Set breakpoints, step through code, etc.

## Project Configuration

### HAL Configuration

The HAL configuration file (stm32f4xx_hal_conf.h) is located in the inc
directory. Modify this file to enable or disable specific HAL modules as needed.

### Interrupt Handlers

Interrupt handlers are defined in the stm32f4xx_interrupts.c file in the src
directory. Add your custom interrupt handling code here.

## License

The code in this repository is not 100% original and is provided as a reference
only. It serves as my working notes for STM32 development. Feel free to use it
as you see fit.

This project is provided "as-is" without any warranty of any kind, express or
implied, including but not limited to the warranties of merchantability, fitness
for a particular purpose, and noninfringement. In no event shall the authors be
liable for any claim, damages, or other liability, whether in an action of
contract, tort, or otherwise, arising from, out of, or in connection with the
project or the use or other dealings in the project.