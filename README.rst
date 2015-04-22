A4W Style Guide
================================

For a general overview of Unicore's WoW, see our `WoW Documentation <http://ways-of-working.readthedocs.org/en/latest/process.html#our-front-end-development-process>`_. Overall, we use an approach known as Progressive Enhancement. The site in its current form delivers static content. Placeholder images supplied by placekitten.com_. (^._.^)ﾉ

HTML
----

We use Jinja2_ for our templating language. We use an `atomic-design`_-like pattern, so each small section of html code is stored as atoms in ``atoms.html``, larger sections as molecules in ``molecules.html`` and so on, pulling it all together to create each page as a ``.jinja`` file. An example of how this modularised system is implemented can be found in the `template directory`_ of the unicore-cms repository.

CSS
---

We use `Sass`_ to create our CSS files. For now, you need to commit the source ``.scss`` files, and the compiled ``.css`` files. See below on how to install and run sass. We set the `output style`_ to ``:compressed``

The main Sass file is ``/unicorecmsa4w/static/sass/style.scss``. This imports partials from the ``sass`` directory. We use a ``link rel="stylesheet" media="screen and (min-width: 20em)"`` to pull in (the compiled version of) ``/unicorecmsa4w/static/sass/enhanced.scss``, (which pulls in a few additional partials from the ``sass`` directory), and a Google web font.

The sass-generated css files are placed and referenced in ``/unicorecmsa4w/static/css``.

JavaScript
----------

We `cut the mustard`_, checking for support of ``querySelector``,
``localStorage`` and ``addEventListener`` before using `Filament Group’s
loadJS`_ to asynchronously load our minified JavaScript file. This means that lower-end browsers get served a fast, HTML and CSS only, experience, while higher-end browsers get JavaScript enhancements.

More Details
------------
Much of the front-end work is taken from Fufu_ which contains further details on the problems_ and solutions_ faced and implemented here.

Installation of Unicore CMS A4W
================================

.. code-block:: bash

    $ git clone https://github.com/universalcore/unicore-cms-a4w
    $ cd unicore-cms-a4w
    $ virtualenv ve
    $ source ve/bin/activate
    (ve)$ pip install -e .

Running Unicore CMS A4W for local development
-----------------------------------------

This is a Pyramid_ application that uses Elasticsearch.

For OS X we recommend you install Elasticsearch with Brew_:

.. code-block:: bash

    $ brew install elasticsearch

And start Elasticsearch in a separate Terminal tab:

.. code-block:: bash

    $ elasticsearch

For Linux install it with your package manager (apt, rpm, yum etc...)
and make sure it's running as a service.

Then start the server:

.. code-block:: bash

    (ve)$ pserve development.ini --reload

And view it in your web browser on http://localhost:8000/. You'll notice
it is empty. This is because Elasticsearch hasn't been updated yet with
the data from the sample Git repository, this can be done using the
command line ``eg-tools`` utility::

    eg-tools resync -f mappings/category.mapping.json -c development.ini -m unicore.content.models.Category -r True -p repo
    eg-tools resync -f mappings/page.mapping.json -c development.ini -m unicore.content.models.Page -p repo
    eg-tools resync -f mappings/localisation.mapping.json -c development.ini -m unicore.content.models.Localisation -p repo

The output of this should be roughly something like the following::

    (ve)$ eg-tools resync -f mappings/category.mapping.json -c development.ini -m unicore.content.models.Category -r True -p repo
    Destroying index for master.
    Creating index for master.
    unicore.content.models.Category: 9 updated, 0 removed.

    (ve)$ eg-tools resync -f mappings/page.mapping.json -c development.ini -m unicore.content.models.Page -p repo
    unicore.content.models.Page: 6 updated, 0 removed.

    (ve)$ eg-tools resync -f mappings/localisation.mapping.json -c development.ini -m unicore.content.models.Localisation -p repo
    unicore.content.models.Localisation: 3 updated, 0 removed.

Now loading http://localhost:8000/ should show the running site with
the default content.

You'll need to generate the CSS files from the Sass. You'll need to `install sass`_ if you haven't already. Than navigate to the repo root and run:

.. code-block:: bash

    $ sass unicorecmsa4w/static/sass/style.scss:unicorecmsa4w/static/css/style.css --style compressed
    $ sass unicorecmsa4w/static/sass/enhanced.scss:unicorecmsa4w/static/css/enhanced.css --style compressed

To run the pyramid application that will monitor changes in the sass files and recompile, allowing continuous changes, first ensure that you have followed the installation instructions above. start.sh_ will run a local pyramid server and get Sass to monitor the ``.scss`` files, recompiling the ``.css`` each time a change is made. To run ``start.sh``, navigate to the repo root, make sure you have no other processes running in the background and then run:

.. code-block:: bash

    $ sh start.sh

To stop the SASS watch, use ``ctrl + c``, the pyramid application should stop automatically.

Running Unicore CMS tests
-------------------------

.. code-block:: bash

    (ve)$ pip install -r requirements-dev.txt
    (ve)$ py.test cms

.. _atomic-design: http://bradfrost.com/blog/post/atomic-web-design/
.. _template directory: https://github.com/universalcore/unicore-cms/tree/develop/cms/templates
.. _Jinja2: http://jinja.pocoo.org/docs/dev/
.. _start.sh: https://github.com/universalcore/unicore-cms-a4w/blob/develop/start.sh
.. _Sass: http://sass-lang.com/
.. _install sass: http://sass-lang.com/install
.. _output style: http://sass-lang.com/documentation/file.SASS_REFERENCE.html#_16
.. _cut the mustard: http://responsivenews.co.uk/post/18948466399/cutting-the-mustard
.. _Filament Group’s loadJS: https://github.com/filamentgroup/loadJS
.. _placekitten.com: https://placekitten.com
.. _Fufu: https://github.com/SteveBarnett/fufu
.. _problems: https://github.com/SteveBarnett/fufu#some-problems
.. _solutions: https://github.com/SteveBarnett/fufu#some-solutions
.. _Pyramid: http://docs.pylonsproject.org/en/latest/docs/pyramid.html
.. _Brew: http://brew.sh
.. 