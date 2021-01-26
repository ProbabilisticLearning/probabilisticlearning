
# Table of Contents

1.  [Readings](#org57343d8)
2.  [Agenda](#orgb301387)
3.  [Where we left off](#orgd9ba023)
4.  [Joint Distribution](#org6ed41b9)
5.  [Chain Rule](#orgedafd60)
    1.  [Efficient Representation of Conditional Distributions](#org5f9dc39)
6.  [Conditional Independence](#orgec996c8)
7.  [Probabilistic Graphical Models](#org90e66b4)
8.  [Directed Graphical Models](#org04b61d8)
    1.  [CI in DGMs](#org808a2bc)
        1.  [Chain](#orgfef3a8c)
        2.  [Fork](#org8a79ff2)
        3.  [Collider](#orgdffa17b)
    2.  [Bayes Ball](#org9417b25)
        1.  [Rules](#org1449abd)
        2.  [Example](#orga64f2e9)
    3.  [Example DAGs](#org52c1ed2)
        1.  [Markov Chain](#org415b1ec)
        2.  [Plates](#org3c9d20b)
9.  [Undirected Graphical Models (UGM)](#org2658d84)
    1.  [Conditional Indpenence](#orgfb8548a)
    2.  [When is DAG Assumption Bad?](#org8806116)
    3.  [Not all UGMs can be DGMs](#orgadc3eee)
    4.  [Not all DGMs can be UGMs](#orgbd6e3a8)
    5.  [Representation of a UGM](#orgda087d8)
        1.  [Connection to Physics: Energy](#org1ccf4f1)

> I basically know of two principles for treating complicated systems in simple ways: the
> first is the principle of modularity and the second is the principle of abstraction.
> I am an apologist for computational probability in machine learning because I believe that
> probability theory implements these two principles in deep and intriguing ways — namely
> through factorization and through averaging. Exploiting these two mechanisms as fully
> as possible seems to me to be the way forward in machine learning.
> -— Michael Jordan, 1997


<a id="org57343d8"></a>

# Readings

-   Murphy 10
-   Murphy 19
-   McElreath Statistical Rethinking


<a id="orgb301387"></a>

# Agenda

-   Joint Distributions
-   Chain Rule
-   Conditional Independence Assumptions
-   Directed Graphical Models
-   Conditional Independence in DGMs
-   Bayes Ball Algorithm
-   Undirected Graphical Models
-   Conditional Independence in UGMs


<a id="orgd9ba023"></a>

# Where we left off

Machine learning tasks re-expressed as manipulations of joint probability distribution.

If we model a joint distribution over these variables \(p_\theta(X,C,Y)\)
we can use this model for familiar ML tasks by performing inference

-   **Regression:** \(p(Y \vert X) = \frac{p(X,Y)}{p(X)} = \frac{p(X,Y)}{\int p(X,Y) dY}\)
-   **Classification:** \(p(C \vert X) = \frac{p(X,C)}{p(X)} = \frac{p(X,C)}{\sum_C p(X,C)}\)


<a id="org6ed41b9"></a>

# Joint Distribution

The central object of our interest is the joint distribution
\[ p_\theta(X)= p(X_1, X_2, X_3, \dots \vert \theta) \]
over multiple possibly correlated variables \(X = X_1, X_2, \dots\).

Some of the variables may be observed, such as words in a document, or unobserved, such as missing characters in a damaged document fragment.
Some variables, we will call latent, represent unobserved abstractions, such as the topic of the document.

-   **Probabilistic:** How do we compactly represent the joint distribution?
-   **Reasoning:** How do we efficiently infer one set of variables given information about another set?
-   **Learning:** How can we learn the parameters of the joint representation from data?


<a id="orgedafd60"></a>

# Chain Rule

The Chain Rule of Probability:
We can always represent a joint distribution, given any ordering of the variables, by
\[p(X_{1:N}) = p(X_1)p(X_2 \vert X_1)p(X_3 \vert X_2 X_1)\cdots p(X_N \vert X_{1:{N-1}})\]


<a id="org5f9dc39"></a>

## Efficient Representation of Conditional Distributions

New problem, representing the conditional distribution compactly: \(p(X_N \vert X_{1:{N-1}})\)

Suppose all variables are discrete with \(K\) states.
We can write \(p(X_1)\) as a array with \(O(K)\) values.
(actually K-1 since the array must sum to 1)

We can represent \(p(X_2 \vert X_1)\) by an array of \(O(K^2)\) values, \(T_{ij} = p(X_2=j \vert X_1=i)\)
with constraints to satisfy the sum-to-one requirement of a probability distribution \(\sum_j T_{ij} = 1\).

Similarly, \(p(X_3 \vert X_2 X_1)\) is given by an array with \(O(K^3)\) terms. These are called Conditional Probability Tables

The problem with appealing only to chain rule is that the final conditional distribution \(p(X_N \vert X_{1:{N-1}})\) requires \(O(K^N)\) values to represent.

The values in these tables are the parameters \(\theta\) that represent the distribution.
Non-compact representations are problematic because they are costly to store in memory, manipulate for inference.
Also, learning many parameters will require more data.


<a id="orgec996c8"></a>

# Conditional Independence

Our primary tool is introduce conditional independence assumptions into the model.

The definition of CI is that the joint distribution can be factorized as
\[ X \perp Y \vert Z \iff p(X,Y \vert Z) = p(X \vert Z)p(Y \vert Z)\]


<a id="org90e66b4"></a>

# Probabilistic Graphical Models

PGMs are tools to represent joint distributions by introducing CI assumptions.
Nodes in the graph represent the variables.
(Lack of) edges in the graph represent CI assumptions.

So important this was the name of CSC412 back in my day.


<a id="org04b61d8"></a>

# Directed Graphical Models

DGMs are PGMs whose graph is a Directed Acylcic Graph (DAG)

AKA

-   Belief Networks.
-   Bayesian Networks, Bayes Nets, but this is confusing with Bayesian Neural Networks)
-   Causal Networks, because the directed edges are sometimes (mis?)interpreted as causal relations. As discussed previously, DGMs are not inherently causal.

Given a DGM whose directed pointing into a node \(X_i\) from the parent nodes \(\text{parents}{X_i}\) gives a representation of \[p(X_i \vert \text{parents}(X_i))\].

This allows us to represent the joint distribution, with those CI assumptions, as
\[
p(X_1, X_2, \dots, X_N) = \prod_{i=1}^{N}p(X_i \vert \text{parents}(X_i))
\]

E.g. DAG

No assumptions DAG from Chain Rule
\[p(X_{1:6})\]

\[
p(x_{1, ..., 6}) = p(x_1)p(x_2 \vert x_1)p(x_3 \vert x_1)p(x_4 \vert x_2)p(x_5 \vert x_3)p(x_6 \vert x_2, x_5)
\]


<a id="org808a2bc"></a>

## CI in DGMs

DGMs are powerful tool to represent CI assumptions between sets of variables.

In graph \(G\) we say that set of variables \(A\) is conditionally independent from \(B\) given \(C\) as \[X_A \perp_G X_B \vert X_C\]

The CI assumptions encoded into the DAG have some unintuitive consequences.
To see we can consider all possible relationships between 3 variables in a DAG.
Why is this sufficient to describe the entire DAG?


<a id="orgfef3a8c"></a>

### Chain

X -> Z -> Y

Z mediates the information dependence between X and Y.

Conditioning on Z removes dependence between X and Y.

Gender -> Field -> Funding

p(Funding | Gender), massive imbalance.
p(Funding | Gender, Field), no imbalance.

Gender influences field, field influences funding.

If we want to do something about this, intervene to make funding gender fair, it is important to understand the dependence in our model to make effective changes.
E.g. fixing this issue should happen upstream of grant review, intervening at the decision of funding already conditioned on field.


<a id="org8a79ff2"></a>

### Fork

X <- Z -> Y

Z is the &ldquo;common cause&rdquo; of X and Y.

Conditioning on Z removes the dependence between X and Y.

Data do not distinguish Forks from Chains!


<a id="orgdffa17b"></a>

### Collider

X -> Z <- Y

Z depends on X and Y.
X and Y are independent.

Conditioning on Z introduces a dependency

Switch -> Light <- Electricity

Hype -> Published <- Trustworthy

Height -> BasketballRank <- Skill

Taller players aren&rsquo;t better according to NBA stats?


<a id="org9417b25"></a>

## Bayes Ball

D-separation definition gives a way of determining conditional independence properties of a DGM from the graphical representation,

Unfortunately the definition itself is not a practical algorithm.

Bayes ball is an efficient algorithm for computing d-separation by passing simple messages between nodes of the graph.

&ldquo;Bayes Ball&rdquo;

-   sounds like &ldquo;baseball&rdquo;
-   balls bouncing around a directed graph with specific rules
-   if a ball cannot bounce between two nodes then they are [conditionally] independent.


<a id="org1449abd"></a>

### Rules

why boundary conditions? 10.10


<a id="orga64f2e9"></a>

### Example


<a id="org52c1ed2"></a>

## Example DAGs


<a id="org415b1ec"></a>

### Markov Chain


<a id="org3c9d20b"></a>

### Plates


<a id="org2658d84"></a>

# Undirected Graphical Models (UGM)

UGMS are PGMS whose graph has undirected edges.

Historically very important to physics and computer vision, less so on ML.

They are symmetric which is more natural for certain domains.

However, the parameters are less interpretable and less modular.
Parameter estimation is considerably more expensive.

Recent advances in &ldquo;energy based models&rdquo; addressing these.


<a id="orgfb8548a"></a>

## Conditional Indpenence

UGMs represent CI assumpotions much more simply than DAGs.

\(X_A \perp_G X_B \vert X_C\) iff C separates A from B in the graph G.

Instead of D-separation, we remove the conditioned nodes from G and assess path contectedness.


<a id="org8806116"></a>

## When is DAG Assumption Bad?

E.g. vision model


<a id="orgadc3eee"></a>

## Not all UGMs can be DGMs


<a id="orgbd6e3a8"></a>

## Not all DGMs can be UGMs


<a id="orgda087d8"></a>

## Representation of a UGM

To parameterize a UGM we cannot associate conditional probabilites to each node.

Instead we associate &ldquo;potential functions&rdquo; or &ldquo;factors&rdquo; to the cliques, ideally maximal cliques, of the graph.

E.g. UGM ABCD with discrete categories as arrays

Potentials are **not** probabilities.
Instead they are relative affinities for the states.


<a id="org1ccf4f1"></a>

### Connection to Physics: Energy

We will see this connection later.

Related to energy in physical models, e.g. of chemical structures.
High energy configurations are unlikely, nature seeks low energy states.
Inversely proportional to the probability given by the UGM.

