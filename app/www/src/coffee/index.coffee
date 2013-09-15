class window.App
  constructor: ->
    @initHTML()
    @registerEvents()

  initHTML: ->
    @$motion = $('.motion')
    @shakeMp3 = new Media 'res/sounds/shake.mp3', ->
      console.log('ready to play')
    @$pattern = $('#pattern')
    @$ip = $('#settings-ip')
    @$leds = $('#leds')

  registerEvents: ->
    @$leds.click => @openCamera()
    @$pattern.change => @watchMotion()

  openCamera: ->
    onSuccess = (imageData) =>
      @$leds.attr 'src', "data:image/jpeg;base64,#{imageData}"

    onFail = (message) =>
      @$leds.attr 'src', "res/images/nopic.png"

    navigator.camera.getPicture onSuccess, onFail,
      quality: 50,
      destinationType: Camera.DestinationType.DATA_URL

  watchMotion: ->
    stop = =>
      if watchID
        navigator.accelerometer.clearWatch(watchID)
        watchID = null;

      @changePattern()
      @shakeMp3.play()

    onSuccess = (acceleration) =>
      value = Math.sqrt(Math.pow(acceleration.x, 2) + Math.pow(acceleration.y, 2) + Math.pow(acceleration.z, 2))
      stop() if value > 43

    onError = =>

    options = { frequency: 100 }
    watchID = navigator.accelerometer.watchAcceleration(onSuccess, onError, options);

  changePattern: ->
    $.ajax
      url: "http://#{@$ip.val()}:3000/actions/pattern"
      data:
        pattern: @$pattern.val()
      dataType: 'jsonp',
      crossDomain: true,
      success: (data) =>
        @shakeMp3.play()
