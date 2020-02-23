import unittest
import json
import xml.etree.cElementTree as ET
from hello_world import app
from hello_world.formater import SUPPORTED

name = 'sandra'
msg = 'Hello World!'


class FlaskrTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_outputs(self):
        rv = self.app.get('/outputs')
        ','.join(SUPPORTED) in rv.data

    def test_msg_with_output(self):
        data = {
          "imie": name,
          "mgs": msg
        }
        rv = self.app.get('/?output=json&name=' + name)
        self.assertEquals(json.dumps(data), rv.data)

    def test_message_with_xml(self):
        # <greetings>
        greetings = ET.Element("greetings")
        # <name>
        ET.SubElement(greetings, "name").text = name
        # <msg>
        ET.SubElement(greetings, "msg").text = msg
        xml = self.app.get('/?output=xml&name=' + name)
        self.assertEquals(ET.tostring(greetings), xml.data)
