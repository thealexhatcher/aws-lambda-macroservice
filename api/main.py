"""
main.py
"""
from mangum import Mangum
from . import api

handler = Mangum(api.api)
