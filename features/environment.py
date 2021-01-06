import os
from util.test.faketime import Faketime
from util.test.sut import SUT


def before_scenario(context, _):
    from datetime import timedelta

    empty_config()
    context.sut.start(timeout=timedelta(minutes=10))
    context.time = Faketime()
    import time

    time.sleep(5)  # TODO: remove


def before_all(context):
    empty_config()
    context.sut = SUT(['./start.sh'])
    import atexit

    def cleanup():
        try:
            context.sut.stop()
        except AttributeError:
            pass

    atexit.register(cleanup)


def empty_config():
    try:
        os.makedirs('build/config')
    except FileExistsError:
        pass
    try:
        os.makedirs('build/state')
    except FileExistsError:
        pass
    with open('build/config/rate_limited_uris.json', 'w') as file:
        file.write('{}')
    with open('build/state/last_access.json', 'w') as file:
        file.write('{}')


def after_step(context, _):
    # pylint: disable=unused-argument
    if 'step_by_step' in os.environ:
        input()


def after_scenario(context, _):
    context.sut.stop()
    empty_config()
