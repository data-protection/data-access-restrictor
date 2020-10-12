from datetime import datetime


class Faketime:
    """This class allows to modify time for testing."""

    def __init__(self, time=None):
        self.time = time or datetime(2000, 1, 1, 10, 0, 0)
        self.dump()

    def dump(self):
        with open('build/faketime', 'w') as file:
            file.write(self.time.strftime('%Y-%m-%d %H:%M:%S'))

    def set_time(self, time):
        self.time = time
        self.dump()

    def elapse(self, duration):
        self.time += duration
        self.dump()
