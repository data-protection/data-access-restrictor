from behave import given, when
import requests
from util.test.faketime import Faketime


@given(u'/{uri} is set to be just allowed to be called every {hours:d} hours')
def rate_limit_by_hours(context, uri, hours):
    set_rate_limit(context, uri, f'P0DT{hours}H0M0S')


@given(u'/{uri} is set to be just allowed to be called once per {time_unit}')
def rate_limit_by_minutes(context, uri, time_unit):
    DURATIONS = dict(
        day='P1DT0H0M0S',
        hour='P0DT1H0M0S',
        minute='P0DT0H1M0S',
        second='P0DT0H0M1S',
    )
    set_rate_limit(context, uri, DURATIONS[time_unit])


def set_rate_limit(context, uri, duration):
    requests.post(
        'http://localhost:8082/__admin/mappings/',
        json={
            "request": {"urlPath": f'/{uri}', "method": "GET"},
            "response": {"status": 200},
        },
    )
    assert requests.put(
        f'http://localhost:8081/rate_limit/{duration}/{uri}'
    ).ok


@when(u'I request the list of rate limits')
def step_impl(context):
    context.response = requests.get('http://localhost:8081/rate_limit/')
