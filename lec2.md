
# Table of Contents

1.  [Agenda](#org5d684cb)
2.  [All Cops Are Bad at Logic](#orga2c00fa)
    1.  [Deductive Reasoning](#orgcd34369)
    2.  [The Power of Plausible Reasoning](#org9c94914)
3.  [Thinking Computer](#org7967d7e)
    1.  [Meet Our Robot](#org71b8c05)
        1.  [Desiderata](#org71a4901)
    2.  [Not Deductive Logic](#org642cbfa)
    3.  [Not Causal Reasoning](#orge866575)
    4.  [Not Statistics](#orgb5fa07f)
4.  [Calculus of Probabilities](#orgaafdb60)
    1.  [Product Rule](#orge4c571b)
    2.  [Sum Rule](#org7cecfef)
    3.  [Qualitative Properties](#org43e9262)
    4.  [Prior Information](#orga11ead6)
5.  [Building our Robot](#org04bbca5)
6.  [Probabilistic Machine Learning](#org2c3038d)

> The actual science of logic is conversant at present only with things either
> certain, impossible, or entirely doubtful, none of which (fortunately) we
> have to reason on.
> Therefore the true logic for this world is the calculus
> of Probabilities, which takes account of the magnitude of the probability
> which is, or ought to be, in a reasonable man’s mind.
> 
> &#x2013; James Clerk Maxwell (1850)


<a id="org5d684cb"></a>

# Agenda


<a id="orga2c00fa"></a>

# All Cops Are Bad at Logic

Suppose some dark night a policeman walks down a street, apparently deserted.
Suddenly he hears a burglar alarm, looks across the street, and sees a jewelry store with a broken window.
Then a gentleman wearing a mask comes crawling out through the broken window, carrying fistfulls of expensive jewelry.
The policeman doesn’t hesitate at all in deciding that this gentleman is dishonest.
But by what reasoning process does he arrive at this conclusion?


<a id="orgcd34369"></a>

## Deductive Reasoning

[Organon of  Aristotle](https://en.wikipedia.org/wiki/Organon) gives deductive reasoning (*apodeixis*) as the result of
repeated composition of two strong syllogisms:

1.  `if A is true, then B is true.
        A is true. therefore, B is true.`
2.  `if A is true, then B is true.
        B is false. therefore, A is false.`

Rarely we have adequate information for this kind of reasoning.
Instead we fall back to weaker syllogisms (*epagoge*).
Our evidence is not enough to deduce truthiness with certainty.
However, we eliminate possible explanations of the evidence
and so we feel more confident about consequences.

1.  `if A is true, then B is true.
        B is true. therefore, A is more plausible.`

2.  `if A is true, then B is true.
        A is false. therefore, B is less plausible.`

But our cop did not use even those weak syllogisms, relying on an entirely weaker major premise

1.  `if A is true, then B becomes more plausible.
       B is true. therefore, A is more plausible.`


<a id="org9c94914"></a>

## The Power of Plausible Reasoning

The cop&rsquo;s reasoning suggests a conclusion with strong convincing power,
almost as though it was deductive.

Not only whether something is more or less plausible, but the *degree* of plausibility.

As well, we make use of the context through *prior information* about past experience.

For example, suppose these sorts of things happen several times every night to every cop.
And in every instance the cause was completely innocent.
Very soon, ideally, police would learn to ignore these events.


<a id="org7967d7e"></a>

# Thinking Computer

> You insist that there is something a machine cannot do. If you will tell me precisely what it is that a
> machine cannot do, then I can always make a machine which will do just that!
> 
> &#x2013; John von Neumann (1948)

In this course we will consider mathematical models which reproduce mechanisms of thinking.
We will construct these by prescribing a definite set of operations, algorithmically manipulating information corresponding to quantitative versions of the weak syllogisms.
We are computing, in the presence of incomplete and uncertain information, with a calculus of probabilities.


<a id="org71b8c05"></a>

## Meet Our Robot

It helps to reason about a hypothetical robot, rather than our own thinking.
For one, it is easier to revise and describe clearly.
How should we define our robot&rsquo;s behaviour for representing and reasoning about information?


<a id="org71a4901"></a>

### Desiderata

1.  degrees of plausibility are represented by real numbers.
    Infinitesimally more plausibility coressponds to infinitessimially greater number.

2.  qualitative correspondence with common sense.

3.  consistently.
    If a conclusion can be reasoned out in more than one way, then every possible way must lead to the same result.


<a id="org642cbfa"></a>

## Not Deductive Logic

As we saw, the strong syllogisms are too restrictive to apply to real world reasoning problems.

However, we will recover deductive logic as a special case.


<a id="orge866575"></a>

## Not Causal Reasoning

We are interested in *logical* connections **not** physical causiation.

The major premise `If A is true, then B is true` is not interpreted as `A is the physical cause of B`.
For example what would that say about the second strong syllogism? `not-B is the physical cause of not-A` is non-sense.

There is work in causal reasoning, and it is much more involved due to the consideration of contrapositives, (e.g. `not-A`)


<a id="orgb5fa07f"></a>

## Not Statistics

Statistics

-   Bespoke / theoretically motivated / human interpretable models
-   ad hoc procedures, summarizing methods, and tools
-   Rigorously proven and critically analyzed results (Kolmogorov)


<a id="orgaafdb60"></a>

# Calculus of Probabilities

> Probability theory is nothing but common sense reduced to calculation.
> 
> &#x2013; Laplace, 1819

TL;DR: *probability theory as extended logic*


<a id="orge4c571b"></a>

## Product Rule

-   Relates the logical product `AB` to the plausibility of `A` and `B` separately.
-   Allows us to infer \(AB\vert C\)

Derived by breaking the statement down into elementary sequences

1.  Plausibility of \(B\vert C\)
2.  Given B is true, plausibility of \(A \vert BC\).

If \(A\) and \(B\) are independent then
\[A \perp B \iff P(A B) = P(A) * P(B)\]


<a id="org7cecfef"></a>

## Sum Rule

Captures that the plausibility of either \(A\) or not-\(A\) occurring, represented by \(A + \bar A\), is certain.

\[ P(A) + P(\bar A) = 1\]


<a id="org43e9262"></a>

## Qualitative Properties

Following these simple rules we can derive the strong syllogisms as a limiting case of plausible reasoning as the robot becomes more certain of its conclusions.

We can derive the weak syllogism `if A is true then B is true. B is true. therefore A is more plausible` using the product rule
\[p(A \vert B C) = p(A \vert C) \frac{p(B \vert A C)}{p(B \vert C)}\]
and since \(p(B \vert A C)=1\)  we have the weak syllogism
\[p(A \vert B C) \geq p(A \vert C)\]

We can also express the even weaker, policeman&rsquo;s syllogism:

`if A is true, then B is more plausible` reads \(p(B \vert A C) > p(B \vert C)\)
and by the product rule we can derive the conclusion \(p(A \vert B C) > p(A \vert C)\)


<a id="orga11ead6"></a>

## Prior Information

Why can&rsquo;t we make these statements with just \(A\) and \(B\)?
What is the role of the context, \(C\)?


<a id="org04bbca5"></a>

# Building our Robot

In general, we have variables \(X = (X_1, \dots, X_N)\) that are either *observed* or *unobserved*.
We want a model that captures the relationship between these variables.
The approach of probabilistic [generative models](https://en.wikipedia.org/wiki/Generative_model) is to relate all variables by a learned joint probability distribution
\(p_\theta(X)\).

The assumption here is that the variables, e.g. supervised learning data in the form of (input, label) pairs, were generated by some process that can be represented by some probability distribution \(X \sim p_\text{true}(X)\).

We will try to model this &ldquo;true&rdquo; distribution by introducing a parameterized family of distributions, \(p_\theta\).
&ldquo;Learning&rdquo; our model will be finding the values of the parameters \(\theta\) for this joint probability distribution.
We want the parameters for the specified distribution \(p_\theta(X)\) to &ldquo;best match&rdquo; the underlying data distribution \(p_\text{true}(X)\).

However, we do not have access to \(p_{true}\) except through samples, our data/evidence/observations.

This course will investigate how to build these kinds of thinking machines by discussing

-   How should we specify \(p_\theta\)?
-   What it means for \(p_\theta\) to &ldquo;best match&rdquo; \(p_{true}\)?
-   How can we find the best parameters \(\theta\) from our observations \(x \sim p_{true}\)?


<a id="org2c3038d"></a>

# Probabilistic Machine Learning

With this perspective we can consider common machine learning tasks.
It is helpful to distinguish between the different kinds of variables that are common in our problems:

-   input data, \(X\).
-   discrete outputs, \(C\), e.g. &ldquo;labels&rdquo;
-   continuous outputs, \(Y\)

If we model a joint distribution over these variables \(p_\theta(X,C,Y)\)
we can use this model for familiar ML tasks by performing inference

-   **Regression:** \(p(Y \vert X) = \frac{p(X,Y)}{p(X)} = \frac{p(X,Y)}{\int p(X,Y) dY}\)
-   **Classification:** \(p(C \vert X) = \frac{p(X,C)}{p(X)} = \frac{p(X,C)}{\sum_C p(X,C)}\)

