# 🐤 Flappy NEAT

**Flappy NEAT** is a chaotic little testbench where neural networks learn to play a Flappy Bird–style game using a mix of **genetic neuro-evolution** and **reinforcement learning**. It’s designed to let you:

- Compare **human**, **algorithmic**, **neuro-evolved**, and **RL-trained** performance
- Seamlessly switch from **evolution** to **RL fine-tuning** once a score threshold is hit
- Experiment with unique genetic operators and learning tricks you've probably never seen before

It’s a research toy, a performance benchmark, and a testbed for weird ideas—all in one.

---

## 🧠 Highlights

- 🚀 **Alpha-selection**: A novel genetic operator to drive better diversity
- 🔥 **Neuron heat dynamics**: RL weight updates are modulated by how “hot” neurons are
- 🧬 **Custom crossover/inversion/mutation logic**
- 🎩 **Interactive human mode** for score comparison
- 🤖 **Algorithmic solver mode** (perfect agent)
- 🧪 **Experimental PPO-inspired RL strategy**
- ↻ **Hybrid GA → RL transition** based on fitness threshold
- 🛠️ **Live UI with parameter tweaking** and yes, even a help screen 😎
- 🔄 **Save/load for agents and populations**
- 🌍 **Neural network visualization and weight matrix viewer**
- 🕛 **Scenario replay support for post-mortem analysis**

---

## 🛠️ Running the Project

This program was lovingly built using **Delphi 7**, which means:

> ⚠️ You will need a **Windows XP environment** with **Delphi 7** installed to compile and run this project.

We recommend spinning up a virtual machine for this purpose. Nostalgia points are included for free.

**Alternatively**, a precompiled `.exe` is provided with each release—you can run it directly in a compatible environment.

---

## 🎛️ Parameter Glossary

### 🌱 Genetic Parameters

- **Elite**: Top performers copied unchanged into next gen
- **Alpha**: Top unique actors selected for special mating
- **Beta**: Second-tier actors mated with Alphas
- **Omega**: Remaining population selected via tournament
- **Random fill**: Fills leftover population gaps with random genes
- **Mutate**: Chance for each gene to mutate (random float)
- **Invert**: Probability of swapping two genes in one genome
- **Splits**: Crossover points for child genomes
- **Elite clones**: Copies top actor into all Elite slots

### 🧠 Neural Network Settings

- **NSize**: Number of neurons in each network
- **MinVal / MaxVal**: Expected operating range for activations
- **MinAct**: Threshold for neuron considered alive/active
- **ActMag**: Slope multiplier for activation function
- **Scale down**: Normalize inputs to MinVal–MaxVal
- **Const mag.**: Use constant ActMag instead of per-gene coeff
- **Step function**: Use hard step instead of tanh

### 🤖 Reinforcement Learning

- **Winner**: Score after which RL takes over from GA
- **Cumul. fitness**: Preserves part of score between gens
- **Global extinction**: Describes scenario when all agents fail early
- **LRate**: Base RL learning rate
- **LRDev / LRUp**: Controls adaptive learning rate changes
- **Epsilon**: PPO-style clamp on weight updates
- **Kappa**: Min weight delta to trigger full exploration
- **AxChrg**: Neuron “hotness” multiplier for RL updates

---

## 👾 Modes of Play

- **Human mode**: Try to flap your way to glory yourself
- **Algorithmic mode**: Watch a perfect agent clear the level with ease
- **Neuro-evolution**: Evolve your own flappy brain from scratch
- **RL hybrid**: Let GA get you close, and RL finish the job

---

## 🧪 Sample Use Case

Train a population to solve the level using evolution, then transition into RL for fine-tuning behavior. Compare its score to your own flapping skills, or the perfect algorithmic solver. Discover if your `AlphaSort` operator beats standard crossover methods. Watch neuron "heat maps" influence updates. Or just... create a mutant bird that flaps with pure chaos.

Hint: Try to use test INI files provided in the repo.

### (C) Dmitry 'MatrixS_Master' Solovyev, 2025

### License: GPL v3
