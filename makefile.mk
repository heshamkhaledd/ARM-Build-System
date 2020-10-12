#################################################
#                                               #
# Build-System for ARM-Cortex Microprocessors	#
# Compiler used: armcl                          #
# Engineer: Hesham Khaled                       #
#                                               #
#################################################

# Project Name
PROJECT_NAME= 

#  GNU MAKE Macros
START_TIME=date +%s > ${OUT_DIR}/_time_.txt
TIME_MACRO=$$(($$(date +%s)-$$(cat ${OUT_DIR}/_time_.txt))) sec

# Compile process parts (DON'T EDIT THIS SECTION)
CC=armcl
SRC_DIRS=
CC_FLAGS=
CC_LINK_FLAGS=
INC_DIRS=
LIB_DIRS=
COMPILER_SEARCH_PATH=


#######################
# Project Directories #
#######################

# Add your source files, header files and static libraries directory in the following variables.

# C Source Files
SRC_DIRS+= 

# Include Paths
INC_DIRS+= 

# TivaWARE Include Paths (Remove if it's not used)
INC_DIRS+= "C:\ti\TivaWare_C_Series-2.2.0.295\driverlib"
INC_DIRS+= "C:\ti\TivaWare_C_Series-2.2.0.295\inc"

# Compiler's default include Path (Edit only if you changed the compiler)
INC_DIRS+= "C:\ti-cgt-arm_18.12.2.LTS\include"

# Precompiled Static Libraries Files (Remove if it's not used)
LIB_DIRS+= "C:\ti\TivaWare_C_Series-2.2.0.295\driverlib\ccs\Debug\driverlib.lib"
LIB_DIRS+= "C:\ti\TivaWare_C_Series-2.2.0.295\usblib\ccs\Debug\usblib.lib"

# Compiler Standard Libraries path (Edit only if you changed the compiler)
COMPILER_SEARCH_PATH+= "C:\ti-cgt-arm_18.12.2.LTS\lib"
COMPILER_SEARCH_PATH+= "C:\ti-cgt-arm_18.12.2.LTS\include"

# Output Directory
OUT_DIR=Build
# Object Files
OBJ_DIR=${OUT_DIR}/objs

# Linker script
LINKER_SCRIPT=lnk.cmd		# Provided in the compiler's directory.

#####################
#  Compiler Flags   #
#####################

# Procesor options
CC_FLAGS+= --silicon_version=7M4		# Which Microprocessor you are using
CC_FLAGS+= --code_state=16
CC_FLAGS+= --float_support=FPv4SPD16
CC_FLAGS+= --little_endian

# Debug options
CC_FLAGS+= --symdebug:dwarf
CC_FLAGS+= --symdebug:dwarf_version=3

# Optimalization options
CC_FLAGS+= --opt_level=0
CC_FLAGS+= --opt_for_speed=0

# Language options
CC_FLAGS+= --gcc
CC_FLAGS+= --c89
CC_FLAGS+= --relaxed_ansi
CC_FLAGS+= --float_operations_allowed=all
CC_FLAGS+= --plain_char=signed
CC_FLAGS+= --wchar_t=16

# Diagnostic options
CC_FLAGS+= --diag_wrap=on
CC_FLAGS+= --display_error_number
CC_FLAGS+= --diag_warning=225

# Runtime options
CC_FLAGS+= --embedded_constants=on
CC_FLAGS+= --unaligned_access=on
CC_FLAGS+= --enum_type=packed
CC_FLAGS+= --common=on
CC_FLAGS+= --abi=eabi
CC_FLAGS+= --small_enum

# Advanced options
CC_FLAGS+= --fp_mode=strict
CC_FLAGS+= --fp_reassoc=off
CC_FLAGS+= --sat_reassoc=off

# Directory options
CC_FLAGS+= --obj_directory=${OBJ_DIR}

# Default CC defines
CC_FLAGS+= --define=ccs="ccs" 
CC_FLAGS+= --define=TARGET_IS_TM4C123_RB1	# Change according to the appropriate Microcontroller
CC_FLAGS+= --define=PART_TM4C123GH6PM		# Change according to the appropriate Microcontroller


# Flags for  Linker
CC_LINK_FLAGS+= --rom_model
CC_LINK_FLAGS+= --map_file="${OUT_DIR}/${PROJECT_NAME}.map"
CC_LINK_FLAGS+= --heap_size=8192
CC_LINK_FLAGS+= --stack_size=32768
CC_LINK_FLAGS+= --reread_libs
CC_LINK_FLAGS+= --xml_link_info="${OUT_DIR}/${PROJECT_NAME}_linkInfo.xml"


# Add prefix for Include Path options
INC_PATH= ${addprefix --include_path=, ${INC_DIRS}}

# Add prefix for Precompiled Libraries Path options
LIB_PATH= ${addprefix --library=, ${LIB_DIRS}}

# Add prefix for Compiler Standard Libraries path options
STD_LIB_PATH= ${addprefix --search_path=, ${COMPILER_SEARCH_PATH}}


#############################
# Building Process Commands #
#############################

# Output Directory Command
ODIR_CMD= mkdir -p ${OUT_DIR} && mkdir -p ${OBJ_DIR}

# Compiler Command
COMPILE_CMD = ${CC} ${CC_FLAGS} ${INC_PATH} ${SRC_DIRS} ${ASM_DIRS}

# Linker Command
LINK_CMD = ${CC} --run_linker ${OBJ_DIR}/*.obj ${CC_LINK_FLAGS} ${STD_LIB_PATH} ${LIB_PATH} --output_file=${OUT_DIR}/${PROJECT_NAME}.out --library=${LINKER_SCRIPT}

# Clean Command
RM_CMD = rm -r ${OBJ_DIR} && rm ${OUT_DIR}/_time_.txt

# all: Build main binary
# '@' Before commands to suppress the GNU MAKE recipe from echoing
all:
	@echo 'Building Target: $@'
	@echo 'Invoking: ARM Compiler'
	@${ODIR_CMD}
	@${START_TIME}
	@${COMPILE_CMD}
	@echo 'Compiled Successfully!'
	@echo Compilation Time: ${TIME_MACRO} && echo ""
	@echo 'Linking Target Objects: $@'
	@echo 'Invoking: ARM Linker'
	@${START_TIME}
	@${LINK_CMD}
	@echo 'Linked Sucessfully!'
	@echo Linking Time: ${TIME_MACRO}
	@${RM_CMD}