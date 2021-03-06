.. ex_write_classify_nn

Write your own Nearest-neighbor classifier
==========================================

We have begun to write a nearest neighbor classifier, but we have left out the
best part. Write the for loop that iterates over every sample in the testing
data and assigns a single label from the training targets to each of the test
samples based on which is nearest (where 'nearest', for now, is defined based on Euclidian distance). Test your classifers on pairwise or multi-class datasets.

Your function should have the following signature:

.. include:: cosmo_classify_nn_hdr.rst

Hint: cosmo_classify_nn_skl_

.. _cosmo_classify_nn_skl: cosmo_classify_nn_skl.html

Full solution: cosmo_classify_nn_

Extra exercise: write a nearest-mean classifier

Extra exercise: Try correlation instead of Euclidian distance. 
Advanced exercise: write a k-nearest neighbor classifier that considers the nearest k neighbors for each test sample. Bonus points if this classifier takes a random class in case of a tie.

.. _cosmo_classify_nn: cosmo_classify_nn.html
