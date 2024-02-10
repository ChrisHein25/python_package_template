print('Helloworld Unittest')

import unittest
from mypackage.helloworld.helloworld import hello_world


class TestHelloWorld(unittest.TestCase):

    def test_pass(self):
        self.assertTrue(True)

    def test_hello_world(self):
        self.assertEqual(hello_world(), 'Hello World!')
