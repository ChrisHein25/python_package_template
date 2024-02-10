print('Example Unittest')

import unittest
from mypackage import Dog

class TestExample(unittest.TestCase):

    def test_pass(self):
        self.assertTrue(True)

    def test_dog(self):
        dog = Dog(name='Rocky', age=2, breed="German Shepherd")
        intro = dog.introduce()
        with self.subTest("Check name"):
            self.assertTrue('Rocky' in intro)
        with self.subTest("Check age"):
            self.assertTrue('2' in intro)
        with self.subTest("Check breed"):
            self.assertTrue('German' in intro)
