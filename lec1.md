
# Table of Contents

1.  [Agenda](#orgf931460)
2.  [Accessibility Check](#orga379a33)
3.  [About Instructor](#org1d4a6ca)
4.  [Land Acknowledgement](#org6bf85e7)
5.  [Attention Acknowledgement](#org8479625)
6.  [Fun Acknowledgement](#org40b437f)
7.  [Learning Outcomes](#orgd71c0e2)
8.  [Motivation](#org2ab4743)
9.  [Scope](#org1708d1a)
10. [Out of Scope](#orgb169c1f)
11. [Tools of the trade](#orgb1f4277)
12. [Build with these Tools](#org8ca2ca5)



<a id="orgf931460"></a>

# Agenda

-   Introduction
-   Course Info and overview
-   Questions
-   Hype
-   Chill


<a id="orga379a33"></a>

# Accessibility Check


<a id="org1d4a6ca"></a>

# About Instructor

Jesse Bettencourt

-   PhD Student with David Duvenaud
-   Researching on Neural Ordinary Differential Equations and Automatic Differentiation

-   Fourth time teaching this course. (very qualified)
-   First time giving a zoom lecture! (completely terrified)

-   Pronouns: He/him
-   &ldquo;Jesse&rdquo; is preferred in emails, please I am not a Mr., Dr., or a Prof.


<a id="org6bf85e7"></a>

# Land Acknowledgement

First I want to acknowledge that I am working from in the traditional territory of Tkaranto, a site of activity and meeting since time immemorial, with acknowledgement to the Anishnaabe, the Haudenosaunee, the Huron-Wendat, the Petun, and the Mississaugas of the Credit First Nation, whose presence past, present, and future include being caretakers of the land. I am grateful to have the opportunity to participate in this activity and work on this land.


<a id="org8479625"></a>

# Attention Acknowledgement

I also want to thank you all, in advance, for your attention and participation in this course.
This is a strange and upsetting time to be concentrating on anything except doom scrolling through information feeds.
I understand some of the difficulties you might be facing, especially the challenge of performing academically right now.
Thank you for taking the time and energy to attend to this work as best we can under the circumstances.


<a id="org40b437f"></a>

# Fun Acknowledgement

This course is conceptually, mathematically, and technically challenging.
Unfortunately there&rsquo;s not much we can do about that, math is hard.
What we can do is decide to approach these challenges, together, with some enthusiasm.
Let&rsquo;s have some fun.


<a id="orgd71c0e2"></a>

# Learning Outcomes

-   what topics are in the course
-   some topics are not in the course
-   give a sense of prerequisites and difficulty
-   what we can do with these topics
-   tools and practical skills we will be using


<a id="org2ab4743"></a>

# Motivation

How can we build models from incomplete or uncertain information?

e.g.

-   fill in missing parts of an image
-   increase the resolution of an image or video
-   which tests should I perform to obtain more useful information like on a medical patient

How can we model our uncertainty?

-   does it come from observational noise?
-   is it consistent missing data
-   is it inconsistent missing data
-   is it the result of adversarial misinformation?


<a id="org1708d1a"></a>

# Scope

-   representing models by parameterized probability distributions
    -   graphical models
-   inference with the probabilistic model
    -   Exact: conditioning on data, marginalizing unknown information
    -   Approximate: sampling, variational inference
-   learning the parameters of the probabilistic model
    -   gradient-based optimization and automatic differentiation


<a id="orgb169c1f"></a>

# Out of Scope

-   Statistical Learning Theory. (e.g. Dan Roy or Murat Erdogdu)
-   Fancy neural network architectures (e.g. Roger Grosse)
-   Reinforcement learning (e.g. Jimmy Ba)
-   Logic-based AI such as discrete search (e.g. Sheila McLiraith)
-   Bayesian Non-parametrics (kernel density estimation, Gaussian processes)
-   Decision and control theory

However, all these courses are deeply related and benefit from our topics.


<a id="orgb1f4277"></a>

# Tools of the trade

-   Probability to represent and manipulate uncertainty.
-   Graphical models to express and reason about probabilistic models
-   neural networks to encode large nonlinear parametric function
-   gradient-based optimization to learn the model parameters
-   Automatic Differentiation to compute the gradients
-   Approximate inference to tractably perform modelling tasks (VI and MCMC)


<a id="org8ca2ca5"></a>

# Build with these Tools

-   Naive Bayes
-   Mixture of Gaussians
-   Logistic Regression
-   Bayesian Linear regression
-   Hidden Markov Models
-   Factor analysis
-   Variational Auto-encoders, Generative Adversarial Networks, Normalizing Flows

