# Flappy_Bird_Neural_Network


This program learns how to play Flappy Bird using two different machine learning methods, Neural Networks and Genetic Algorithms. Each bird has five sensors that senses the limited enviroment around each bird and a vertical velocity. These are the inputs to the neural network.

The algorithm is based on three parts. The first part is flappy_get_Data which lets me play the game and captures the values of the sensors, the velocity of the bird, and if the user decided to jump or not. This is used as the sample data. The second part is flappy_train_NN which uses this data to train the neural network using backprobagation and adjusts the weights. The last part is the genetic algorithm, which creates the DNA based on the weights determined in the second part, and keeps evolving over time.
