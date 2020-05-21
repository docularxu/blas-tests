#!/bin/bash
k_start=1
k_end=480

for x in $(ls test*)
do
echo "Tests $x"

export OPENBLAS_INCX=1
export OPENBLAS_INCY=1
echo "INCX=${OPENBLAS_INCX} INCY=${OPENBLAS_INCY}"
./$x $k_start $k_end

export OPENBLAS_INCY=4
echo "INCX=${OPENBLAS_INCX} INCY=${OPENBLAS_INCY}"
./$x $k_start $k_end

export OPENBLAS_INCX=4
echo "INCX=${OPENBLAS_INCX} INCY=${OPENBLAS_INCY}"
./$x $k_start $k_end

export OPENBLAS_INCX=7
export OPENBLAS_INCY=7
echo "INCX=${OPENBLAS_INCX} INCY=${OPENBLAS_INCY}"
./$x $k_start $k_end

done
