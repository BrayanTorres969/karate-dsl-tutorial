function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'brayan@gmail.com'
    config.userPassword = 'brayan123'
  } else if (env == 'qa') {
     config.userEmail = 'brayan555@gmail.com'
     config.userPassword = 'brayan12345'
  }

  var accesToken = karate.callSingle('classpath:helpers/CreateToken.feature',config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accesToken} )
  return config;
}