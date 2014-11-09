Package.describe({
  name: 'peterellisjones:s3-clientside-uploader',
  summary: 'Uploads things to S3 on the client using signed S3 policies created on the server',
  version: '1.0.0',
  git: 'https://github.com/peterellisjones/meteor-s3-clientside-uploader.git'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use('coffeescript');
  api.use('templating');
  api.use('blaze');
  api.imply('peterellisjones:s3-policy-generator@1.0.0');
  api.addFiles('client/s3-clientside-upload-form.html', 'client');
  api.addFiles('client/s3-clientside-uploader.coffee', 'client');
  api.export('S3ClientsideUploader');
});

Package.onTest(function(api) {
  api.use('coffeescript');
  api.use('peterellisjones:describe');
  api.use('peterellisjones:s3-clientside-uploader');
  api.addFiles('client/s3-clientside-uploader-tests.coffee', 'client');
});
