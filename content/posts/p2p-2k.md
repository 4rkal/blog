---
title: "Someone tried to steal €2k from me on a P2P crypto trade. It didn't work."
date: 2026-05-04
tags: ["crypto", "bitcoin", "privacy", "robosats", "lightning"]
draft: false
---

Yesterday I got scammed on a P2P crypto trade. Or at least someone tried to. Here's what happened and how I managed to get Revolut to side with me.

## What happened

I took a sell order on [RoboSats](https://robosats.com) for 3,110,649 sats (~0.031 BTC) in exchange for €2,100 EUR via Revolut. The buyer had listed the order, I took it, the trade went through normally, I confirmed the Revolut payment and released the Bitcoin.

A few hours later I got a Revolut notification: "Verify your transaction." The buyer had filed a recall request on the €2,100 payment. Revolut froze my account pending review.

Classic P2P chargeback fraud. The buyer received the Bitcoin and then tried to claw back the fiat.

## What I did

The first thing I did was move my Revolut balance out before the account got fully restricted (this was mostly done by accident but still). That turned out to be the right call Revolut can only chase your Revolut balance, not money that's already elsewhere.

Then I went through Revolut's dispute flow. They asked for:

- Evidence of communication with the payer
- Evidence of the source of funds (cryptocurrency)
- A description of the payment

The problem is RoboSats uses an ephemeral encrypted in-app chat. I had no screenshots of the conversation. Most people at this point would have almost nothing to submit.

## The evidence package

What saved me was the RoboSats trade contract JSON file. After every completed trade, RoboSats generates a contract file you can download. Mine contained:

```json
{
  "coordinator": "Over the Moon",
  "order_id": ,
  "currency": "EUR",
  "maker": {
    "sent_fiat": 2100,
    "payment_hash": "33af4009cfdb4cdace...",
    "preimage": "51f63c31b7eb8c479a..."
  },
  "taker": {
    "sent_sats": 3110649,
    "received_fiat": 2100
  }
}
```

The `preimage` is cryptographic proof the Lightning payment settled. It can only be revealed upon successful payment completion — it's mathematically impossible to fake.

I put together a PDF declaration with:

- Full trade details (order ID, amounts, dates)
- The escrow note verbatim (which explicitly named the order ID and trade amount)
- The payment hash and preimage
- An explanation of how RoboSats escrow works
- A signed declaration that the payment was legitimate consideration for Bitcoin delivered

I uploaded that PDF, a screenshot from my lightning wallet, a screenshot from robosats of the trade and a screenshot of the JSON contract to Revolut's evidence form. Revolut accepted the dispute within a few hours

 I can't know exactly what tipped it, but the evidence package was as strong as I could make it given the circumstances.

### Template

If this ever happens to you, I've put together a ready-to-use PDF template, an exact copy of what I submitted. All the sections are pre-structured, you just fill in your trade details, paste in your payment hash and preimage from the JSON contract, sign it and upload it to your bank's dispute form.

**[Download the dispute template PDF here](/robosats_dispute_template.pdf)**

Fields to fill in are clearly marked. The document covers:

- Party details (your name, buyer's name, payment tags)
- Full trade details (order ID, amounts, dates, payment method)
- Lightning escrow evidence (escrow note verbatim, amounts, fees)
- Cryptographic proof section (payment hash, preimage, contract timestamp)
- How RoboSats escrow works — explained for non-technical reviewers
- Signed declaration

The most important fields are the `payment_hash` and `preimage` from your RoboSats JSON contract. Download that contract file before you close the order — it expires.

## Result

Account unfrozen, €2,100 stays mine.


## Lessons

A few things I'll do differently going forward:

- **Use SEPA/bank transfer instead of Revolut.** Revolut payments can be recalled. SEPA Instant is much harder to reverse.
- **Always download the trade contract JSON** before closing the RoboSats order. It takes one second and is your strongest evidence if something goes wrong.
- **Screenshot the in-trade chat** before the trade closes. Even a single message showing the buyer agreed to the terms helps enormously.
- **Move funds out of Revolut** before going through a dispute flow if you think it might go against you.

Whatever ultimately swayed Revolut, having thorough documentation clearly didn't hurt. Most people submitting to these dispute flows have very little — putting together a proper evidence package at minimum gives you a fighting chance.

---


## Avoiding P2P altogether

If you’d rather avoid the P2P route entirely, I built CypherGoat — a non-custodial swap aggregator that compares rates across 20+ exchanges.

It doesn’t handle fiat, but for crypto-to-crypto swaps it removes the direct counterparty risk you get with P2P (no dealing with individual buyers, chargebacks, etc.). Funds go straight to your wallet, though of course you’re still relying on the execution and reliability of the underlying providers.