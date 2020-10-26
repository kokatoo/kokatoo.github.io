---
layout: post
title: "Options Synthetics"
date: 2020-10-21 01:30:06 +0800
img : bs1.gif
tags: options
---

When employing options strategies, people generally cover very little on synthetics as it seem to be more for market makers or arbitragers than for retail investors. Synthetics can help transform from one position to another equivalent position giving another perspective and clarity. One simple example is the covered call strategy $$\{+u\mathpunct{,} -c\}$$ being essentially equivalent to the naked short put $$\{-p\}$$ in terms of pnl and risk profile. 

Thinking of covered calls as equivalent to naked puts might help in terms of rolling deep ITM calls when the time value of the equivalent put options approaches 0. Also do note that deep ITM options' bid/ask spread is generally higher and it might be more worthwhile to short naked puts as the spread is tighter and the leverage it gives you.

<div class="toc" markdown="1">
# Contents:
- [Put-Call Parity](#parity)
- [Conversion/Reversal](#cr)
- [Pin Risk](#pin)
- [Box](#box)
- [Jelly Roll](#jelly)
</div>

## <a name="parity"></a>Put-Call Parity

Put-call parity states that the price of a European style call and put options with the same strike $$K$$, and maturity should satisfy the following relationship:

$$\begin{aligned}
C - P &= D(F - K)\\
C - P &= S - D\mathbin{.}K\\
C &= P + S - D\mathbin{.}K\\
P &= C - S + D\mathbin{.}K
\end{aligned}$$

with $$F$$ as the forward price, $$S$$ as the spot price of the underlying and $$D$$ as the discount factor with respect to the risk-free rate. $$(D\mathbin{.}K)$$ can be thought of as cash with interest or zero coupon bonds that will mature to the strike price if the call is exercised while $$S$$ is the underlying $$u$$ that will cover the put if exercised.

## <a name="cr"></a>Conversion/Reversal

Conversions and reversals are examples of locks strategies where pnl are locked at the initiation of the trades. More examples of locks strategies like boxes and jelly rolls (which are combination of conversions and reversals) will be covered later. 

A conversion is a spread that consists of a long underlying, short call, and long put at the same strike and maturity: $$\{+u\mathpunct{,} -c\mathpunct{, } +p\}$$

A reversal is the counterparty to a conversion: $$\{-u\mathpunct{,} +c\mathpunct{, } -p\}$$

To calculate the price of a C/R, we have to involve the strike price $$k$$.

Conversion:

$$\begin{alignedat}{2}
&Buy &&Sell\\
P = (&u + p)\: -\: (&&k + c)
\end{alignedat}$$

Reversal:

$$\begin{alignedat}{2}
&Buy &&Sell\\
P = (&k + c)\: -\: (&&u + p)
\end{alignedat}$$

We can picture the transactions this way. For the conversion, at initiation we buy the underlying and put and sell the call at a price of $$(u + p - c)$$. At expiration either the call will be assigned or put option will be exercised. This will result in selling the underlying at $$-k$$ giving us a net pnl of $$(k - u + c - p)$$. $$(k - u)$$ is the pnl from the underlying and and $$(c - p)$$ is the pnl from the options. If you make money on the underlying you should lose money on the options and vice versa.

Similarly for the reversal, at initiation we sell the underlying and put and buy the call at a price of $$(c - u - p)$$. At expiration, either the call will be exercised or put option will be assigned. This will result in buying the underlying at $$k$$ giving us a net pnl of $$(u + p - k - c)$$. $$(u - k)$$ is the pnl from the underlying and and $$(p - c)$$ is the pnl from the options.

To create a synthetic long underlying based on put-call parity:
<br/>

$$\begin{aligned}
S &= C - P + K\\
S - K &= C - P
\end{aligned}$$

$$\begin{aligned}
-S &= P - C - K\\
K - S &= P - C
\end{aligned}$$

Note the similarity with the C/R formula. We can create a synthetic long underlying by buying a call option and selling a put option at the same strike. The pnl payoff diagram will be the same as the underlying. Upon expiration, for long underlying $$(S - K)$$ is the pnl and it's equivalent to $$(C - P)$$, $$\{+c, -p\}$$. Similarly, $$(K - S)$$ is the pnl for the short position and it's equivalent to $$(P - C)$$, $$\{+p, -c\}$$.

We shall define a conversion and reversal as follow:

<br/>

$$\begin{aligned}
conversion &= + u + p - c = 0\\
reversal &= - u - p + c = 0
\end{aligned}$$

C/Rs can be used to transform same strike combos to other synthetic combinations.

## <a name="pin"></a>Pin Risk

Things get a little trickier when the closing price is close to the options' strike price. If we are short the option, we do not know for certain whether we will be assigned. For example, supposed the counterparty of the short option gets to decide whether to exercise the option after the closing price on expiration date and something happen in the market. Some correlated assets' market which has not been closed indicate a swing in the price. Despite the option being OTM, the counterparty might choose to exercise the option. Thereby we are being stucked with a position where there is nothing we can do about until the market opens, subjecting to an adverse price of the underlying. This is known as Pin Risk.

## <a name="box"></a>Box

Boxes are locks which are combination of C/Rs with the same expiration date. 

Long Box is where you have the reversal $$\{-u\mathpunct{,} +c_{1}\mathpunct{,} -p_{1}\}$$ on the lower strike and conversion $$\{+u \mathpunct{,} -c_{2} \mathpunct{,} +p_{2}\}$$ on the higher strike. The underlyings basically cancel each other out. This is basically a combination of a bull call spread and a bear put spread.

Short box is the opposite where you have the conversion $$\{+u\mathpunct{,} -c_{1}\mathpunct{,} +p_{1}\}$$ on the lower strike and a reversal on the higher strike $$\{-u\mathpunct{,} -c_{2}\mathpunct{,} +p_{2}\}$$. This is basically a combination of a bear call spread and a bull put spread.

Long SPY Sep 250/260 Box:

| <i>Strike</i> | <i>Strategy</i> | <i>Bull Call/Bear Put</i> |
|---------------|-----------------|---------------------------|
|           250 | Reversal        | $$+c\mathpunct{,}-p$$     |
|           260 | Conversion      | $$-c\mathpunct{,}+p$$     |

Short SPY Sep 250/260 Box:

| <i>Strike</i> | <i>Strategy</i> | <i>Bear Call/Bull Put</i> |
|---------------|-----------------|---------------------------|
|           250 | Conversion      | $$-c\mathpunct{,}+p$$     |
|           260 | Reversal        | $$+c\mathpunct{,}-p$$     |

Similar to C/Rs, boxes are flat and can be used to transform verticals, butterfiles and condors (different strikes but same expiration).

## <a name="jelly"></a>Jelly Roll

Jelly Rolls are similar to C/R except it spans across two expiration dates.

Long jelly roll is where you long in time and short jelly roll is where you short in time.

Long SPY Sep/Nov 250 Jelly Roll:

| <i>Maturity</i> | <i>Strategy</i> | <i>Long Call/Short Put Calendar</i> |
|-----------------|-----------------|-------------------------------------|
| Sep             | Conversion      | $$-c\mathpunct{,}+p$$               |
| Nov             | Reversal        | $$+c\mathpunct{,}-p$$               |

Short SPY Sep 250 Box:

| <i>Maturity</i> | <i>Strategy</i> | <i>Short Call/Long Put Calendar</i> |
|-----------------|-----------------|-------------------------------------|
| Sep             | Reversal        | $$+c\mathpunct{,}-p$$               |
| Nov             | Conversion      | $$-c\mathpunct{,}+p$$               |

Similar to C/Rs and boxes, jelly rolls are flat and can be used to transform calendar, diagonal spreads (same/different strikes and different expirations).
