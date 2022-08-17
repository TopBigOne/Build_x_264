#include <jni.h>
#include <string>
//#include "x264.h"

extern "C" JNIEXPORT jstring JNICALL
Java_com_jar_build_1x_1264_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    std::string hello = "Hello from C++";

   // x264_param_t param;
   // x264_param_default(&param);

    return env->NewStringUTF(hello.c_str());
}