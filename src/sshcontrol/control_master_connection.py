import asyncio
from os import PathLike
from sshcontrol.control_command import ControlCommand

class ControlMasterConnection:
    """
    TODO...
    """

    socket: PathLike

    def __init__(self, socket: PathLike):
        self.socket = socket

    async def ctl_cmd(self, cmd: ControlCommand):

