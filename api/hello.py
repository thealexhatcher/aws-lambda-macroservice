"""
hello.py
"""
from fastapi import APIRouter

router = APIRouter()


@router.get("/hello-world")
def hello_world_get():
    """
    Hello World
    """
    print("Hello World!")
    return {"message": "Hello World!"}
