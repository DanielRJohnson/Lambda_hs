# λ Lambda_hs

## 30 second lambda calculus rundown
What if there was a form of math/programming that *ONLY* had one-parameter functions? How could you do math without literal numbers or booleans? It seems impossible. Turns out it does exist, it can get extremely complicated, and it's turing complete.

The most "atomic" <ins>value</ins> is the identity function `λx. x`.

We can emulate multi-parameter functions with [Currying](https://en.wikipedia.org/wiki/Currying) like so: `λx.λy. (use x and y)`.

We can define booleans as curried functions that return the first or the "second" argument, True = `λx.λy.x` False = `λx.λy.y`.

We can define numbers as curried functions enumerated by how many times the first argument gets applied to the "second". 

0 = `λf.λx.x`, 1 = `λf.λx. (f x)`, 2 = `λf.λx. (f (f x))`, etc.

Numbers are defined by repeated induction, iteratively applying the successor function `λx.λy.λz. (y ((x y) z))`. [bars](https://www.tiktok.com/@yamsox/video/7026216483239873798).

You can also form functions to do other basic operations like adding, multipling, boolean and/or, etc. So, It's easy to see how this could be turing complete with enough lambdas and lacking sanity. Learn more [here](http://bach.ai/lambda-calculus-for-absolute-dummies/). Or don't. I'm not your dad.


## The REPL
<img src="https://github.com/DanielRJohnson/Lambda_hs/blob/main/img/examples.png" width="66%" />

To run the REPL:
 * Have a working installation of GHC (Haskell's main compiler)
 * Clone this repo
 * Run `runghc lambda.hs` to run the REPL or `ghc lambda.hs` to build an executable
 * Note: Applications must be fully parenthesized like `((x y) z)` and `(\x. (x x) \x. (x x))`
 
 ## The Packages
 This repo provides well-defined functionality in Haskell for lexing, parsing, and evaluation of lambda calculus elements represented in data structures. Use as you wish. Clone and go wild if you want. I am also open to contributions.
