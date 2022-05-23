"""
api tests
"""
import os
from unittest import TestCase
from unittest.mock import patch
from fastapi.testclient import TestClient
from api import hello


class TestAPI(TestCase):
    """
    TestAPI
    """

    @patch.dict(os.environ, {"ALLOW_ORIGIN": "https://origin.com"})
    def test_get_hello_world(self):
        """
        UNIT TEST: GET /hello-world
        """
        client = TestClient(hello.router)
        response = client.get("/hello-world")
        assert response.json() == {"message": "Hello World!"}
