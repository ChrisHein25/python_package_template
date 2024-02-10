"""
Say Hello World
"""


def hello_world():
    return "Hello World!"


class Person:

    def __init__(self, name: str):
        self.name = name

    def say_hello_world(self):
        return f"{self.name} says {hello_world()}"