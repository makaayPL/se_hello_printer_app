import unittest
from hello_world import app
from hello_world.formater import SUPPORTED


class FlaskrTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_outputs(self):
        rv = self.app.get('/outputs')
        ','.join(SUPPORTED) in rv.data

    def test_msg_with_output(self):
        name = 'sandra'
        rv = self.app.get('/?output=json&name='+ name)
        self.assertEquals('{ "imie":"'+name+'", "mgs":"Hello World!"}', rv.data)

    def test_message_with_xml(self):
        name = 'sandra'
        xml = self.app.get('/?output=xml&name='+ name)
        self.assertEquals('<greetings><name>'+name+'</name><msg>Hello World!</msg></greetings>', xml.data)
