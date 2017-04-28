from setuptools import setup, Extension
from Cython.Build import cythonize

setup(name="eBitWeight",
      version="0.1",
      description="Underflow-proof floating-poing math for NLP",
      author="Kyle Gorman, Steven Bedrick, and Shiran Dudy",
      author_email="dudy@ohsu.edu",
      install_requires=["Cython >= 0.22"],
      ext_modules=cythonize([Extension("ebitweight", ["ebitweight.pyx"],
                                       language="c++",
                                       extra_compile_args=["-std=c++11"])]),
      test_suite="ebitweight_test",
)
