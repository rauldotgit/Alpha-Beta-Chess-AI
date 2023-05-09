from setuptools import setup, Extension
from Cython.Build import cythonize

setup (
    ext_modules= cythonize('src/chess/*.pyx')
)

## compile: python setup.py build_ext --inplace