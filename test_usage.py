# python integration tests

import unittest
import mypackage as p  # import the package as a user who has just pip installed it


class TestImporting(unittest.TestCase):

    def test_import_dog(self):
        dog = p.Dog(name="Fido", age=2, breed="German Shepherd")
        intro = dog.introduce()
        self.assertEqual(intro, "My name is Fido, I'm 2 years old, and I'm a German Shepherd.")

    def test_import_helloworld_submodule(self):
        person = p.helloworld.Person(name='Guy')
        said = person.say_hello_world()
        self.assertEqual(said, "Guy says Hello World!")


if __name__ == "__main__":
    unittest.main()

