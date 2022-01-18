# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- doxygen rendering ------------------------------------------------------------

import subprocess
subprocess.call('cd .. ; rm -rf build/docs/doxygen ; mkdir -p build/docs/doxygen ; doxygen doxygen/Doxyfile', shell=True)

# -- alectryon setup --------------------------------------------------------------

import alectryon.docutils
alectryon.docutils.CACHE_DIRECTORY = "./"

# -- Project information -----------------------------------------------------

project = 'int63'
copyright = '2022, applied.fm'
author = 'applied.fm'
html_favicon = 'favicon.ico'

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'alectryon.sphinx',
    'breathe',
]

breathe_projects = {
    'coq-vsu-int63': '../build/docs/doxygen/xml/',
}
breathe_default_project = 'coq-vsu-int63'

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'alabaster'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
# html_static_path = ['_static']

html_extra_path = ['../build/docs']