import scipy.io as spio
import numpy as np
from enum import Enum


class decision_tree:
    def __init__(self):
        self.op = None
        self.kids = None
        self.classify = None


def majority_value(binary_targets):
    return 1 if len(np.where(binary_targets == 1)[0]) >= len(np.where(binary_targets == 0)[0]) else 0


def choose_best_decision_attribute(examples, attributes, binary_targets):
    pass


def decision_tree_learning(examples, attributes, binary_targets):
    tree = decision_tree()
    if np.unique(binary_targets).size == 1:
        tree.classify = binary_targets[0]
    elif attributes.size == 0:
        tree.classify = majority_value(binary_targets)
    else:
        best_attribute = choose_best_decision_attribute(examples, attributes, binary_targets)
        tree.op = best_attribute
        tree.kids = {'l_kid': decision_tree(), 'r_kid': decision_tree()}
        # for i in range(2):

    return tree


cleandata = spio.loadmat('Data/cleandata_students.mat')
examples = cleandata['x']  # 1004-by-45 numpy.ndarray
attributes = cleandata['y']  # 1004-by-1 numpy.ndarray
N = attributes.size  # number of examples: 1004
emotions = Enum('emotions', 'anger disgust fear happiness sadness surprise')  # emotion labels, from 1 to 6
binary_targets = np.zeros(N, int)
for i in range(N):
    binary_targets[i] = int(attributes[i][0] == emotions.happiness.value)
tree = decision_tree_learning(examples, attributes, binary_targets)
