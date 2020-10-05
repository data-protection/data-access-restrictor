Feature: Proxy

  As a user,
  I want to use this service as proxy,
  so that every non-rate-limited URI just get proxied through

  Scenario Outline: Proxy to non-existing target
    When I request <uri>
    Then it fails with <response code>

    Examples: Types
      | uri              | response code |
      | non_existing_uri | 404           |
      | existing_uri     | 200           |
