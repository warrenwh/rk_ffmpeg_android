
1) How to build ffmepg for Android
* Download Android NDK(android-ndk-r9d-linux-x86_64.tar.bz2) 
  from http://www.androiddevtools.cn/
* Unzip android-ndk-r9d-linux-x86_64.tar.bz2 to Your Path
  (eg.  /home/androd_ndk/android-ndk-r9d).
* Modify build_32.sh, Config your NDK path
  (eg. NDK=/home/androd_ndk/android-ndk-r9d)
* Move this project to Your_SDK_Root/external/ffmpeg
* Change Permissions of configure and build_32.sh. 
  #chmod 777 configure
  #chmod 777 build_32.sh
* execute ./build_32.sh, then you will find libffmpeg.so in directory(./android/armv7-a/) 
