# Haikus

List all messages in a GroupMe group that are haikus.

> **Haiku**, unrhymed poetic form consisting of 17 syllables arranged in three lines of 5, 7, and 5 syllables respectively. The haiku first emerged in Japanese literature during the 17th century, as a terse reaction to elaborate poetic traditions, though it did not become known by the name haiku until the 19th century.

From _[Britannica](https://www.britannica.com/art/haiku)_

## Getting Started

You'll need an OCaml installing along with dune. `cohttp-lwt-unix`, `ppx_lwt`, and `dotenv` are all required dependencies.

1. Clone the repo

2. Create a `.env` file with your GroupMe API token. If you don't have an API token, you can obtain one for your GroupMe account [here](https://dev.groupme.com/).

```
GROUPME_API_TOKEN=[your_token_here]
```

3. Build the project

```shell
$ dune build
```

4. Run the `haikus` executable

```shell
$ dune exec haikus
```

Example program output:

```
Competitive Coding and Algorithms: 101649268
Megachat: 102541017
Mortarboard: 99734377
(Quarantined) Megachat: 95387682
Pike Burger Club: 24929854
Public GroupMe API Development Chat: 27317261
Hit the Gym: 44099295

Enter a group id:
44099295

Strings of code align creating a digital world. Infinite pixels.

Bugs in the system; lines of code intertwining. Program comes to life

Elegant code flows, pure functions without side effects, functional bliss reigns.
```

## Syllables Database

The plain text list of syllables was obtained from "Moby Hyphenation List" by Grady Ward on [Project Gutenberg](https://www.gutenberg.org/ebooks/3204). This list was further processed by replacing the original syllable delimiters with spaces.
