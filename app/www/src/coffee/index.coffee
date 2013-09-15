class window.App
  constructor: ->
    console.log('HHHHHHHHHHHHHHHHHHHHHHHH')
    @initHTML()
    @registerEvents()

  initHTML: ->
    @$motion = $('.motion')
    @$motionData = $('.motion-data')
    # @shakeMp3 = new Media 'res/sounds/shake.mp3', ->
      # console.log('play')
    @$pattern = $('#pattern')
    @$ip = $('#settings-ip')

  registerEvents: ->
    $('.devices img').click (e) =>
      @openCamera($(e.target))

    @$motion.click => @watchMotion()

  openCamera: ($target) ->
    onSuccess = (imageData) ->
      $target.attr 'src', "data:image/jpeg;base64,#{imageData}"

    onFail = (message) ->
      $target.attr 'src', "res/images/nopic.png"

    navigator.camera.getPicture onSuccess, onFail,
      quality: 50,
      destinationType: Camera.DestinationType.DATA_URL

  watchMotion: ->
    @$motionData.text("NOTHING")

    stop = =>
      if watchID
        navigator.accelerometer.clearWatch(watchID)
        watchID = null;

      @$motionData.text("SHAKE")
      # @shakeMp3.play()

    onSuccess = (acceleration) =>
      value = Math.sqrt(Math.pow(acceleration.x, 2) + Math.pow(acceleration.y, 2) + Math.pow(acceleration.z, 2))
      stop() if value > 43

    onError = =>

    options = { frequency: 100 }
    watchID = navigator.accelerometer.watchAcceleration(onSuccess, onError, options);

  changePattern: ->
    $.ajax
      url: "http://#{@$ip.val()}/3000/actions/pattern"
      contentType: "application/json",  
      dataType: 'jsonp',  
      data:
        pattern: @$pattern.val()
      crossDomain: true,  
