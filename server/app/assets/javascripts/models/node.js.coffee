Busykoala.Node = Ember.Object.extend

Busykoala.Node.reopenClass
  nodeType: {
    1: 'lamp'
    2: 'switcher'
    3: 'fan'
    4: 'temperature'
    5: 'scrollbar'
    6: 'beeper'
    7: 'pattern'
  }
