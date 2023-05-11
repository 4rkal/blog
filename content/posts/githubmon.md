---
title: "How Microsoft is monetizing the GitHub code base"
date: 2023-03-05T17:21:56+03:00
---
Microsoft purchased GitHub in 2018, something many users are not aware of. After Microsoft’s acquisition of GitHub there have been many controversies like blocking private repositories and access to GitHub pages in certain countries and of course, GitHub Copilot.

# What is Github Copilot
GitHub Copilot is an artificial intelligence tool developed by GitHub and OpenAI to assist users of Visual Studio Code, Visual Studio, Neovim, and JetBrains integrated development environments (IDEs) by autocompleting code. Currently available by subscription to individual developers, the tool was first announced by GitHub on 29 June 2021, and works best for users coding in Python, JavaScript, TypeScript, Ruby, and Go.

# How does copilot work?
GitHub Copilot is powered by the OpenAI Codex, an artificial intelligence model created by OpenAI. The Generative Pre-trained Transformer 3 (GPT-3) language model, which uses deep learning to create text that resembles human speech, is improved and used in production as the OpenAI Codex.

Github copilot was trained on a selection of the English language, public GitHub repositories, including 59 gigabytes of Python code sourced from 54 million public GitHub repositories.

There still is a lot of controversy about whether GitHub should be allowed to do so, as most open source licences obviously don’t contain anything against analyzing your code with AI and selling it. Also, as AI is analyzing the code base it is not classified as derivative work which seems to be legal. However, it seems quite unethical by Microsoft as Copilot is a paid service that relies on analyzing other people’s code.
{{< admonition type=tip title="Read more" open=false >}}
{{< link "https://www.theverge.com/2021/7/7/22561180/github-copilot-legal-copyright-fair-use-public-code" >}}
{{< /admonition >}}
If copilot was free to use it would make a lot more sense as it utilizes FOSS(Free and open sourced software) in order to work. However with Microsoft’s decision to make copilot payed they are monetizing most off GitHub's code base which is an illegal grey zone.

Analyzing a huge amount of code without any security features has led to many problems like GitHub leaking phone numbers (I even encountered it while testing copilot out).

https://github.com/community/community/discussions/9584?sort=top?sort=top

{{< tweet 1529178272638152704 >}}

And other random things

{{< tweet 1410749018183933952 >}}

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
6. {{< link href="https://cyber.nyu.edu/2021/10/15/ccs-researchers-find-github-copilot-generates-vulnerable-code-40-of-the-time/" content="Github CoPilot generates vulnerable code 40% of the time">}}

PS if you don’t want GitHub to legally index your code, you could try one of these {{< link href="https://github.com/big-tech-sux/resistant-licenses" content=licenses >}}. They might work

***If you enjoyed this article consider {{< link "../../donate" "supporting me" >}}***  

