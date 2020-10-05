Feature: Rate Limit

  As a user,
  I want URI's to be rate-limited,
  so that I can be sure data gets not profiled up.

  Scenario Outline: Usage
    Given /foo is set to be just allowed to be called once <time unit>
    And I requested foo
    When I request foo
    Then it fails with 429
      | header                | value                  |
      | X-RateLimit           | Limit: 1               |
      | X-RateLimit-Remaining | 0                      |
      | X-RateLimit-Reset     | <reset time>.0 seconds |

    Examples: Supported Time Units
      | time unit | reset time |
      | a day     | 216000     |
      | an hour   | 3600       |
      | a minute  | 60         |
      | a second  | 1          |

  Scenario: List
    Given /foo is set to be just allowed to be called once a minute
    When I request the list of rate limits
    Then I get
      | uri | rate limit |
      | foo | 60         |
