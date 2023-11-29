cd /app
NEW_RELIC_APP_NAME=backend NEW_RELIC_LICENSE_KEY={{ lookup('amazon.aws.aws_ssm', 'newrelic.licence_key', region='us-east-1' ) }} node -r newrelic index.js