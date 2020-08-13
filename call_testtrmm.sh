#!/bin/bash

k_start=1
k_end=480
k_blocksize=1

# armie -msve-vector-bits=256 -i libinscount_emulated.so -- ./test_bl_dtrmm.x     $k $k
# ~/qemu.git/aarch64-linux-user/qemu-aarch64 -cpu max,sve256=on ./test_bl_dtrmm.x  $k $k

# qemu-aarch64: SVE 256
echo "SVE 256"
CMD_PRFX="/home/guodong/qemu.git/aarch64-linux-user/qemu-aarch64 -cpu max,sve256=on"

# COMMAND="./test_strmm"
COMMAND="./test_dtrmm"

# qemu-aarch64: SVE 512
# echo "SVE 512"
# CMD_PRFX="/home/guodong/qemu.git/aarch64-linux-user/qemu-aarch64 -cpu max,sve512=on"

# no prefix
# CMD_PRFX=

# generate random step lenght in between 1 and 10
STEP_THIS="shuf -i 1-10 -n 1"

LOGERR_FILE="logerr.t"
LOGOUT_FILE="logout.t"
echo "tail logerr.t and logout.t for test results"

rm -rf $LOGERR_FILE $LOGOUT_FILE

for (( k=k_start; k<=k_end; k+=k_blocksize ))
do

BLAS_SIDE='L' BLAS_UPLO='U' BLAS_TRANS='N' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='L' BLAS_UPLO='U' BLAS_TRANS='N' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))

BLAS_SIDE='L' BLAS_UPLO='U' BLAS_TRANS='T' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='L' BLAS_UPLO='U' BLAS_TRANS='T' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))

BLAS_SIDE='L' BLAS_UPLO='L' BLAS_TRANS='N' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='L' BLAS_UPLO='L' BLAS_TRANS='N' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))

BLAS_SIDE='L' BLAS_UPLO='L' BLAS_TRANS='T' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='L' BLAS_UPLO='L' BLAS_TRANS='T' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))

BLAS_SIDE='R' BLAS_UPLO='U' BLAS_TRANS='N' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='R' BLAS_UPLO='U' BLAS_TRANS='N' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))

BLAS_SIDE='R' BLAS_UPLO='U' BLAS_TRANS='T' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='R' BLAS_UPLO='U' BLAS_TRANS='T' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))

BLAS_SIDE='R' BLAS_UPLO='L' BLAS_TRANS='N' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='R' BLAS_UPLO='L' BLAS_TRANS='N' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))

BLAS_SIDE='R' BLAS_UPLO='L' BLAS_TRANS='T' BLAS_DIAG='U' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))
BLAS_SIDE='R' BLAS_UPLO='L' BLAS_TRANS='T' BLAS_DIAG='N' $CMD_PRFX $COMMAND $k $k 2>>$LOGERR_FILE 1>>$LOGOUT_FILE
k=$(($k+`$STEP_THIS`))


done

echo "END" >>$LOGERR_FILE
echo "END"
