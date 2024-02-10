"""
Example File with some Example Functions

"""

from pandas import isna


def isna_test(val):
    """ Use pandas as a dependency, for example """
    return isna(val)


class Dog:
    """ example class """

    def __init__(self, name, age, breed):
        self.name = name
        self.age = age
        self.breed = breed

    def bark(self):
        return "Woof!"

    def introduce(self):
        return f"My name is {self.name}, I'm {self.age} years old, and I'm a {self.breed}."

