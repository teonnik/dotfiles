 

Does not support `MPI_THREAD_MULTIPLE`

From http://www.vi-hps.org/upload/packages/scorep/OPEN_ISSUES-3.1.txt 

> Score-P expects the MPI communication to be done on the master
> thread only. It is not that it is not possible to measure
> communication from other threads. But it is nearly impossible to
> do reasonable analysis when only ranks but not the real
> communication partners (threads) are known. There are efforts in
> the MPI forum to address this issue (endpoints). Until then, only
> MPI_THREAD_FUNNELED is supported.
