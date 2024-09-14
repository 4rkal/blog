---
title: How Microsoft is monetizing the GitHub code base
date: 2023-03-05T17:21:56+03:00
tags:
  - "programming"
  - "privacy"
---
Microsoft purchased GitHub in 2018, something many users are not aware of. After Microsoft’s acquisition of GitHub there have been many controversies like blocking private repositories and access to GitHub pages in certain countries and of course, GitHub Copilot.

# What is Github Copilot
GitHub Copilot is an artificial intelligence tool developed by GitHub and OpenAI to assist users of Visual Studio Code, Visual Studio, Neovim, and JetBrains integrated development environments (IDEs) by autocompleting code. Currently available by subscription to individual developers, the tool was first announced by GitHub on 29 June 2021, and works best for users coding in Python, JavaScript, TypeScript, Ruby, and Go.

# How does copilot work?
GitHub Copilot is powered by the OpenAI Codex, an artificial intelligence model created by OpenAI. The Generative Pre-trained Transformer 3 (GPT-3) language model, which uses deep learning to create text that resembles human speech, is improved and used in production as the OpenAI Codex.

Github copilot was trained on a selection of the English language, public GitHub repositories, including 59 gigabytes of Python code sourced from 54 million public GitHub repositories.

There still is a lot of controversy about whether GitHub should be allowed to do so, as most open source licences obviously don’t contain anything against analyzing your code with AI and selling it. Also, as AI is analyzing the code base it is not classified as derivative work which seems to be legal. However, it seems quite unethical by Microsoft as Copilot is a paid service that relies on analyzing other people’s code.
Read more:
https://www.theverge.com/2021/7/7/22561180/github-copilot-legal-copyright-fair-use-public-code


If copilot was free to use it would make a lot more sense as it utilizes FOSS(Free and open sourced software) in order to work. However with Microsoft’s decision to make copilot payed they are monetizing most off GitHub's code base which is an illegal grey zone.

Analyzing a huge amount of code without any security features has led to many problems like GitHub leaking phone numbers (I even encountered it while testing copilot out).

https://github.com/community/community/discussions/9584?sort=top?sort=top



Last but not least by using GitHub copilot you agree to the ToS which clearly states
```
GitHub Copilot gives you certain choices about how it uses the data it collects. User engagement data, including pseudonymous identifiers and general usage data, is required for the use of GitHub Copilot and will continue to be collected, processed, and shared with Microsoft and OpenAI as you use GitHub Copilot. You can choose whether your code snippets are collected and retained by GitHub and further processed and shared with Microsoft and OpenAI by adjusting your user settings.
```

# Conclusion
I personally don’t use or will ever use GitHub Copilot or recommend it to anyone for the following reasons:
1. Doesn't help you learn. Instead does the opposite.
2. Recommends other peoples’ phone numbers, emails and even aws keys. No features have been implemented to stop this as far as I know.
3. Tracks your usage and collects a lot of data. Like Source code that you are editing, related files and other files open in the same IDE or editor, URLs of repositories and files paths.
4. Is paid and proprietary. (You pay to be tracked)
5. Monetizes Open Source Software in an unethical way.
6. [Github CoPilot generates vulnerable code 40% of the time](https://cyber.nyu.edu/2021/10/15/ccs-researchers-find-github-copilot-generates-vulnerable-code-40-of-the-time/)

PS if you don’t want GitHub to legally index your code, you could try one of these [licenses](https://github.com/big-tech-sux/resistant-licenses) They might work

***If you enjoyed this article consider [supporting me](https://4rkal.com/donate)

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