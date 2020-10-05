from behave import given, then, when
import requests
from util.test.tools import eq_


@given('I requested {uri}')
@when('I request {uri}')
def request(context, uri):
    if uri == 'existing_uri':
        requests.post(
            'http://localhost:8082/__admin/mappings/',
            json={
                "request": {"urlPath": "/existing", "method": "GET"},
                "response": {"status": 200},
            },
        )
    context.response = requests.get(f'http://localhost:8080/{uri}')


@then('it fails with {response_code:d}')
def verify(context, response_code):
    if not context.table:
        return
    for row in context.table.rows:
        eq_(context.response.headers[row["header"]], row["value"])
    eq_(context.response.status_code, response_code)


@then('I get')
def verify_response(context):
    actual = {row['uri']: int(row['rate limit']) for row in context.table.rows}
    eq_(actual, context.response.json())
