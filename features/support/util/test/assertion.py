import time
from datetime import datetime, timedelta


def assert_eventually(assertion, timeout=timedelta(seconds=1)):
    """Assert that the given assertion passes eventually before the given timeout."""
    start_time = datetime.now()
    while True:
        try:
            assertion()
            return
        except:  # pylint: disable=bare-except
            if datetime.now() - start_time > timeout:
                raise
            time.sleep(0.1)
