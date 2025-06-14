        ��  ��                  �  <   T X T F I L E   H E L P T E X T         0 	        <General>
This program represents a testbench for neuro-evolution algorithms and reinforcement learning.
It implements both classic methods and operators as well as introducing new and unique operators. One example of a new and unique genetic operator is "Alpha-selection".
***
Elite
This parameter controls the amount of most top-performing actors to be copied verbatim to the next generation.
***
Alpha
This parameter controls the amount of unique top-performing actors (Elite actors included in this pool) to be mated with a unique corresponding group of Beta actors.
***
Beta
This parameter defines the size of a group to be mated per each Alpha actor. Beta actors are selected after all Alpha actors have been identified and represent second-best actors after all Alpha actors.
***
Omega
This value represents the remaining of the population to be considered (via tournament operator) for crossovers after all Alpha and Beta actors were selected. Passive parameter.
***
Random fill
This value represents the remaining of the next generation population which can't be formed by crossovers, and have to be filled with random genes. This usually is either 1 or 0 (depending on the even/odd size of the population and even/odd amount of Elite actors).
***
Mutate
Probability of mutation of each gene of each actor (except elite population). Mutated gene is purely random and can have any valid float32 value.
***
Invert
Probability of genetic inversion of each gene of each actor (except elite population). Inversion is a process of swapping locations of two random genes within a single actor.
***
Splits
This value controls the most important parameter in genetic crossover - amount of genetic split points. All points are guaranteed to be unique (i.e., non-duplicating), but not guaranteed to be evenly distributed across the whole genome.
Reaching each split point will force crossover operator to swap sources of genes for each child:
Parent 1: 1 2 3 4 5 6
Parent 2: a b c d e f
Points: 2,4
Child 1:  1 b c 4 5 6
Child 2:  a 2 3 d e f
***
Winner
This value control the score threshold after which pure genetic algorithm will stop and reinforcement learning would commence.
***
Cumul. fitness
Cumulative fitness is a way to avoid resetting the whole progress by a sudden "global extinction" event.
If cumulative fitness is activated, each actor's score would not be fully reset upon starting the next iteration. Instead, half of its previous score would be saved and then the new score will be added on top of it.
This method allows for keeping elite actors from being accidentally mixed up into the common crowd in case of a "global extinction" event.
***
Global extinction
The "global extinction" refers to an event in which the whole population is wiped off almost simultaneously. For example, if the very first wall has a narrow and hard-to-reach openinig, it's likely that none of the actors will be able to react in time, and the whole population will be immediately destroyed.
The bad side-effect of such events is that it errorneously mixes up the scoring of all actors, making them appear to be identically bad.
***
Elite clones
This option enables copying of the best performing actor to form the whole pool of elite actors. In other words, all elite actors selected for the next iteration would be identical to the best-performing actor of the last iteration.
***
NSize
This parameter controls the size of the neural network used for each actor. The minimum amount of neurons is dictated by the sum of mandatory inputs and outputs, while the maximum amount is hardcoded (as it's used in generating genetic sequences).
***
MinVal
This value represents the minimum value for neural functions to operate on. This by no mean guarantees that all values within the network would never go below "MinVal", but at least the scaling would try to keep activations to be within the limit.
***
MaxVal
This value represents the maximum value for neural functions to operate on. This by no mean guarantees that all values within the network would never go above "MaxVal", but at least the scaling would try to keep activations to be within the limit.
***
MinAct
This value represents the minimum activation coefficient to be considered as valid. An invalid (too small) activation function coefficient would indicate that the corresponding neuron is dead (deactivated).
This mechanism is designed to allow the neural network to have dynamic structure and optimize its own configuration over time.
***
ActMag
This value controls the multiplication factor of the activation function coefficient. Raising the value would mean the activation function would become more and more steep. However, too high value might easily result in floating point operation overflow exception.
***
Scale down
This check box allows to enable scaling the neural inputs to be between "MinVal" and "MaxVal".
Without scaling enabled, the neural network inputs are raw and represent actual pixel distances.
***
Const mag.
This check box allows to enable the constant activation function magnitude as opposed to be defined by activation coefficient stored in the genotype.
Constant value would be taken from "ActMag".
***
Step function
This check box allows to use a true discrete step activation function instead of hyperbolic tangent function.
If step function is activated, "ActMag" and "Const mag." would become unused.
***
LRate
This parameter controls the main learning rate of the reinforcement learning algorithm.
***
LRDev
This parameter controls the maximum allowed deviation of adaptive learning rate.
Setting it to 0 would disable adaptive learning rate, and make "LRUp" value unused.
***
LRUp
This parameter controls the amount by which the learning rate would be affected as a result of adaptive learning rate policy.
The adaptive learning rate is modulated by the following policy:
if previous iteration was successful (i.e., above baseline), then new learning rate = previous learning rate * (1 + LRUp);
otherwise, new learning rate = previous learning rate * (1 - LRUp)
***
Epsilon
This parameter controls the surrogate objective of our PPO-like reinforcement learning algorithm. In other words, it allows us to clamp the absolute weight difference between policy updates (iterations) to avoid sudden jumps in neural network weights.
***
Kappa
This parameter represents the minimum threshold for generating an absolute new random set of deltas to be applied to the neural network weights.
Usually, weights are updated somewhat substantially (wrt "Epsilon" value) between policy updates, but in some cases (e.g., on the very first iteration) the difference in weights between previous and current policies is too small or even equal to 0. Kappa value controls what is considered too small.
***
AxChrg
The axon charge parameter represents the influence of neuron's axon value to the speed of updating that neuron's weights. Usually, hotter neurons represent more desirable points for updates, but depending on the other parameters chosen, it might become less undesirable.
Setting this value too high might quickly destabilize the network.
Setting this value too low might lead to a much longer solution search.
***
   