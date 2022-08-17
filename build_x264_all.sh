#!/bin/bash

#for arch in armeabi-v7a libs.arm64-v8a x86_64
for arch in arm64-v8a x86_64
do
    bash build_x264.sh $arch
done
