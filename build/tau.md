## Information

https://www.cs.uoregon.edu/research/tau/docs/newguide/bk01pt01ch01.html

## Facts
- instrumentation based
  - Three different methods each with different degree of intrusion:
- Supports both tracing and profiling via envs: `TAU_TRACE=1` and `TAU_PROFILE=1`
- Output directory via envs: `PROFILEDIR` and `TRACEDIR`; default is current
- Can merge and convert output files to different formats, eg OTF
- `pprof` can be used for quick summary
