
## Issues

- Does not support `MPI_THREAD_MULTIPLE`
- Info: http://www.vi-hps.org/upload/packages/scorep/OPEN_ISSUES-3.1.txt 

MPI support

> Score-P expects the MPI communication to be done on the master
> thread only. It is not that it is not possible to measure
> communication from other threads. But it is nearly impossible to
> do reasonable analysis when only ranks but not the real
> communication partners (threads) are known. There are efforts in
> the MPI forum to address this issue (endpoints). Until then, only
> MPI_THREAD_FUNNELED is supported.

Need to pass flag to instrument `pthreads`

> Please note that on systems where Pthreads don't need extra flags
> (like e.g., -pthread) to be compiled and linked (e.g., Cray, Blue
> Gene/Q), Score-P cannot instrument Pthreads automatically. You need
> to enable Pthread instrumentation manually via scorep's
> --thread=pthread option.

Sampling

> Sampling uses libunwind as external library. Please use version
> 1.1 or later as earlier versions occasionally segfaulted.
> libunwind used in combination with Intel MPI, even when sampling
> is not active, may mysteriously alter the application output
> just by linking libunwind. Thus, sampling/libunwind support is
> disabled when Intel MPI is detected.
