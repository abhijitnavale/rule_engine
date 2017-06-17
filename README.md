# rule_engine

## Make it Executable

chmod +x ./rule_engine

## Run It

./rule_engine

## Input Data Json
Input Data json is stored as raw_data.json inside "data" directory

## Rule Configuration
Rules are written in "congig/rules.yml" File using YAML syntax.
General Syntax:
SIGNAL:
  DATA_TYPE:
    rule: <expression>

## Rule Syntax
Use underscore '_' (without quotes) to denote negation for DateTime Type.
use exclamation '!' (without quotes) to denote negation for Integer and String Types.

## Rule Examples
### INTEGER rule for signal ALT1 is written as follows:
Rule Explanation in front of it in round bracket.
Round Bracket is not part of rule.

ATL1:
  Integer:
    rule: value <= 240 (value should be less than 240)
    # rule: value >= 100 (value should be greater than 1000)
    # rule: value = 100 (value should be equal to 100)
    # rule: value > 100 (value shold be greater than 100)
    # rule: value < 100 (value should be less than 100)
    # rule: value != 100 (value should NOT be equal to 100)

### STRING rule for signal ATL2:
Use ALL CAPS for 'LOW' and 'HIGH'.

ATL2:
  String:
    rule: value != LOW (value should NOT equal to 'LOW')
    # rule: value == HIGH (value should be equal to 'HIGH)
    # rule: value != 124 (value should NOT be equal to string '124')

### Multiple DATA TYPE rules for same signal ATL3:

ATL3:
  Datetime:
    # rule: after 2017-08-20 (date should be after 2017-08-20)
    # rule: today (date should be today date)
    # rule: future (date should be in future)
    # rule: _future (date should NOT be in future)
    # rule: past (date should be in past)
    rule: _past (date should NOT be in past)
    # rule: between YYYY-MM-DD YYYY-MM-DD (date should be in given date range)
    # rule: _between YYYY-MM-DD YYYY-MM-DD (date should NOT be in given date range)
    # rule: before YYYY-MM-DD (date should occure before given date)
    # rule: after YYYY-MM-DD (date should occure after given date)
  Integer:
    rule: value > 0 (value should be greater than 0)