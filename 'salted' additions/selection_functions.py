import numpy as np
import sys
import h5py
import os
import os.path as osp
import scipy.linalg
import os 

from scipy.linalg import svd
from salted.sys_utils import ParseConfig, read_system, get_atom_idx

# For iteration
SEED = os.environ['SEED']
seeded = int(SEED)

#if none is required please select a suitable interger in seeded 


def do_fps (x ,d=0):

    # FPS code from Giulio Imbalzano
    if d == 0 : d = len(x)
    n = len(x)
    iy = np.zeros(d,int)
    iy[0] = seeded

    # Faster evaluation of Euclidean distance
    n2 = np.sum((x*np.conj(x)),axis=1)
    dl = n2 + n2[iy[0]] - 2*np.real(np.dot(x,np.conj(x[iy[0]])))
    for i in range(1,d):
        iy[i] = np.argmax(dl)
        nd = n2 + n2[iy[i]] - 2*np.real(np.dot(x,np.conj(x[iy[i]])))
        dl = np.minimum(dl,nd)
    return iy

def do_rand (x, d=0):

    if d == 0:
        d=len(x)
    n=len(x)
    np.random.seed(seeded)
    iy=np.random.choice(n,d,replace=False)
    print ('seed=',SEED,'n=',n,'d=',d)
    return iy

def do_CUR(x, d=0, k=1):
    if d == 0:
        d = x.shape[0]  

    def compute_importance_scores(U, k=1):
        importance_scores = np.sum(U[:, :k] ** 2, axis=1)
        return importance_scores

    def orthogonalize_rows(X, row):
        proj = X @ row.T / (row @ row.T)
        X = X - proj @ row
        return X

    # Perform initial SVD
    U, S, Vt = scipy.linalg.svd(x, full_matrices=False)

    # Initialize array to hold indices of selected rows
    iy = np.zeros(d, int)

    # Iteratively select rows based on importance scores
    for i in range(d):
        importance_scores = compute_importance_scores(U, k)
        max_idx = np.argmax(importance_scores)  
        iy[i] = max_idx 
        row = x[max_idx, :].reshape(1, -1)
        x = orthogonalize_rows(x, row)  
        U, S, Vt = scipy.linalg.svd(x, full_matrices=False) 

    return iy
