# Alpha-Beta Search Chess AI

Github repo for the TU-Berlin "Project AI - Symbolic Artificial Intelligence" course. 

Implementation of a Alpha-Beta Search Chess AI using the bitboard representation, built with Python/ Cython. 

## Table of contents

- [Alpha-Beta Search Chess AI](#alpha-beta-search-chess-ai)
  - [Table of contents](#table-of-contents)
  - [Overview](#overview)
    - [The challenge](#the-challenge)
    - [Screenshots](#screenshots)
    - [Links](#links)
  - [Our process](#our-process)
    - [Built with](#built-with)
    - [What we learned](#what-we-learned)
    - [Continued development](#continued-development)
    - [Useful resources](#useful-resources)
  - [Authors](#authors)
  - [Acknowledgments](#acknowledgments)


## Overview

### The challenge

The final goal of this project is to implement a Chess Engine using Alpha-Beta Search and further improve on its strength and efficiency. In this case, a chess variation called "King Of The Hill" has been chosen, wherein players win based on classic chess conditions, or by reaching the center of the chess board with their king.

Milestone I - Basic Chess Engine: (current)

- Board representation and chess logic
- Dummy AI, able to play games using random moves
- Benchmarking
- Simple evaluation function
- Time management

### Screenshots

### Links

## Our process

Ahead of the project, our team discussed tools to use for our implementation, factoring in our experiences and programming backgrounds. Based on the consensus that most of us had used python in the past, and its ease of legibility and flexibility in terms of computing and web packages, we decided to base our implementation on it.

Although its benefits mentioned before, some drawbacks, such as computational speed and restricted use of unsigned data types, were obvious. As such, part of our code relies on Cython, which is capable of compiling Python into C/C++ modules.

Using Python also opens up possibilites for further milestones, where the chess engine will have to communicate with a web server for matches and have a graphical user interface, both of which can be done with a rudimentary Django/React/HTML/CSS server implementation or as a client with a PyQt front-end.

After several research and team discussions, we came to the conclusion, to implement Bitboards in our Chess AI, instead of Mailbox (Arrays).
We found out, that investigating, if the King is exposed into a check, after a move has been made, is a very time consuming task. 

Mailbox uses a so called "if square attacked" function, to calculate the attacked squares of the chessboard. This process causes a significant loss in performance, since it is very time consuming.

Bitboards on the other hand, operate with "pre calculated attack tables". The "magic Index" is implemented to reference these pre calculated attack tables, in order to obtain the data, of the attacked sqaures on the chessboard. This leads to a significant increase in performance, as a simple lookup is used, instead of real time calculations. 

### Built with

- [Python](https://www.python.org/)
- [Cython](https://cython.org/)
- [Pytest](https://docs.pytest.org/en/7.3.x/)

### What we learned


### Continued development

So far our implementation computes attack maps for sliding pieces on the fly, instead of using magic bitboards. This is due to ease of implementation and testing, but will be changed in future updates.

### Useful resources

- [Chess Programming Wiki](https://www.chessprogramming.org/Main_Page) - The "beacon of light" in chess programming and our implementation so far.
- [Fast Chess Move Generation With Magic Birboards](https://rhysre.net/fast-chess-move-generation-with-magic-bitboards.html) - Great article which helps so understand how magic bitboards function.
- [Chess Engine Playlist - Wes Doyle](https://www.youtube.com/watch?v=1QotIA4_jb4&list=PLVDSx0U1dPnSSiA8APdxe-D6sinZzTaE1&index=1) - Playlist of livestreams where Wes Doyle implements a chess engine using arrays. Interesting for Python specific ways of solving chess problems and entertaiment purposes.

## Authors

- Konstantin Hasler
- Cedric Braun
- Raul Nikolaus

## Acknowledgments


