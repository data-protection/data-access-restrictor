from behave import given, when
import requests


@given(u'/{uri} is set to be just allowed to be called once a {time_unit}')
def rate_limit_by_minutes(context, uri, time_unit):
    requests.post(
        'http://localhost:8082/__admin/mappings/',
        json={
            "request": {"urlPath": f'/{uri}', "method": "GET"},
            "response": {"status": 200},
        },
    )
    DURATIONS = dict(
        day='P1DT0H0M0S', hour='P0DT1H0M0S', minute='P0DT0H1M0S', second='P0DT0H0M1S',
    )
    assert requests.put(
        f'http://localhost:8081/rate_limit/{DURATIONS[time_unit]}/{uri}'
    ).ok


@when(u'I request the list of rate limits')
def step_impl(context):
    context.response = requests.get('http://localhost:8081/rate_limit/')
