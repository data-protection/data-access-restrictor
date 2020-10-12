from behave import given
from datetime import timedelta


@given(u'I waited {hours:d} hours')
def wait_for_hours(context, hours):
    context.time.elapse(timedelta(hours=hours))