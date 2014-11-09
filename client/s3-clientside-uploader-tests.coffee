describe 'S3ClientSideUploader', ->
  examplePolicy =
    awsBaseUrl: 'https://acl16.s3-us-east-1.amazonaws.com',
    formFields:
      key: 'path/to/object',
      acl: 'private',
      'x-amz-algorithm': 'AWS4-HMAC-SHA256',
      'x-amz-credential': 'AKIAIOSFODNN7EXAMPLE\
        /20130806/us-east-1/s3/aws4_request',
      'x-amz-date': '20130806T000000Z',
      policy: 'eyJleHBpcmF0aW9',
      'x-amz-signature': '4eec6e9b6534d'

  uploader = new S3ClientsideUploader()

  describe 'uploadFormWithoutFile', ->
    it 'is correct', (test) ->
      expectedForm = """
<form id="abc123" class="s3-clientside-upload-form" \
action="https://acl16.s3-us-east-1.amazonaws.com" \
enctype="multipart/form-data" content="text/html; \
charset=UTF-8" method="post" http-equiv="Content-Type">
<input name="key" value="path/to/object">
<input name="acl" value="private">
<input name="x-amz-algorithm" value="AWS4-HMAC-SHA256">
<input name="x-amz-credential" \
value="AKIAIOSFODNN7EXAMPLE/20130806/us-east-1/s3/aws4_request">
<input name="x-amz-date" value="20130806T000000Z">
<input name="policy" value="eyJleHBpcmF0aW9">
<input name="x-amz-signature" value="4eec6e9b6534d">
<input name="file">
<input type="submit" value="Upload File to S3">
</form>
"""
      form = uploader.uploadFormWithoutFile('abc123', examplePolicy)
      test.equal form, expectedForm
