import scipy.io as spio
import numpy as np
from enum import Enum


class decision_tree:
    def __init__(self):
        self.op = None
        self.kids = None
        self.classify = None


def decision_tree_learning(examples, attributes, binary_targets):
    tree = decision_tree()
    return tree


cleandata = spio.loadmat('Data/cleandata_students.mat')
examples = cleandata['x']  # 1004-by-45 numpy.ndarray
labels = cleandata['y']  # 1004-by-1 numpy.ndarray
N = labels.size  # number of examples: 1004
emotions = Enum('emotions', 'anger disgust fear happiness sadness surprise')  # emotion labels, from 1 to 6
binary_targets = np.zeros(N, int)
for i in range(N):
    binary_targets[i] = int(labels[i][0] == emotions.happiness.value)
tree = decision_tree_learning(0, 0, 0)
