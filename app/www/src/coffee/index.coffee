class window.App
  constructor: ->
    @initHTML()
    @registerEvents()

  initHTML: ->
    @domInitStatus = document.getElementById('deviceready')
    @domCamera = document.getElementById('camera')
    @domMotion= document.getElementById('motion')

  registerEvents: ->
    document.addEventListener 'deviceready', (=> @onDeviceReady()), false
    @domCamera.addEventListener 'click', (=> @openCamera()), false
    @domMotion.addEventListener 'click', (=> @openCamera()), false

  onDeviceReady: ->
    listeningElement = @domInitStatus.querySelector('.listening')
    receivedElement = @domInitStatus.querySelector('.received')

    listeningElement.setAttribute('style', 'display:none;')
    receivedElement.setAttribute('style', 'display:block;')

  openCamera: ->
    onSuccess = (imageData) ->
      image = document.getElementById('myImage')
      image.src = "data:image/jpeg;base64," + imageData

    onFail = (message) ->
      alert('Failed because: ' + message)

    navigator.camera.getPicture onSuccess, onFail,
      quality: 50,
      destinationType: Camera.DestinationType.DATA_URL

