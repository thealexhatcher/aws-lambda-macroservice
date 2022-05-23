"""
API
"""
import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from . import hello
from . import token
from . import msteams

fast_api = FastAPI()
fast_api.include_router(hello.router)
fast_api.include_router(token.router)
fast_api.include_router(msteams.router)
fast_api.add_middleware(
    CORSMiddleware,
    allow_origins=[*],  # Allows only this origin
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)
api = fast_api
