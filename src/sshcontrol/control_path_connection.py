import asyncio
from os import PathLike


class ControlPathConnection:
    """
    TODO...
    """

    master_socket: PathLike

    def __init__(self, master_socket: PathLike):
        self.master_socket = master_socket
