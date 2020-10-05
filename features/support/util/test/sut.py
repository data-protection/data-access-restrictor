import os
import subprocess
from datetime import timedelta

from util.test.assertion import assert_eventually


class SUT:
    """This class allows to start and stop the specified System Under Test."""

    def __init__(self, args):
        self.args = args
        self.p = None

    def start(
        self, shell=False, timeout=timedelta(seconds=10), quiet='verbose' not in os.environ, environment=None
    ):
        if self.running():
            return
        env = dict(os.environ)
        if environment is not None:
            env.update(environment)
        if quiet:
            null_device = open(os.devnull, 'w')
            self.p = subprocess.Popen(
                self.args, stdout=null_device, stderr=null_device, shell=shell, env=env
            )
        else:
            self.p = subprocess.Popen(self.args, shell=shell, env=env)

        def assert_is_running():
            assert self.running(), 'unable to start SUT'

        assert_eventually(assertion=assert_is_running, timeout=timeout)

    def stop(self, timeout=timedelta(seconds=15)):
        if self.running():
            try:
                self.p.terminate()
                self.p.wait(timeout=timeout.total_seconds())
            except subprocess.TimeoutExpired:
                self.p.kill()
                self.p.wait()
        self.p = None

    def running(self):
        if self.p is None:
            return False
        self.p.poll()
        return self.p.returncode is None
