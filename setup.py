from distutils.core import setup

setup(
    name='BitWeight',
    version='1.0',
    author='Kyle Gorman',
    author_email='gormanky@ohsu.edu',
    packages=['bitweight'],
    description='Useful class for working with log-probabilities.',
    install_requires=['numpy']
)