from setuptools import setup, Extension
from Cython.Build import cythonize

setup (
    ext_modules= cythonize('src/chess/*.pyx', language_level = "3")
)

## compile: python setup.py build_ext --inplace