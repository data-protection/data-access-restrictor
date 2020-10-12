Feature: Rate Limit

  As a user,
  I want URI's to be rate-limited,
  so that I can be sure data gets not profiled up.

  Scenario Outline: Usage
    Given /foo is set to be just allowed to be called every 24 hours
    And I requested foo
    And I waited <wait> hours
    When I request foo
    Then it <result>
  
  Examples: 
    | wait | result |
    | 23   | fails with 429    |
    | 25   | succeeds with 200 |


  Scenario Outline: Usage Header
    Given /foo is set to be just allowed to be called once per <time unit>
    And I requested foo
    When I request foo
    Then it fails with 429
      | header                | value                  |
      | X-RateLimit           | Limit: 1               |
      | X-RateLimit-Remaining | 0                      |
      | X-RateLimit-Reset     | <reset time>.0 seconds |

    Examples: Supported Time Units
      | time unit | reset time |
      | day       | 216000     |
      | hour      | 3600       |
      | minute    | 60         |
      | second    | 1          |

  Scenario: List
    Given /foo is set to be just allowed to be called once per minute
    When I request the list of rate limits
    Then I get
      | uri | rate limit |
      | foo | 60         |
