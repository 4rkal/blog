---
title: Improving Golang API request performance
description: In this post I'll show you how I improved the performance of my go based cryptocurrency exchange aggregator. By making small changes, like using goroutines, switching JSON libraries and reusing HTTP handlers.
date: 2024-08-17T12:25:15+03:00
draft: false
tags:
  - programming
  - golang
  - cyphergoat
---
# The project
I recently started working on a *cryptocurrency exchange aggregator*. Basically I send out requests to a bunch of different exchanges and compare rates. This has to be made as fast as possible.
In this post, I’ll some show some tweaks that I made in order to boost my performance significantly. 

However keep in mind that I am not an expert (especially in go) and I am just sharing my findings from my own personal project. 
# Improvements
These improvements come in order of biggest improvement of runtime. 
### 1. Using goroutines
In any Go program, goroutines are essential for speed. The biggest boost I made was by sending requests concurrently. Since I need to hit up 12 different exchanges, sending these requests at the same time dropped my runtime from around 24 seconds to just ~3.

Goroutines are amazing and extremely easy to use. You should include them wherever possible. But always be careful of [Data Races](https://go.dev/doc/articles/race_detector)
### 2. Upgrading the JSON Library
I swapped out `encoding/json` for `github.com/json-iterator/go`. 
`jsoniter` is a fast JSON processing library that works as a drop-in replacement for the standard library, so I didn’t have to change any code, just a library switch.

**Benchmark Results**

To measure the performance improvements, I ran some benchmarks comparing `encoding/json` and `jsoniter`. Here’s a summary of the results:

```
goos: linux
goarch: amd64
pkg: apiSpeedImprove
cpu: AMD Ryzen 5 7640U w/ Radeon 760M Graphics      
BenchmarkEncodingJSON-12          140383              7381 ns/op
BenchmarkJSONIter-12              974605              1217 ns/op
PASS
ok      apiSpeedImprove 3.216s
```

So, `jsoniter` is about 6 times faster than the standard library.

### 3. Reusing HTTP Handlers
I started reusing HTTP handlers instead of creating new ones for each request. By setting up a handler once and reusing it, I cut down on the overhead of making new handlers for each request.

**Benchmark Results**

Here are the results of the benchmarks comparing reused handlers versus creating new handlers for each request:

```
goos: linux
goarch: amd64
pkg: apiSpeedImprove/httpReuse
cpu: AMD Ryzen 5 7640U w/ Radeon 760M Graphics      
BenchmarkReusedHandler-12                   2179            505189 ns/op
BenchmarkNewHandlerPerRequest-12            2341            507525 ns/op
PASS
ok      apiSpeedImprove/httpReuse       7.270s
```

Reusing HTTP handlers gave a slight performance boost compared to making a new handler for each request.
# Conclusion
With these tweaks I managed to cut the time it took to gather all the info from 24 seconds initially to about 2 seconds. Pretty solid improvement!

If you are interested the code for my benchmarks, it is available [here](https://git.4rkal.com/4rkal/goapiperf)

**If you enjoyed this post and want to support my work, you can [donate here](https://4rkal.com/donate).**
