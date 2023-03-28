
----- pid 4101 at 2023-03-28 16:56:07 -----
Cmd line: com.android.bluetooth
Build fingerprint: 'rockchip/rk3568_r/rk3568_r:11/RQ3A.210705.001/eng.ct.20230218.164915:userdebug/release-keys'
ABI: 'arm64'
Build type: optimized
Zygote loaded classes=15751 post zygote classes=216
Dumping registered class loaders
#0 dalvik.system.PathClassLoader: [], parent #1
#1 java.lang.BootClassLoader: [], no parent
#2 dalvik.system.PathClassLoader: [/system/app/Bluetooth/Bluetooth.apk], parent #1
Done dumping class loaders
Classes initialized: 153 in 33.607ms
Intern table: 30882 strong; 546 weak
JNI: CheckJNI is off; globals=644 (plus 45 weak)
Libraries: /system/app/Bluetooth/lib/arm64/libbluetooth_jni.so libandroid.so libaudioeffect_jni.so libcompiler_rt.so libicu_jni.so libjavacore.so libjavacrypto.so libjnigraphics.so libmedia_jni.so libopenjdk.so librs_jni.so libsfplugin_ccodec.so libsoundpool.so libstats_jni.so libwebviewchromium_loader.so (15)
Heap: 92% free, 2035KB/25MB; 63632 objects
Dumping cumulative Gc timings
Average major GC reclaim bytes ratio inf over 0 GC cycles
Average major GC copied live bytes ratio 0.721304 over 3 major GCs
Cumulative bytes moved 10018552
Cumulative objects moved 189088
Peak regions allocated 50 (12MB) / 768 (192MB)
Start Dumping histograms for 1 iterations for young concurrent copying
ScanImmuneSpaces:	Sum: 5.691ms 99% C.I. 5.691ms-5.691ms Avg: 5.691ms Max: 5.691ms
ProcessMarkStack:	Sum: 5.077ms 99% C.I. 5.077ms-5.077ms Avg: 5.077ms Max: 5.077ms
VisitConcurrentRoots:	Sum: 3.351ms 99% C.I. 3.351ms-3.351ms Avg: 3.351ms Max: 3.351ms
SweepSystemWeaks:	Sum: 2.062ms 99% C.I. 2.062ms-2.062ms Avg: 2.062ms Max: 2.062ms
InitializePhase:	Sum: 2.018ms 99% C.I. 2.018ms-2.018ms Avg: 2.018ms Max: 2.018ms
GrayAllDirtyImmuneObjects:	Sum: 1.173ms 99% C.I. 1.173ms-1.173ms Avg: 1.173ms Max: 1.173ms
FlipOtherThreads:	Sum: 620us 99% C.I. 620us-620us Avg: 620us Max: 620us
ClearFromSpace:	Sum: 438us 99% C.I. 438us-438us Avg: 438us Max: 438us
RecordFree:	Sum: 347us 99% C.I. 3us-344us Avg: 173.500us Max: 344us
ScanCardsForSpace:	Sum: 306us 99% C.I. 306us-306us Avg: 306us Max: 306us
VisitNonThreadRoots:	Sum: 206us 99% C.I. 206us-206us Avg: 206us Max: 206us
EnqueueFinalizerReferences:	Sum: 195us 99% C.I. 195us-195us Avg: 195us Max: 195us
ThreadListFlip:	Sum: 108us 99% C.I. 108us-108us Avg: 108us Max: 108us
SweepArray:	Sum: 107us 99% C.I. 107us-107us Avg: 107us Max: 107us
MarkZygoteLargeObjects:	Sum: 104us 99% C.I. 104us-104us Avg: 104us Max: 104us
(Paused)ClearCards:	Sum: 71us 99% C.I. 0.270us-63us Avg: 5.461us Max: 63us
CopyingPhase:	Sum: 67us 99% C.I. 67us-67us Avg: 67us Max: 67us
EmptyRBMarkBitStack:	Sum: 63us 99% C.I. 63us-63us Avg: 63us Max: 63us
(Paused)GrayAllNewlyDirtyImmuneObjects:	Sum: 60us 99% C.I. 60us-60us Avg: 60us Max: 60us
ProcessReferences:	Sum: 44us 99% C.I. 8us-36us Avg: 22us Max: 36us
SwapBitmaps:	Sum: 40us 99% C.I. 40us-40us Avg: 40us Max: 40us
ResumeRunnableThreads:	Sum: 35us 99% C.I. 35us-35us Avg: 35us Max: 35us
ReclaimPhase:	Sum: 33us 99% C.I. 33us-33us Avg: 33us Max: 33us
UnBindBitmaps:	Sum: 19us 99% C.I. 19us-19us Avg: 19us Max: 19us
ResetStack:	Sum: 18us 99% C.I. 18us-18us Avg: 18us Max: 18us
(Paused)FlipCallback:	Sum: 15us 99% C.I. 15us-15us Avg: 15us Max: 15us
(Paused)SetFromSpace:	Sum: 14us 99% C.I. 14us-14us Avg: 14us Max: 14us
FlipThreadRoots:	Sum: 9us 99% C.I. 9us-9us Avg: 9us Max: 9us
ResumeOtherThreads:	Sum: 4us 99% C.I. 4us-4us Avg: 4us Max: 4us
Done Dumping histograms
young concurrent copying paused:	Sum: 260us 99% C.I. 260us-260us Avg: 260us Max: 260us
young concurrent copying freed-bytes: Avg: 1670KB Max: 1670KB Min: 1670KB
Freed-bytes histogram: 1600:1
young concurrent copying total time: 22.561ms mean time: 22.561ms
young concurrent copying freed: 24226 objects with total size 1670KB
young concurrent copying throughput: 1.10118e+06/s / 74MB/s  per cpu-time: 77744363/s / 74MB/s
Average minor GC reclaim bytes ratio 0.431768 over 1 GC cycles
Average minor GC copied live bytes ratio 0.133428 over 1 minor GCs
Cumulative bytes moved 243544
Cumulative objects moved 3452
Peak regions allocated 50 (12MB) / 768 (192MB)
Total time spent in GC: 22.561ms
Mean GC size throughput: 72MB/s per cpu-time: 72MB/s
Mean GC object throughput: 1.0738e+06 objects/s
Total number of allocations 87858
Total bytes allocated 3705KB
Total bytes freed 1670KB
Free memory 23MB
Free memory until GC 23MB
Free memory until OOME 190MB
Total memory 25MB
Max memory 192MB
Zygote space size 3188KB
Total mutator paused time: 260us
Total time waiting for GC to complete: 86.915us
Total GC count: 1
Total GC time: 22.561ms
Total blocking GC count: 0
Total blocking GC time: 0
Native bytes total: 5307188 registered: 102308
Total native bytes at last GC: 5378888
/system/app/Bluetooth/oat/arm64/Bluetooth.odex: quicken
/system/framework/oat/arm64/javax.obex.odex: quicken
/system/framework/oat/arm64/android.test.base.odex: quicken
/system/framework/oat/arm64/android.hidl.base-V1.0-java.odex: quicken
/system/framework/oat/arm64/android.hidl.manager-V1.0-java.odex: quicken
Current JIT code cache size (used / resident): 0KB / 32KB
Current JIT data cache size (used / resident): 1KB / 32KB
Zygote JIT code cache size (at point of fork): 44KB / 48KB
Zygote JIT data cache size (at point of fork): 41KB / 44KB
Current JIT mini-debug-info size: 33KB
Current JIT capacity: 64KB
Current number of JIT JNI stub entries: 0
Current number of JIT code cache entries: 38
Total number of JIT compilations: 1
Total number of JIT compilations for on stack replacement: 0
Total number of JIT code cache collections: 0
Memory used for stack maps: Avg: 24B Max: 24B Min: 24B
Memory used for compiled code: Avg: 248B Max: 248B Min: 248B
Memory used for profiling info: Avg: 56B Max: 80B Min: 32B
Start Dumping histograms for 38 iterations for JIT timings
Compiling:	Sum: 113.166ms 99% C.I. 0.469ms-9.501ms Avg: 2.978ms Max: 9.856ms
TrimMaps:	Sum: 2.645ms 99% C.I. 27us-141us Avg: 69.605us Max: 141us
Done Dumping histograms
Memory used for compilation: Avg: 150KB Max: 466KB Min: 20KB
ProfileSaver total_bytes_written=0
ProfileSaver total_number_of_writes=0
ProfileSaver total_number_of_code_cache_queries=0
ProfileSaver total_number_of_skipped_writes=0
ProfileSaver total_number_of_failed_writes=0
ProfileSaver total_ms_of_sleep=5000
ProfileSaver total_ms_of_work=0
ProfileSaver total_number_of_hot_spikes=0
ProfileSaver total_number_of_wake_ups=0

suspend all histogram:	Sum: 157us 99% C.I. 3us-69us Avg: 22.428us Max: 69us
DALVIK THREADS (20):
"Signal Catcher" daemon prio=10 tid=6 Runnable
  | group="system" sCount=0 dsCount=0 flags=0 obj=0x132001b0 self=0xb40000749217a380
  | sysTid=4111 nice=-20 cgrp=default sched=0/0 handle=0x730fc5dcc0
  | state=R schedstat=( 23854832 449748 15 ) utm=1 stm=0 core=0 HZ=100
  | stack=0x730fb66000-0x730fb68000 stackSize=995KB
  | held mutexes= "mutator lock"(shared held)
  native: #00 pc 0000000000496558  /apex/com.android.art/lib64/libart.so (art::DumpNativeStack(std::__1::basic_ostream<char, std::__1::char_traits<char> >&, int, BacktraceMap*, char const*, art::ArtMethod*, void*, bool)+140)
  native: #01 pc 00000000005a00f8  /apex/com.android.art/lib64/libart.so (art::Thread::DumpStack(std::__1::basic_ostream<char, std::__1::char_traits<char> >&, bool, BacktraceMap*, bool) const+372)
  native: #02 pc 00000000005bcd38  /apex/com.android.art/lib64/libart.so (art::DumpCheckpoint::Run(art::Thread*)+892)
  native: #03 pc 00000000005b6d50  /apex/com.android.art/lib64/libart.so (art::ThreadList::RunCheckpoint(art::Closure*, art::Closure*)+528)
  native: #04 pc 00000000005b5f4c  /apex/com.android.art/lib64/libart.so (art::ThreadList::Dump(std::__1::basic_ostream<char, std::__1::char_traits<char> >&, bool)+1920)
  native: #05 pc 00000000005b5404  /apex/com.android.art/lib64/libart.so (art::ThreadList::DumpForSigQuit(std::__1::basic_ostream<char, std::__1::char_traits<char> >&)+756)
  native: #06 pc 00000000005621ec  /apex/com.android.art/lib64/libart.so (art::Runtime::DumpForSigQuit(std::__1::basic_ostream<char, std::__1::char_traits<char> >&)+196)
  native: #07 pc 0000000000576eb0  /apex/com.android.art/lib64/libart.so (art::SignalCatcher::HandleSigQuit()+1396)
  native: #08 pc 0000000000575ea4  /apex/com.android.art/lib64/libart.so (art::SignalCatcher::Run(void*)+348)
  native: #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"main" prio=5 tid=1 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x71e246a8 self=0xb4000074921787b0
  | sysTid=4101 nice=0 cgrp=default sched=0/0 handle=0x75b8bba4f8
  | state=S schedstat=( 220940990 9094168 248 ) utm=14 stm=7 core=3 HZ=100
  | stack=0x7fe8214000-0x7fe8216000 stackSize=8192KB
  | held mutexes=
  native: #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4)
  native: #01 pc 00000000000511d0  /apex/com.android.runtime/lib64/bionic/libc.so (eventfd_read+12)
  native: #02 pc 00000000003b19b0  /system/lib64/libbluetooth.so (semaphore_wait(semaphore_t*)+140)
  native: #03 pc 00000000002c4020  /system/lib64/libbluetooth.so (clean_up_stack() (.cfi)+168)
  native: #04 pc 00000000000219d0  /system/lib64/libbluetooth_jni.so (android::cleanupNative(_JNIEnv*, _jobject*)+36)
  at com.android.bluetooth.btservice.AdapterService.cleanupNative(Native method)
  at com.android.bluetooth.btservice.AdapterService.cleanup(AdapterService.java:765)
  at com.android.bluetooth.btservice.AdapterService.onUnbind(AdapterService.java:533)
  at android.app.ActivityThread.handleUnbindService(ActivityThread.java:4240)
  at android.app.ActivityThread.access$1700(ActivityThread.java:237)
  at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1942)
  at android.os.Handler.dispatchMessage(Handler.java:106)
  at android.os.Looper.loop(Looper.java:223)
  at android.app.ActivityThread.main(ActivityThread.java:7664)
  at java.lang.reflect.Method.invoke(Native method)
  at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:592)
  at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:947)

"perfetto_hprof_listener" prio=10 tid=7 Native (still starting up)
  | group="" sCount=1 dsCount=0 flags=1 obj=0x0 self=0xb400007492188200
  | sysTid=4112 nice=-20 cgrp=default sched=0/0 handle=0x730eb5fcc0
  | state=S schedstat=( 769124 4084 13 ) utm=0 stm=0 core=2 HZ=100
  | stack=0x730ea68000-0x730ea6a000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4)
  native: #01 pc 000000000001803c  /apex/com.android.art/lib64/libperfetto_hprof.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, ArtPlugin_Initialize::$_29> >(void*)+280)
  native: #02 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #03 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"ADB-JDWP Connection Control Thread" daemon prio=0 tid=8 WaitingInMainDebuggerLoop
  | group="system" sCount=1 dsCount=0 flags=1 obj=0x13200228 self=0xb400007492182e90
  | sysTid=4113 nice=-20 cgrp=default sched=0/0 handle=0x730ea61cc0
  | state=S schedstat=( 2753623 494376 20 ) utm=0 stm=0 core=0 HZ=100
  | stack=0x730e96a000-0x730e96c000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000009bae8  /apex/com.android.runtime/lib64/bionic/libc.so (__ppoll+8)
  native: #01 pc 000000000005a0dc  /apex/com.android.runtime/lib64/bionic/libc.so (poll+92)
  native: #02 pc 0000000000009d74  /apex/com.android.art/lib64/libadbconnection.so (adbconnection::AdbConnectionState::RunPollLoop(art::Thread*)+840)
  native: #03 pc 0000000000008400  /apex/com.android.art/lib64/libadbconnection.so (adbconnection::CallbackFunction(void*)+1428)
  native: #04 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #05 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"Jit thread pool worker thread 0" daemon prio=5 tid=9 Native
  | group="system" sCount=1 dsCount=0 flags=1 obj=0x132002a0 self=0xb400007492189dd0
  | sysTid=4114 nice=0 cgrp=default sched=0/0 handle=0x72c1e2dd00
  | state=S schedstat=( 3582832 1792875 10 ) utm=0 stm=0 core=0 HZ=100
  | stack=0x72c1d2f000-0x72c1d31000 stackSize=1023KB
  | held mutexes=
  native: #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28)
  native: #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136)
  native: #02 pc 00000000005bea38  /apex/com.android.art/lib64/libart.so (art::ThreadPool::GetTask(art::Thread*)+120)
  native: #03 pc 00000000005bdce4  /apex/com.android.art/lib64/libart.so (art::ThreadPoolWorker::Run()+144)
  native: #04 pc 00000000005bd7b4  /apex/com.android.art/lib64/libart.so (art::ThreadPoolWorker::Callback(void*)+192)
  native: #05 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #06 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"HeapTaskDaemon" daemon prio=5 tid=10 WaitingForTaskProcessor
  | group="system" sCount=1 dsCount=0 flags=1 obj=0x13200f18 self=0xb40000749218d570
  | sysTid=4115 nice=4 cgrp=default sched=0/0 handle=0x72c0d28cc0
  | state=S schedstat=( 25827250 1638875 25 ) utm=1 stm=0 core=0 HZ=100
  | stack=0x72c0c25000-0x72c0c27000 stackSize=1043KB
  | held mutexes=
  native: #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28)
  native: #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136)
  native: #02 pc 00000000002e3658  /apex/com.android.art/lib64/libart.so (art::gc::TaskProcessor::GetTask(art::Thread*)+532)
  native: #03 pc 00000000002e3f74  /apex/com.android.art/lib64/libart.so (art::gc::TaskProcessor::RunAllTasks(art::Thread*)+92)
  at dalvik.system.VMRuntime.runHeapTasks(Native method)
  at java.lang.Daemons$HeapTaskDaemon.runInternal(Daemons.java:531)
  at java.lang.Daemons$Daemon.run(Daemons.java:139)
  at java.lang.Thread.run(Thread.java:923)

"ReferenceQueueDaemon" daemon prio=5 tid=11 Waiting
  | group="system" sCount=1 dsCount=0 flags=1 obj=0x13200318 self=0xb40000749218f140
  | sysTid=4116 nice=4 cgrp=default sched=0/0 handle=0x72c0c1ecc0
  | state=S schedstat=( 1118834 1107167 13 ) utm=0 stm=0 core=0 HZ=100
  | stack=0x72c0b1b000-0x72c0b1d000 stackSize=1043KB
  | held mutexes=
  at java.lang.Object.wait(Native method)
  - waiting on <0x00bff437> (a java.lang.Class<java.lang.ref.ReferenceQueue>)
  at java.lang.Object.wait(Object.java:442)
  at java.lang.Object.wait(Object.java:568)
  at java.lang.Daemons$ReferenceQueueDaemon.runInternal(Daemons.java:217)
  - locked <0x00bff437> (a java.lang.Class<java.lang.ref.ReferenceQueue>)
  at java.lang.Daemons$Daemon.run(Daemons.java:139)
  at java.lang.Thread.run(Thread.java:923)

"FinalizerDaemon" daemon prio=5 tid=12 Waiting
  | group="system" sCount=1 dsCount=0 flags=1 obj=0x13200390 self=0xb40000749218b9a0
  | sysTid=4117 nice=4 cgrp=default sched=0/0 handle=0x72beb14cc0
  | state=S schedstat=( 921668 550375 9 ) utm=0 stm=0 core=1 HZ=100
  | stack=0x72bea11000-0x72bea13000 stackSize=1043KB
  | held mutexes=
  at java.lang.Object.wait(Native method)
  - waiting on <0x07adeda4> (a java.lang.Object)
  at java.lang.Object.wait(Object.java:442)
  at java.lang.ref.ReferenceQueue.remove(ReferenceQueue.java:190)
  - locked <0x07adeda4> (a java.lang.Object)
  at java.lang.ref.ReferenceQueue.remove(ReferenceQueue.java:211)
  at java.lang.Daemons$FinalizerDaemon.runInternal(Daemons.java:273)
  at java.lang.Daemons$Daemon.run(Daemons.java:139)
  at java.lang.Thread.run(Thread.java:923)

"FinalizerWatchdogDaemon" daemon prio=5 tid=13 Waiting
  | group="system" sCount=1 dsCount=0 flags=1 obj=0x13200408 self=0xb400007492190d10
  | sysTid=4118 nice=4 cgrp=default sched=0/0 handle=0x72bda0acc0
  | state=S schedstat=( 721958 1288583 6 ) utm=0 stm=0 core=2 HZ=100
  | stack=0x72bd907000-0x72bd909000 stackSize=1043KB
  | held mutexes=
  at java.lang.Object.wait(Native method)
  - waiting on <0x044e570d> (a java.lang.Daemons$FinalizerWatchdogDaemon)
  at java.lang.Object.wait(Object.java:442)
  at java.lang.Object.wait(Object.java:568)
  at java.lang.Daemons$FinalizerWatchdogDaemon.sleepUntilNeeded(Daemons.java:341)
  - locked <0x044e570d> (a java.lang.Daemons$FinalizerWatchdogDaemon)
  at java.lang.Daemons$FinalizerWatchdogDaemon.runInternal(Daemons.java:321)
  at java.lang.Daemons$Daemon.run(Daemons.java:139)
  at java.lang.Thread.run(Thread.java:923)

"Binder:4101_1" prio=5 tid=14 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x13200480 self=0xb400007492196080
  | sysTid=4119 nice=0 cgrp=default sched=0/0 handle=0x72bc802cc0
  | state=S schedstat=( 1806294 715459 12 ) utm=0 stm=0 core=2 HZ=100
  | stack=0x72bc70b000-0x72bc70d000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4)
  native: #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160)
  native: #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296)
  native: #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24)
  native: #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60)
  native: #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24)
  native: #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260)
  native: #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140)
  native: #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412)
  native: #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"Binder:4101_2" prio=5 tid=15 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x132004f8 self=0xb4000074921928e0
  | sysTid=4120 nice=0 cgrp=default sched=0/0 handle=0x72bb704cc0
  | state=S schedstat=( 10186168 3351623 17 ) utm=0 stm=0 core=2 HZ=100
  | stack=0x72bb60d000-0x72bb60f000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4)
  native: #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160)
  native: #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296)
  native: #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24)
  native: #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60)
  native: #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24)
  native: #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260)
  native: #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140)
  native: #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412)
  native: #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"Binder:4101_3" prio=5 tid=16 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x13200570 self=0xb4000074921944b0
  | sysTid=4121 nice=0 cgrp=default sched=0/0 handle=0x72ba606cc0
  | state=S schedstat=( 7769453 8387250 15 ) utm=0 stm=0 core=2 HZ=100
  | stack=0x72ba50f000-0x72ba511000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4)
  native: #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160)
  native: #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296)
  native: #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24)
  native: #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60)
  native: #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24)
  native: #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260)
  native: #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140)
  native: #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412)
  native: #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"Profile Saver" daemon prio=5 tid=17 Native
  | group="system" sCount=1 dsCount=0 flags=1 obj=0x132005e8 self=0xb400007492197c50
  | sysTid=4122 nice=9 cgrp=default sched=0/0 handle=0x72b8dcccc0
  | state=S schedstat=( 14242167 465208 14 ) utm=1 stm=0 core=2 HZ=100
  | stack=0x72b8cd5000-0x72b8cd7000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28)
  native: #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136)
  native: #02 pc 0000000000351a10  /apex/com.android.art/lib64/libart.so (art::ProfileSaver::Run()+484)
  native: #03 pc 00000000003566b0  /apex/com.android.art/lib64/libart.so (art::ProfileSaver::RunProfileSaverThread(void*)+176)
  native: #04 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #05 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"BT Service Callback Thread" prio=5 tid=19 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x13200740 self=0xb400007492199820
  | sysTid=4132 nice=0 cgrp=default sched=0/0 handle=0x72b0b7fcc0
  | state=S schedstat=( 2558500 1078584 10 ) utm=0 stm=0 core=1 HZ=100
  | stack=0x72b0a88000-0x72b0a8a000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28)
  native: #01 pc 000000000004edec  /apex/com.android.runtime/lib64/bionic/libc.so (__futex_wait_ex(void volatile*, bool, int, bool, timespec const*)+144)
  native: #02 pc 00000000000aeca0  /apex/com.android.runtime/lib64/bionic/libc.so (pthread_cond_wait+60)
  native: #03 pc 00000000000f4c68  /system/lib64/libchrome.so (base::ConditionVariable::Wait()+60)
  native: #04 pc 00000000000f546c  /system/lib64/libchrome.so (base::WaitableEvent::TimedWaitUntil(base::TimeTicks const&)+340)
  native: #05 pc 00000000000f52f0  /system/lib64/libchrome.so (base::WaitableEvent::Wait()+40)
  native: #06 pc 00000000000c00e8  /system/lib64/libchrome.so (base::MessagePumpDefault::Run(base::MessagePump::Delegate*)+196)
  native: #07 pc 00000000000e1f18  /system/lib64/libchrome.so (base::RunLoop::Run()+84)
  native: #08 pc 00000000001edde0  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::Run(std::__1::promise<void>)+304)
  native: #09 pc 00000000001edb8c  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::RunThread(bluetooth::common::MessageLoopThread*, std::__1::promise<void>) (.cfi)+48)
  native: #10 pc 00000000001edc24  /system/lib64/libbluetooth.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void (*)(bluetooth::common::MessageLoopThread*, std::__1::promise<void>), bluetooth::common::MessageLoopThread*, std::__1::promise<void> > >(void*) (.cfi)+100)
  native: #11 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #12 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"BluetoothActiveDeviceManager" prio=5 tid=20 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x132007b8 self=0xb40000749219cfc0
  | sysTid=4133 nice=0 cgrp=default sched=0/0 handle=0x72afa81cc0
  | state=S schedstat=( 1208377 230417 11 ) utm=0 stm=0 core=2 HZ=100
  | stack=0x72af97e000-0x72af980000 stackSize=1043KB
  | held mutexes=
  native: #00 pc 000000000009b9e8  /apex/com.android.runtime/lib64/bionic/libc.so (__epoll_pwait+8)
  native: #01 pc 0000000000019a2c  /system/lib64/libutils.so (android::Looper::pollInner(int)+184)
  native: #02 pc 000000000001990c  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+112)
  native: #03 pc 0000000000111240  /system/lib64/libandroid_runtime.so (android::android_os_MessageQueue_nativePollOnce(_JNIEnv*, _jobject*, long, int)+44)
  at android.os.MessageQueue.nativePollOnce(Native method)
  at android.os.MessageQueue.next(MessageQueue.java:335)
  at android.os.Looper.loop(Looper.java:183)
  at android.os.HandlerThread.run(HandlerThread.java:67)

"AudioPortEventHandler" prio=5 tid=21 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x13200898 self=0xb4000074921a0760
  | sysTid=4134 nice=0 cgrp=default sched=0/0 handle=0x72ae977cc0
  | state=S schedstat=( 1009751 630291 8 ) utm=0 stm=0 core=1 HZ=100
  | stack=0x72ae874000-0x72ae876000 stackSize=1043KB
  | held mutexes=
  native: #00 pc 000000000009b9e8  /apex/com.android.runtime/lib64/bionic/libc.so (__epoll_pwait+8)
  native: #01 pc 0000000000019a2c  /system/lib64/libutils.so (android::Looper::pollInner(int)+184)
  native: #02 pc 000000000001990c  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+112)
  native: #03 pc 0000000000111240  /system/lib64/libandroid_runtime.so (android::android_os_MessageQueue_nativePollOnce(_JNIEnv*, _jobject*, long, int)+44)
  at android.os.MessageQueue.nativePollOnce(Native method)
  at android.os.MessageQueue.next(MessageQueue.java:335)
  at android.os.Looper.loop(Looper.java:183)
  at android.os.HandlerThread.run(HandlerThread.java:67)

"AsyncTask #1" prio=5 tid=23 Waiting
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x13200a58 self=0xb4000074921a2330
  | sysTid=4136 nice=10 cgrp=default sched=0/0 handle=0x72ac763cc0
  | state=S schedstat=( 2451458 3995250 7 ) utm=0 stm=0 core=2 HZ=100
  | stack=0x72ac660000-0x72ac662000 stackSize=1043KB
  | held mutexes=
  at sun.misc.Unsafe.park(Native method)
  - waiting on an unknown object
  at java.util.concurrent.locks.LockSupport.park(LockSupport.java:190)
  at java.util.concurrent.SynchronousQueue$TransferStack.awaitFulfill(SynchronousQueue.java:459)
  at java.util.concurrent.SynchronousQueue$TransferStack.transfer(SynchronousQueue.java:362)
  at java.util.concurrent.SynchronousQueue.take(SynchronousQueue.java:920)
  at java.util.concurrent.ThreadPoolExecutor.getTask(ThreadPoolExecutor.java:1092)
  at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1152)
  at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:641)
  at java.lang.Thread.run(Thread.java:923)

"queued-work-looper" prio=5 tid=27 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x13200dc0 self=0xb4000074921a5ad0
  | sysTid=4143 nice=-2 cgrp=default sched=0/0 handle=0x72a833bcc0
  | state=S schedstat=( 540749 472791 5 ) utm=0 stm=0 core=1 HZ=100
  | stack=0x72a8238000-0x72a823a000 stackSize=1043KB
  | held mutexes=
  native: #00 pc 000000000009b9e8  /apex/com.android.runtime/lib64/bionic/libc.so (__epoll_pwait+8)
  native: #01 pc 0000000000019a2c  /system/lib64/libutils.so (android::Looper::pollInner(int)+184)
  native: #02 pc 000000000001990c  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+112)
  native: #03 pc 0000000000111240  /system/lib64/libandroid_runtime.so (android::android_os_MessageQueue_nativePollOnce(_JNIEnv*, _jobject*, long, int)+44)
  at android.os.MessageQueue.nativePollOnce(Native method)
  at android.os.MessageQueue.next(MessageQueue.java:335)
  at android.os.Looper.loop(Looper.java:183)
  at android.os.HandlerThread.run(HandlerThread.java:67)

"HwBinder:4101_1" prio=5 tid=28 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x13200ea0 self=0xb4000074921a76a0
  | sysTid=4145 nice=0 cgrp=default sched=1/1 handle=0x72a6035cc0
  | state=S schedstat=( 688918 4958 8 ) utm=0 stm=0 core=0 HZ=100
  | stack=0x72a5f3e000-0x72a5f40000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4)
  native: #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160)
  native: #02 pc 0000000000097cb8  /system/lib64/libhidlbase.so (android::hardware::IPCThreadState::getAndExecuteCommand()+172)
  native: #03 pc 00000000000992ac  /system/lib64/libhidlbase.so (android::hardware::IPCThreadState::joinThreadPool(bool)+96)
  native: #04 pc 00000000000a84a8  /system/lib64/libhidlbase.so (android::hardware::PoolThread::threadLoop()+24)
  native: #05 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260)
  native: #06 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140)
  native: #07 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412)
  native: #08 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #09 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"Binder:4101_4" prio=5 tid=2 Native
  | group="main" sCount=1 dsCount=0 flags=1 obj=0x12d40030 self=0xb4000074921aae40
  | sysTid=4153 nice=0 cgrp=default sched=0/0 handle=0x7313c3dcc0
  | state=S schedstat=( 853125 90125 4 ) utm=0 stm=0 core=3 HZ=100
  | stack=0x7313b46000-0x7313b48000 stackSize=995KB
  | held mutexes=
  native: #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4)
  native: #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160)
  native: #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296)
  native: #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24)
  native: #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60)
  native: #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24)
  native: #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260)
  native: #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140)
  native: #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412)
  native: #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)
  (no managed stack frames)

"bt_stack_manage" prio=5 (not attached)
  | sysTid=4126 nice=0 cgrp=default
  | state=S schedstat=( 7208540 830666 38 ) utm=0 stm=0 core=2 HZ=100
  native: #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4)
  native: #01 pc 00000000000511d0  /apex/com.android.runtime/lib64/bionic/libc.so (eventfd_read+12)
  native: #02 pc 00000000003b19b0  /system/lib64/libbluetooth.so (semaphore_wait(semaphore_t*)+140)
  native: #03 pc 00000000003af7cc  /system/lib64/libbluetooth.so (future_await(future_t*)+88)
  native: #04 pc 00000000003a8228  /system/lib64/libbluetooth.so (module_start_up(module_t const*)+284)
  native: #05 pc 00000000003c5214  /system/lib64/libbluetooth.so (bte_main_enable()+148)
  native: #06 pc 00000000002c4574  /system/lib64/libbluetooth.so (event_start_up_stack(void*) (.cfi)+204)
  native: #07 pc 000000000009e564  /system/lib64/libchrome.so (base::debug::TaskAnnotator::RunTask(char const*, base::PendingTask*)+196)
  native: #08 pc 00000000000be574  /system/lib64/libchrome.so (base::MessageLoop::RunTask(base::PendingTask*)+324)
  native: #09 pc 00000000000be910  /system/lib64/libchrome.so (base::MessageLoop::DoWork()+448)
  native: #10 pc 00000000000c008c  /system/lib64/libchrome.so (base::MessagePumpDefault::Run(base::MessagePump::Delegate*)+104)
  native: #11 pc 00000000000e1f18  /system/lib64/libchrome.so (base::RunLoop::Run()+84)
  native: #12 pc 00000000001edde0  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::Run(std::__1::promise<void>)+304)
  native: #13 pc 00000000001edb8c  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::RunThread(bluetooth::common::MessageLoopThread*, std::__1::promise<void>) (.cfi)+48)
  native: #14 pc 00000000001edc24  /system/lib64/libbluetooth.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void (*)(bluetooth::common::MessageLoopThread*, std::__1::promise<void>), bluetooth::common::MessageLoopThread*, std::__1::promise<void> > >(void*) (.cfi)+100)
  native: #15 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #16 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)

"POSIX timer 0" prio=5 (not attached)
  | sysTid=4127 nice=0 cgrp=default
  | state=S schedstat=( 238292 0 6 ) utm=0 stm=0 core=2 HZ=100
  native: #00 pc 000000000009b428  /apex/com.android.runtime/lib64/bionic/libc.so (__rt_sigtimedwait+8)
  native: #01 pc 000000000005a948  /apex/com.android.runtime/lib64/bionic/libc.so (__timer_thread_start(void*)+96)
  native: #02 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #03 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)

"POSIX timer 2" prio=5 (not attached)
  | sysTid=4129 nice=0 cgrp=default
  | state=S schedstat=( 413874 153709 8 ) utm=0 stm=0 core=2 HZ=100
  native: #00 pc 000000000009b428  /apex/com.android.runtime/lib64/bionic/libc.so (__rt_sigtimedwait+8)
  native: #01 pc 000000000005a948  /apex/com.android.runtime/lib64/bionic/libc.so (__timer_thread_start(void*)+96)
  native: #02 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #03 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)

"alarm_default_c" prio=5 (not attached)
  | sysTid=4130 nice=0 cgrp=default
  | state=S schedstat=( 1464164 5834 8 ) utm=0 stm=0 core=2 HZ=100
  native: #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4)
  native: #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160)
  native: #02 pc 00000000000997f8  /system/lib64/libhidlbase.so (android::hardware::IPCThreadState::transact(int, unsigned int, android::hardware::Parcel const&, android::hardware::Parcel*, unsigned int)+564)
  native: #03 pc 0000000000094c94  /system/lib64/libhidlbase.so (android::hardware::BpHwBinder::transact(unsigned int, android::hardware::Parcel const&, android::hardware::Parcel*, unsigned int, std::__1::function<void (android::hardware::Parcel&)>)+76)
  native: #04 pc 00000000000113a8  /system/lib64/android.hardware.bluetooth@1.0.so (android::hardware::bluetooth::V1_0::BpHwBluetoothHci::_hidl_close(android::hardware::IInterface*, android::hardware::details::HidlInstrumentor*)+232)
  native: #05 pc 00000000002cb404  /system/lib64/libbluetooth.so (hci_close()+340)
  native: #06 pc 00000000002ca2d0  /system/lib64/libbluetooth.so (startup_timer_expired(void*) (.cfi)+100)
  native: #07 pc 00000000003a9e50  /system/lib64/libbluetooth.so (alarm_ready_generic(alarm_t*, std::__1::unique_lock<std::__1::mutex>&)+388)
  native: #08 pc 00000000003a9340  /system/lib64/libbluetooth.so (alarm_queue_ready(fixed_queue_t*, void*) (.cfi)+124)
  native: #09 pc 00000000003af5a0  /system/lib64/libbluetooth.so (internal_dequeue_ready(void*) (.cfi)+108)
  native: #10 pc 00000000003b0d1c  /system/lib64/libbluetooth.so (run_reactor(reactor_t*, int)+412)
  native: #11 pc 00000000003b0b50  /system/lib64/libbluetooth.so (reactor_start(reactor_t*)+88)
  native: #12 pc 00000000003b2758  /system/lib64/libbluetooth.so (run_thread(void*) (.cfi)+188)
  native: #13 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #14 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)

"alarm_dispatche" prio=5 (not attached)
  | sysTid=4131 nice=0 cgrp=default
  | state=S schedstat=( 552998 16918 9 ) utm=0 stm=0 core=0 HZ=100
  native: #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4)
  native: #01 pc 00000000000511d0  /apex/com.android.runtime/lib64/bionic/libc.so (eventfd_read+12)
  native: #02 pc 00000000003b19b0  /system/lib64/libbluetooth.so (semaphore_wait(semaphore_t*)+140)
  native: #03 pc 00000000003a93fc  /system/lib64/libbluetooth.so (callback_dispatch(void*) (.cfi)+124)
  native: #04 pc 00000000003b29a4  /system/lib64/libbluetooth.so (work_queue_read_cb(void*) (.cfi)+124)
  native: #05 pc 00000000003b0d1c  /system/lib64/libbluetooth.so (run_reactor(reactor_t*, int)+412)
  native: #06 pc 00000000003b0b50  /system/lib64/libbluetooth.so (reactor_start(reactor_t*)+88)
  native: #07 pc 00000000003b2758  /system/lib64/libbluetooth.so (run_thread(void*) (.cfi)+188)
  native: #08 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #09 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)

"bt_hci_thread" prio=5 (not attached)
  | sysTid=4144 nice=0 cgrp=default
  | state=S schedstat=( 2360749 9626 14 ) utm=0 stm=0 core=1 HZ=100
  native: #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28)
  native: #01 pc 000000000004edec  /apex/com.android.runtime/lib64/bionic/libc.so (__futex_wait_ex(void volatile*, bool, int, bool, timespec const*)+144)
  native: #02 pc 00000000000aeca0  /apex/com.android.runtime/lib64/bionic/libc.so (pthread_cond_wait+60)
  native: #03 pc 00000000000f4c68  /system/lib64/libchrome.so (base::ConditionVariable::Wait()+60)
  native: #04 pc 00000000000f546c  /system/lib64/libchrome.so (base::WaitableEvent::TimedWaitUntil(base::TimeTicks const&)+340)
  native: #05 pc 00000000000f52f0  /system/lib64/libchrome.so (base::WaitableEvent::Wait()+40)
  native: #06 pc 00000000000c00e8  /system/lib64/libchrome.so (base::MessagePumpDefault::Run(base::MessagePump::Delegate*)+196)
  native: #07 pc 00000000000e1f18  /system/lib64/libchrome.so (base::RunLoop::Run()+84)
  native: #08 pc 00000000001edde0  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::Run(std::__1::promise<void>)+304)
  native: #09 pc 00000000001edb8c  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::RunThread(bluetooth::common::MessageLoopThread*, std::__1::promise<void>) (.cfi)+48)
  native: #10 pc 00000000001edc24  /system/lib64/libbluetooth.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void (*)(bluetooth::common::MessageLoopThread*, std::__1::promise<void>), bluetooth::common::MessageLoopThread*, std::__1::promise<void> > >(void*) (.cfi)+100)
  native: #11 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64)
  native: #12 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64)

----- end 4101 -----

----- Waiting Channels: pid 4101 at 2023-03-28 16:56:07 -----
Cmd line: com.android.bluetooth

sysTid=4101      eventfd_read
sysTid=4111      do_sigtimedwait
sysTid=4112      pipe_wait
sysTid=4113      poll_schedule_timeout.constprop.6
sysTid=4114      futex_wait_queue_me
sysTid=4115      futex_wait_queue_me
sysTid=4116      futex_wait_queue_me
sysTid=4117      futex_wait_queue_me
sysTid=4118      futex_wait_queue_me
sysTid=4119      binder_thread_read
sysTid=4120      binder_thread_read
sysTid=4121      binder_thread_read
sysTid=4122      futex_wait_queue_me
sysTid=4126      eventfd_read
sysTid=4127      do_sigtimedwait
sysTid=4129      do_sigtimedwait
sysTid=4130      binder_thread_read
sysTid=4131      eventfd_read
sysTid=4132      futex_wait_queue_me
sysTid=4133      ep_poll
sysTid=4134      ep_poll
sysTid=4136      futex_wait_queue_me
sysTid=4143      ep_poll
sysTid=4144      futex_wait_queue_me
sysTid=4145      binder_thread_read
sysTid=4153      binder_thread_read

----- end 4101 -----



----- pid 4101 at 2023-03-28 16:56:08 -----
Cmd line: com.android.bluetooth
ABI: 'arm64'

"droid.bluetooth" sysTid=4101
    #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000000511d0  /apex/com.android.runtime/lib64/bionic/libc.so (eventfd_read+12) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 00000000003b19b0  /system/lib64/libbluetooth.so (semaphore_wait(semaphore_t*)+140) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #03 pc 00000000002c4020  /system/lib64/libbluetooth.so (clean_up_stack() (.cfi)+168) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #04 pc 00000000000219d0  /system/lib64/libbluetooth_jni.so (android::cleanupNative(_JNIEnv*, _jobject*)+36) (BuildId: ef7d1f2539d1f12d4c43d58bcd629e16)
    #05 pc 000000000001c18c  /system/app/Bluetooth/oat/arm64/Bluetooth.odex (art_jni_trampoline+124) (BuildId: 39689492a6d6e21da00abeac91b9ea7ca8af167b)
    #06 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #07 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #08 pc 000000000031650c  /apex/com.android.art/lib64/libart.so (art::interpreter::ArtInterpreterToCompiledCodeBridge(art::Thread*, art::ArtMethod*, art::ShadowFrame*, unsigned short, art::JValue*)+376) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #09 pc 000000000030c5d0  /apex/com.android.art/lib64/libart.so (bool art::interpreter::DoCall<false, false>(art::ArtMethod*, art::Thread*, art::ShadowFrame&, art::Instruction const*, unsigned short, art::JValue*)+912) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #10 pc 000000000066efec  /apex/com.android.art/lib64/libart.so (MterpInvokeVirtual+840) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 000000000012d814  /apex/com.android.art/lib64/libart.so (mterp_op_invoke_virtual+20) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 0000000000218736  /system/app/Bluetooth/Bluetooth.apk (com.android.bluetooth.btservice.AdapterService.cleanup+230)
    #13 pc 000000000066f28c  /apex/com.android.art/lib64/libart.so (MterpInvokeVirtual+1512) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #14 pc 000000000012d814  /apex/com.android.art/lib64/libart.so (mterp_op_invoke_virtual+20) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #15 pc 0000000000217afa  /system/app/Bluetooth/Bluetooth.apk (com.android.bluetooth.btservice.AdapterService.onUnbind+10)
    #16 pc 0000000000303d54  /apex/com.android.art/lib64/libart.so (art::interpreter::Execute(art::Thread*, art::CodeItemDataAccessor const&, art::ShadowFrame&, art::JValue, bool, bool) (.llvm.15654337495489426524)+268) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #17 pc 000000000065dd90  /apex/com.android.art/lib64/libart.so (artQuickToInterpreterBridge+760) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #18 pc 000000000013cff8  /apex/com.android.art/lib64/libart.so (art_quick_to_interpreter_bridge+88) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #19 pc 00000000003f9cac  /system/framework/arm64/boot-framework.oat (android.app.ActivityThread.handleUnbindService+268) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #20 pc 00000000003e94dc  /system/framework/arm64/boot-framework.oat (android.app.ActivityThread$H.handleMessage+4540) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #21 pc 0000000000631a44  /system/framework/arm64/boot-framework.oat (android.os.Handler.dispatchMessage+180) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #22 pc 0000000000634f3c  /system/framework/arm64/boot-framework.oat (android.os.Looper.loop+1516) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #23 pc 00000000003fbeb0  /system/framework/arm64/boot-framework.oat (android.app.ActivityThread.main+752) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #24 pc 00000000001337e8  /apex/com.android.art/lib64/libart.so (art_quick_invoke_static_stub+568) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #25 pc 00000000001a8a88  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+228) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #26 pc 000000000054a6e8  /apex/com.android.art/lib64/libart.so (art::InvokeMethod(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, _jobject*, _jobject*, unsigned long)+1364) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #27 pc 00000000004cbe10  /apex/com.android.art/lib64/libart.so (art::Method_invoke(_JNIEnv*, _jobject*, _jobject*, _jobjectArray*)+52) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #28 pc 00000000000896f4  /apex/com.android.art/javalib/arm64/boot.oat (art_jni_trampoline+180) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #29 pc 0000000000889128  /system/framework/arm64/boot-framework.oat (com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run+136) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #30 pc 0000000000891858  /system/framework/arm64/boot-framework.oat (com.android.internal.os.ZygoteInit.main+2280) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #31 pc 00000000001337e8  /apex/com.android.art/lib64/libart.so (art_quick_invoke_static_stub+568) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #32 pc 00000000001a8a88  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+228) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #33 pc 000000000054911c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeWithVarArgs<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, std::__va_list)+448) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #34 pc 00000000005495d8  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeWithVarArgs<_jmethodID*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, _jmethodID*, std::__va_list)+92) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #35 pc 00000000004326f0  /apex/com.android.art/lib64/libart.so (art::JNI<true>::CallStaticVoidMethodV(_JNIEnv*, _jclass*, _jmethodID*, std::__va_list)+636) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #36 pc 0000000000099b84  /system/lib64/libandroid_runtime.so (_JNIEnv::CallStaticVoidMethod(_jclass*, _jmethodID*, ...)+124) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #37 pc 00000000000a0d10  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::start(char const*, android::Vector<android::String8> const&, bool)+836) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #38 pc 0000000000003574  /system/bin/app_process64 (main+1324) (BuildId: 725818c7651642761749444df1bc2755)
    #39 pc 000000000004973c  /apex/com.android.runtime/lib64/bionic/libc.so (__libc_init+108) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"Signal Catcher" sysTid=4111
    #00 pc 000000000009b428  /apex/com.android.runtime/lib64/bionic/libc.so (__rt_sigtimedwait+8) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 000000000005cb08  /apex/com.android.runtime/lib64/bionic/libc.so (sigwait+68) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000577238  /apex/com.android.art/lib64/libart.so (art::SignalCatcher::WaitForSignal(art::Thread*, art::SignalSet&)+428) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 0000000000575e58  /apex/com.android.art/lib64/libart.so (art::SignalCatcher::Run(void*)+272) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #04 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #05 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"perfetto_hprof_" sysTid=4112
    #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 000000000001803c  /apex/com.android.art/lib64/libperfetto_hprof.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, ArtPlugin_Initialize::$_29> >(void*)+280) (BuildId: 802425b64081f088576fc7efb9fa251d)
    #02 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #03 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"ADB-JDWP Connec" sysTid=4113
    #00 pc 000000000009bae4  /apex/com.android.runtime/lib64/bionic/libc.so (__ppoll+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 000000000005a0dc  /apex/com.android.runtime/lib64/bionic/libc.so (poll+92) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000009d74  /apex/com.android.art/lib64/libadbconnection.so (adbconnection::AdbConnectionState::RunPollLoop(art::Thread*)+840) (BuildId: 53c07830f8037d1a6555d61502f91d4f)
    #03 pc 0000000000008400  /apex/com.android.art/lib64/libadbconnection.so (adbconnection::CallbackFunction(void*)+1428) (BuildId: 53c07830f8037d1a6555d61502f91d4f)
    #04 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #05 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"Jit thread pool" sysTid=4114
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #02 pc 00000000005bea38  /apex/com.android.art/lib64/libart.so (art::ThreadPool::GetTask(art::Thread*)+120) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 00000000005bdce4  /apex/com.android.art/lib64/libart.so (art::ThreadPoolWorker::Run()+144) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #04 pc 00000000005bd7b4  /apex/com.android.art/lib64/libart.so (art::ThreadPoolWorker::Callback(void*)+192) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #05 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #06 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"HeapTaskDaemon" sysTid=4115
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #02 pc 00000000002e3658  /apex/com.android.art/lib64/libart.so (art::gc::TaskProcessor::GetTask(art::Thread*)+532) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 00000000002e3f74  /apex/com.android.art/lib64/libart.so (art::gc::TaskProcessor::RunAllTasks(art::Thread*)+92) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #04 pc 000000000001260c  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (art_jni_trampoline+124) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #05 pc 0000000000058844  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$HeapTaskDaemon.runInternal+196) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #06 pc 0000000000024b90  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$Daemon.run+160) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #07 pc 000000000015aaf8  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.Thread.run+72) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #08 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #09 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #10 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #13 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"ReferenceQueueD" sysTid=4116
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #02 pc 000000000049182c  /apex/com.android.art/lib64/libart.so (art::Monitor::Wait(art::Thread*, long, int, bool, art::ThreadState)+532) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 0000000000493028  /apex/com.android.art/lib64/libart.so (art::Monitor::Wait(art::Thread*, art::ObjPtr<art::mirror::Object>, long, int, bool, art::ThreadState)+280) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #04 pc 00000000000803fc  /apex/com.android.art/javalib/arm64/boot.oat (art_jni_trampoline+140) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #05 pc 000000000008fca0  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.Object.wait+48) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #06 pc 00000000000588e0  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$ReferenceQueueDaemon.runInternal+112) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #07 pc 0000000000024b90  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$Daemon.run+160) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #08 pc 000000000015aaf8  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.Thread.run+72) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #09 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #10 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #13 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #14 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"FinalizerDaemon" sysTid=4117
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #02 pc 000000000049182c  /apex/com.android.art/lib64/libart.so (art::Monitor::Wait(art::Thread*, long, int, bool, art::ThreadState)+532) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 0000000000493028  /apex/com.android.art/lib64/libart.so (art::Monitor::Wait(art::Thread*, art::ObjPtr<art::mirror::Object>, long, int, bool, art::ThreadState)+280) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #04 pc 00000000000803fc  /apex/com.android.art/javalib/arm64/boot.oat (art_jni_trampoline+140) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #05 pc 00000000000a3aac  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.ref.ReferenceQueue.remove+348) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #06 pc 00000000000a392c  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.ref.ReferenceQueue.remove+44) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #07 pc 0000000000057fd4  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$FinalizerDaemon.runInternal+356) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #08 pc 0000000000024b90  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$Daemon.run+160) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #09 pc 000000000015aaf8  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.Thread.run+72) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #10 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #13 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #14 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #15 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"FinalizerWatchd" sysTid=4118
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #02 pc 000000000049182c  /apex/com.android.art/lib64/libart.so (art::Monitor::Wait(art::Thread*, long, int, bool, art::ThreadState)+532) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 0000000000493028  /apex/com.android.art/lib64/libart.so (art::Monitor::Wait(art::Thread*, art::ObjPtr<art::mirror::Object>, long, int, bool, art::ThreadState)+280) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #04 pc 00000000000803fc  /apex/com.android.art/javalib/arm64/boot.oat (art_jni_trampoline+140) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #05 pc 000000000008fca0  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.Object.wait+48) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #06 pc 00000000000582c4  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$FinalizerWatchdogDaemon.sleepUntilNeeded+68) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #07 pc 0000000000058634  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$FinalizerWatchdogDaemon.runInternal+68) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #08 pc 0000000000024b90  /apex/com.android.art/javalib/arm64/boot-core-libart.oat (java.lang.Daemons$Daemon.run+160) (BuildId: 9b1be24fcb1b81d7c0f8a0fc41564f8192ace952)
    #09 pc 000000000015aaf8  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.Thread.run+72) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #10 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #13 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #14 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #15 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"Binder:4101_1" sysTid=4119
    #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"Binder:4101_2" sysTid=4120
    #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"Binder:4101_3" sysTid=4121
    #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"Profile Saver" sysTid=4122
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000001af840  /apex/com.android.art/lib64/libart.so (art::ConditionVariable::WaitHoldingLocks(art::Thread*)+136) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #02 pc 0000000000351a10  /apex/com.android.art/lib64/libart.so (art::ProfileSaver::Run()+484) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 00000000003566b0  /apex/com.android.art/lib64/libart.so (art::ProfileSaver::RunProfileSaverThread(void*)+176) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #04 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #05 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"bt_stack_manage" sysTid=4126
    #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000000511d0  /apex/com.android.runtime/lib64/bionic/libc.so (eventfd_read+12) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 00000000003b19b0  /system/lib64/libbluetooth.so (semaphore_wait(semaphore_t*)+140) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #03 pc 00000000003af7cc  /system/lib64/libbluetooth.so (future_await(future_t*)+88) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #04 pc 00000000003a8228  /system/lib64/libbluetooth.so (module_start_up(module_t const*)+284) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #05 pc 00000000003c5214  /system/lib64/libbluetooth.so (bte_main_enable()+148) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #06 pc 00000000002c4574  /system/lib64/libbluetooth.so (event_start_up_stack(void*) (.cfi)+204) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #07 pc 000000000009e564  /system/lib64/libchrome.so (base::debug::TaskAnnotator::RunTask(char const*, base::PendingTask*)+196) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #08 pc 00000000000be574  /system/lib64/libchrome.so (base::MessageLoop::RunTask(base::PendingTask*)+324) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #09 pc 00000000000be910  /system/lib64/libchrome.so (base::MessageLoop::DoWork()+448) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #10 pc 00000000000c008c  /system/lib64/libchrome.so (base::MessagePumpDefault::Run(base::MessagePump::Delegate*)+104) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #11 pc 00000000000e1f18  /system/lib64/libchrome.so (base::RunLoop::Run()+84) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #12 pc 00000000001edde0  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::Run(std::__1::promise<void>)+304) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #13 pc 00000000001edb8c  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::RunThread(bluetooth::common::MessageLoopThread*, std::__1::promise<void>) (.cfi)+48) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #14 pc 00000000001edc24  /system/lib64/libbluetooth.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void (*)(bluetooth::common::MessageLoopThread*, std::__1::promise<void>), bluetooth::common::MessageLoopThread*, std::__1::promise<void> > >(void*) (.cfi)+100) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #15 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #16 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"POSIX timer 0" sysTid=4127
    #00 pc 000000000009b428  /apex/com.android.runtime/lib64/bionic/libc.so (__rt_sigtimedwait+8) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 000000000005a948  /apex/com.android.runtime/lib64/bionic/libc.so (__timer_thread_start(void*)+96) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #03 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"POSIX timer 2" sysTid=4129
    #00 pc 000000000009b428  /apex/com.android.runtime/lib64/bionic/libc.so (__rt_sigtimedwait+8) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 000000000005a948  /apex/com.android.runtime/lib64/bionic/libc.so (__timer_thread_start(void*)+96) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #03 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"alarm_default_c" sysTid=4130
    #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000099c64  /system/lib64/libhidlbase.so (android::hardware::IPCThreadState::transact(int, unsigned int, android::hardware::Parcel const&, android::hardware::Parcel*, unsigned int)+1696) (BuildId: f1b1af43fb3fe11775c13562fd490b85)
    #03 pc 0000000000094c94  /system/lib64/libhidlbase.so (android::hardware::BpHwBinder::transact(unsigned int, android::hardware::Parcel const&, android::hardware::Parcel*, unsigned int, std::__1::function<void (android::hardware::Parcel&)>)+76) (BuildId: f1b1af43fb3fe11775c13562fd490b85)
    #04 pc 00000000000113a8  /system/lib64/android.hardware.bluetooth@1.0.so (android::hardware::bluetooth::V1_0::BpHwBluetoothHci::_hidl_close(android::hardware::IInterface*, android::hardware::details::HidlInstrumentor*)+232) (BuildId: e65a287c46c853d0f84116febc867449)
    #05 pc 00000000002cb404  /system/lib64/libbluetooth.so (hci_close()+340) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #06 pc 00000000002ca2d0  /system/lib64/libbluetooth.so (startup_timer_expired(void*) (.cfi)+100) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #07 pc 00000000003a9e50  /system/lib64/libbluetooth.so (alarm_ready_generic(alarm_t*, std::__1::unique_lock<std::__1::mutex>&)+388) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #08 pc 00000000003a9340  /system/lib64/libbluetooth.so (alarm_queue_ready(fixed_queue_t*, void*) (.cfi)+124) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #09 pc 00000000003af5a0  /system/lib64/libbluetooth.so (internal_dequeue_ready(void*) (.cfi)+108) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #10 pc 00000000003b0d1c  /system/lib64/libbluetooth.so (run_reactor(reactor_t*, int)+412) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #11 pc 00000000003b0b50  /system/lib64/libbluetooth.so (reactor_start(reactor_t*)+88) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #12 pc 00000000003b2758  /system/lib64/libbluetooth.so (run_thread(void*) (.cfi)+188) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #13 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #14 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"alarm_dispatche" sysTid=4131
    #00 pc 000000000009a7a4  /apex/com.android.runtime/lib64/bionic/libc.so (read+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 00000000000511d0  /apex/com.android.runtime/lib64/bionic/libc.so (eventfd_read+12) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 00000000003b19b0  /system/lib64/libbluetooth.so (semaphore_wait(semaphore_t*)+140) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #03 pc 00000000003a93fc  /system/lib64/libbluetooth.so (callback_dispatch(void*) (.cfi)+124) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #04 pc 00000000003b29a4  /system/lib64/libbluetooth.so (work_queue_read_cb(void*) (.cfi)+124) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #05 pc 00000000003b0d1c  /system/lib64/libbluetooth.so (run_reactor(reactor_t*, int)+412) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #06 pc 00000000003b0b50  /system/lib64/libbluetooth.so (reactor_start(reactor_t*)+88) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #07 pc 00000000003b2758  /system/lib64/libbluetooth.so (run_thread(void*) (.cfi)+188) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #08 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #09 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"BT Service Call" sysTid=4132
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 000000000004edec  /apex/com.android.runtime/lib64/bionic/libc.so (__futex_wait_ex(void volatile*, bool, int, bool, timespec const*)+144) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 00000000000aeca0  /apex/com.android.runtime/lib64/bionic/libc.so (pthread_cond_wait+60) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #03 pc 00000000000f4c68  /system/lib64/libchrome.so (base::ConditionVariable::Wait()+60) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #04 pc 00000000000f546c  /system/lib64/libchrome.so (base::WaitableEvent::TimedWaitUntil(base::TimeTicks const&)+340) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #05 pc 00000000000f52f0  /system/lib64/libchrome.so (base::WaitableEvent::Wait()+40) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #06 pc 00000000000c00e8  /system/lib64/libchrome.so (base::MessagePumpDefault::Run(base::MessagePump::Delegate*)+196) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #07 pc 00000000000e1f18  /system/lib64/libchrome.so (base::RunLoop::Run()+84) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #08 pc 00000000001edde0  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::Run(std::__1::promise<void>)+304) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #09 pc 00000000001edb8c  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::RunThread(bluetooth::common::MessageLoopThread*, std::__1::promise<void>) (.cfi)+48) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #10 pc 00000000001edc24  /system/lib64/libbluetooth.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void (*)(bluetooth::common::MessageLoopThread*, std::__1::promise<void>), bluetooth::common::MessageLoopThread*, std::__1::promise<void> > >(void*) (.cfi)+100) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #11 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #12 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"BluetoothActive" sysTid=4133
    #00 pc 000000000009b9e8  /apex/com.android.runtime/lib64/bionic/libc.so (__epoll_pwait+8) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000019a2c  /system/lib64/libutils.so (android::Looper::pollInner(int)+184) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #02 pc 000000000001990c  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+112) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #03 pc 0000000000111240  /system/lib64/libandroid_runtime.so (android::android_os_MessageQueue_nativePollOnce(_JNIEnv*, _jobject*, long, int)+44) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #04 pc 000000000020fc0c  /system/framework/arm64/boot-framework.oat (art_jni_trampoline+140) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #05 pc 0000000000638180  /system/framework/arm64/boot-framework.oat (android.os.MessageQueue.next+192) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #06 pc 0000000000634c38  /system/framework/arm64/boot-framework.oat (android.os.Looper.loop+744) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #07 pc 0000000000633bc0  /system/framework/arm64/boot-framework.oat (android.os.HandlerThread.run+544) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #08 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #09 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #10 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #13 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"AudioPortEventH" sysTid=4134
    #00 pc 000000000009b9e8  /apex/com.android.runtime/lib64/bionic/libc.so (__epoll_pwait+8) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000019a2c  /system/lib64/libutils.so (android::Looper::pollInner(int)+184) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #02 pc 000000000001990c  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+112) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #03 pc 0000000000111240  /system/lib64/libandroid_runtime.so (android::android_os_MessageQueue_nativePollOnce(_JNIEnv*, _jobject*, long, int)+44) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #04 pc 000000000020fc0c  /system/framework/arm64/boot-framework.oat (art_jni_trampoline+140) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #05 pc 0000000000638180  /system/framework/arm64/boot-framework.oat (android.os.MessageQueue.next+192) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #06 pc 0000000000634c38  /system/framework/arm64/boot-framework.oat (android.os.Looper.loop+744) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #07 pc 0000000000633bc0  /system/framework/arm64/boot-framework.oat (android.os.HandlerThread.run+544) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #08 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #09 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #10 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #13 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"AsyncTask #1" sysTid=4136
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000596984  /apex/com.android.art/lib64/libart.so (art::Thread::Park(bool, long)+444) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #02 pc 00000000004d27ac  /apex/com.android.art/lib64/libart.so (art::Unsafe_park(_JNIEnv*, _jobject*, unsigned char, long)+640) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #03 pc 00000000000837bc  /apex/com.android.art/javalib/arm64/boot.oat (art_jni_trampoline+140) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #04 pc 00000000001b4b9c  /apex/com.android.art/javalib/arm64/boot.oat (java.util.concurrent.SynchronousQueue$TransferStack.awaitFulfill+684) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #05 pc 00000000001b57c0  /apex/com.android.art/javalib/arm64/boot.oat (java.util.concurrent.SynchronousQueue$TransferStack.transfer+1744) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #06 pc 00000000002dbca0  /apex/com.android.art/javalib/arm64/boot.oat (java.util.concurrent.SynchronousQueue.take+80) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #07 pc 000000000029baa4  /apex/com.android.art/javalib/arm64/boot.oat (java.util.concurrent.ThreadPoolExecutor.getTask+468) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #08 pc 000000000029cfec  /apex/com.android.art/javalib/arm64/boot.oat (java.util.concurrent.ThreadPoolExecutor.runWorker+236) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #09 pc 000000000029a4d0  /apex/com.android.art/javalib/arm64/boot.oat (java.util.concurrent.ThreadPoolExecutor$Worker.run+64) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #10 pc 000000000015aaf8  /apex/com.android.art/javalib/arm64/boot.oat (java.lang.Thread.run+72) (BuildId: 7c6e1cc29957b182797f6da273a9ebedd0677697)
    #11 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #13 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #14 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #15 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #16 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"queued-work-loo" sysTid=4143
    #00 pc 000000000009b9e8  /apex/com.android.runtime/lib64/bionic/libc.so (__epoll_pwait+8) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000019a2c  /system/lib64/libutils.so (android::Looper::pollInner(int)+184) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #02 pc 000000000001990c  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+112) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #03 pc 0000000000111240  /system/lib64/libandroid_runtime.so (android::android_os_MessageQueue_nativePollOnce(_JNIEnv*, _jobject*, long, int)+44) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #04 pc 000000000020fc0c  /system/framework/arm64/boot-framework.oat (art_jni_trampoline+140) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #05 pc 0000000000638180  /system/framework/arm64/boot-framework.oat (android.os.MessageQueue.next+192) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #06 pc 0000000000634c38  /system/framework/arm64/boot-framework.oat (android.os.Looper.loop+744) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #07 pc 0000000000633bc0  /system/framework/arm64/boot-framework.oat (android.os.HandlerThread.run+544) (BuildId: cd61bcec1b4951530042eb7d90bc7e1bbacfadb1)
    #08 pc 0000000000133564  /apex/com.android.art/lib64/libart.so (art_quick_invoke_stub+548) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #09 pc 00000000001a8a6c  /apex/com.android.art/lib64/libart.so (art::ArtMethod::Invoke(art::Thread*, unsigned int*, unsigned int, art::JValue*, char const*)+200) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #10 pc 0000000000549c5c  /apex/com.android.art/lib64/libart.so (art::JValue art::InvokeVirtualOrInterfaceWithJValues<art::ArtMethod*>(art::ScopedObjectAccessAlreadyRunnable const&, _jobject*, art::ArtMethod*, jvalue const*)+460) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #11 pc 00000000005983b8  /apex/com.android.art/lib64/libart.so (art::Thread::CreateCallback(void*)+1288) (BuildId: b166e690e869dfd2136605668e71eb9d)
    #12 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #13 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"bt_hci_thread" sysTid=4144
    #00 pc 000000000004b20c  /apex/com.android.runtime/lib64/bionic/libc.so (syscall+28) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 000000000004edec  /apex/com.android.runtime/lib64/bionic/libc.so (__futex_wait_ex(void volatile*, bool, int, bool, timespec const*)+144) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 00000000000aeca0  /apex/com.android.runtime/lib64/bionic/libc.so (pthread_cond_wait+60) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #03 pc 00000000000f4c68  /system/lib64/libchrome.so (base::ConditionVariable::Wait()+60) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #04 pc 00000000000f546c  /system/lib64/libchrome.so (base::WaitableEvent::TimedWaitUntil(base::TimeTicks const&)+340) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #05 pc 00000000000f52f0  /system/lib64/libchrome.so (base::WaitableEvent::Wait()+40) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #06 pc 00000000000c00e8  /system/lib64/libchrome.so (base::MessagePumpDefault::Run(base::MessagePump::Delegate*)+196) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #07 pc 00000000000e1f18  /system/lib64/libchrome.so (base::RunLoop::Run()+84) (BuildId: 108e4edf136a6f866c6dbb489d8e9f71)
    #08 pc 00000000001edde0  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::Run(std::__1::promise<void>)+304) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #09 pc 00000000001edb8c  /system/lib64/libbluetooth.so (bluetooth::common::MessageLoopThread::RunThread(bluetooth::common::MessageLoopThread*, std::__1::promise<void>) (.cfi)+48) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #10 pc 00000000001edc24  /system/lib64/libbluetooth.so (void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void (*)(bluetooth::common::MessageLoopThread*, std::__1::promise<void>), bluetooth::common::MessageLoopThread*, std::__1::promise<void> > >(void*) (.cfi)+100) (BuildId: 306e172ba933ab28fd3d5cc230269a38)
    #11 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #12 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"HwBinder:4101_1" sysTid=4145
    #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000097cb8  /system/lib64/libhidlbase.so (android::hardware::IPCThreadState::getAndExecuteCommand()+172) (BuildId: f1b1af43fb3fe11775c13562fd490b85)
    #03 pc 00000000000992ac  /system/lib64/libhidlbase.so (android::hardware::IPCThreadState::joinThreadPool(bool)+96) (BuildId: f1b1af43fb3fe11775c13562fd490b85)
    #04 pc 00000000000a84a8  /system/lib64/libhidlbase.so (android::hardware::PoolThread::threadLoop()+24) (BuildId: f1b1af43fb3fe11775c13562fd490b85)
    #05 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #06 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #07 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #08 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #09 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

"Binder:4101_4" sysTid=4153
    #00 pc 000000000009aa24  /apex/com.android.runtime/lib64/bionic/libc.so (__ioctl+4) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #01 pc 0000000000057ac4  /apex/com.android.runtime/lib64/bionic/libc.so (ioctl+160) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #02 pc 0000000000051ad4  /system/lib64/libbinder.so (android::IPCThreadState::talkWithDriver(bool)+296) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #03 pc 0000000000051cc4  /system/lib64/libbinder.so (android::IPCThreadState::getAndExecuteCommand()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #04 pc 0000000000052584  /system/lib64/libbinder.so (android::IPCThreadState::joinThreadPool(bool)+60) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #05 pc 0000000000078828  /system/lib64/libbinder.so (android::PoolThread::threadLoop()+24) (BuildId: 53371609988c462a85ef53c62fbddad2)
    #06 pc 0000000000015414  /system/lib64/libutils.so (android::Thread::_threadLoop(void*)+260) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #07 pc 00000000000a103c  /system/lib64/libandroid_runtime.so (android::AndroidRuntime::javaThreadShell(void*)+140) (BuildId: c3a0e597d41326e219fb2138c6452b2e)
    #08 pc 0000000000014cd8  /system/lib64/libutils.so (thread_data_t::trampoline(thread_data_t const*)+412) (BuildId: 82f928b900a93dc07b75aefd76a59775)
    #09 pc 00000000000af880  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)
    #10 pc 00000000000500d0  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: 23b47e338fca2b85af1ec50fd590d7c7)

----- end 4101 -----

----- Waiting Channels: pid 4101 at 2023-03-28 16:56:08 -----
Cmd line: com.android.bluetooth

sysTid=4101      eventfd_read
sysTid=4111      do_sigtimedwait
sysTid=4112      pipe_wait
sysTid=4113      poll_schedule_timeout.constprop.6
sysTid=4114      futex_wait_queue_me
sysTid=4115      futex_wait_queue_me
sysTid=4116      futex_wait_queue_me
sysTid=4117      futex_wait_queue_me
sysTid=4118      futex_wait_queue_me
sysTid=4119      binder_thread_read
sysTid=4120      binder_thread_read
sysTid=4121      binder_thread_read
sysTid=4122      futex_wait_queue_me
sysTid=4126      eventfd_read
sysTid=4127      do_sigtimedwait
sysTid=4129      do_sigtimedwait
sysTid=4130      binder_thread_read
sysTid=4131      eventfd_read
sysTid=4132      futex_wait_queue_me
sysTid=4133      ep_poll
sysTid=4134      ep_poll
sysTid=4136      futex_wait_queue_me
sysTid=4143      ep_poll
sysTid=4144      futex_wait_queue_me
sysTid=4145      binder_thread_read
sysTid=4153      binder_thread_read

----- end 4101 -----

