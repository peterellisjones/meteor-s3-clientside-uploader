form = Template.s3ClientSideUploadForm

class S3ClientsideUploader
  constructor: ->

  upload: (data, policy, callback = null, progress = null) ->
    if data !instanceof String
      data = JSON.stringify(data)

    id = Meteor.uuid()
    templateData = @_formData(id, policy)

    view = Blaze.renderWithData form, templateData, document.body
    Tracker.flush()
    elem = $("##{id}")
    fileInput = elem.find('input[name="file"]')
    fileInput.val(data)

    elem.on 'submit', (e) ->
      formData = new FormData(this)
      xhr = new XMLHttpRequest()

      if progress?
        xhr.upload.addEventListener 'progress', progress, false

      xhr.onreadystatechange = ->
        if xhr.readyState == 4
          Blaze.remove(view)
          callback(xhr) if callback?

      xhr.open('POST', templateData.awsBaseUrl, true)
      xhr.send(formData)
      false

    elem.submit()

  uploadFormWithoutFile: (id, policy) ->
    data = @_formData(id, policy)
    Blaze.toHTMLWithData(form, data)

  _formData: (id, policy) ->
    formFieldsArray = []
    for key, value of policy.formFields
      formFieldsArray.push
        key: key
        value: value

    data =
      awsBaseUrl: policy.awsBaseUrl
      formFields: formFieldsArray
      id: id
