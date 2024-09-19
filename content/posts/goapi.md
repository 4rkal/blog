---
title: Improving Go API request performance
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
BenchmarkNewHttpClientEachRequest-12                3360            300058 ns/op
BenchmarkReuseHttpClient-12                         6470            175472 ns/op
PASS
ok      apiSpeedImprove/httpReuse       4.010s
```

Reusing HTTP handlers gave a solid performance boost compared to making a new handler for each request.
# Conclusion
With these tweaks I managed to cut the time it took to gather all the info from 24 seconds initially to about 2 seconds. Pretty solid improvement!

If you are interested the code for my benchmarks, it is available [here](https://git.4rkal.com/4rkal/goapiperf)

**If you enjoyed this post and want to support my work, you can [donate here](https://4rkal.com/donate).**

<div style="text-align: left; margin: 0 auto;">
    <form method="post" action="https://newsletter.4rkal.com/subscription/form" style="background: #2c2c2c; color: #f0f0f0; border-radius: 8px; padding: 15px; max-width: 500px; box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2); font-family: Arial, sans-serif;">
        <div style="display: flex; flex-direction: column; gap: 10px;">
            <h3 style="margin: 0; color: #f0f0f0; font-size: 18px;">Subscribe</h3>
            <input type="hidden" name="nonce"/>
            <input type="email" name="email" required placeholder="E-mail" style="width: 100%; padding: 10px; border: 1px solid #666; border-radius: 4px; background: #333; color: #f0f0f0; box-sizing: border-box;"/>
            <div style="display: flex; flex-direction: column; gap: 8px;">
                <label style="margin: 0; color: #f0f0f0; display: none;">
                    <input id="78a75" type="checkbox" name="l" checked value="78a75b30-472d-4790-a5d5-7f2ed49662a4" style="accent-color: #fff;"/>
                    Weekly Roundup
                </label>
                <span style="color: #d0d0d0; display: none;">Where I share what I’ve been up to that week, including articles I’ve published, cool finds, tips and tricks, and more!</span>
                <label style="margin: 0; color: #f0f0f0; display: none;">
                    <input id="b3964" type="checkbox" name="l" checked value="b3964560-37b0-43d3-9df9-26589fd6bf8d" style="accent-color: #fff;"/>
                    New Posts
                </label>
                <span style="color: #d0d0d0; display: none;">Receive an email every time I post something new on my blog</span>
            </div>
            <input type="submit" value="Subscribe" style="width: 100%; padding: 10px; border: none; border-radius: 4px; background: #fff; color: #007bff; font-size: 14px; cursor: pointer; transition: background-color 0.3s ease, box-shadow 0.3s ease; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);"/>
        </div>
        <p style="text-align: center; margin-top: 10px; color: #d0d0d0; font-size: 10px; margin-bottom:0px;">
            No spam, no ads. Unsubscribe at any time.
        </p>
    </form>
</div>