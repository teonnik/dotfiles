## Information

https://www.cs.uoregon.edu/research/tau/docs/newguide/bk01pt01ch01.html

## Installation
- Flags `-mpi`, `-papi=<directory>`, `-pthread`, `-vampirtrace=<directory>`; (`-useropt='-g -I/usr/local/stl'`)
- Use `tau_validate` to validate installation

## Facts

- instrumentation based; three different ways based on degree of effort (dynamic, compile-time, manual)
- Supports both tracing and profiling via envs: `TAU_TRACE=1` and `TAU_PROFILE=1`
- Output directory via envs: `PROFILEDIR` and `TRACEDIR`; default is current
- Can merge and convert output files to different formats, eg OTF
- Data analysis: `pprof` can be used for quick summary; other options `ParaProf`, `Jumpshot` , `Vampir` (OTF)
- Quick reference: https://www.cs.uoregon.edu/research/tau/docs/newguide/bk01pt01ch05.html
- `tau_run` is least intrusive as no re-compilation needed
