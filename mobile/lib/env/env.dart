const String stage = String.fromEnvironment('APP_ENV', defaultValue: 'dev');

const dev = {
  'api_authority': 'http',
  'api_endpoint': '10.0.2.2',
  'api_port': 3000,
  'api_path': '',
};

const prod = {
  'api_authority': 'http',
  'api_endpoint': '127.0.0.1',
  'api_port': 3000,
  'api_path': '',
};

const env = (stage == 'prod' ? prod : dev);
