unicore-cms-a4w
====================

A a4w project to use as the base for creating new apps

To use this repo as a base for your new app, do the following::

  $ git remote add a4w https://github.com/universalcore/unicore-cms-a4w.git
  $ git fetch a4w
  $ git merge a4w/develop

You then need to rename all the instances where ``a4w`` is used.
``git grep a4w`` should help you find all the mentions

To run the tests::

  $ pip install -r requirements-dev.txt
  $ ./run_tests.sh
