
1) How to build Android Version
1 Download Android NDK(android-ndk-r9d-linux-x86_64.tar.bz2) from http://www.androiddevtools.cn/
2 Unzip android-ndk-r9d-linux-x86_64.tar.bz2 to Your Path(eg.  /home/androd_ndk/android-ndk-r9d).
3 Modify ffmpeg_compile.sh, Config your NDK path(eg. NDK=/home/androd_ndk/android-ndk-r9d)
4 Move this project to Your_SDK_Root/external/ffmpeg, then execute ./build_32.sh, then you will find libffmpeg.so in directory(./android/armv7-a/) 