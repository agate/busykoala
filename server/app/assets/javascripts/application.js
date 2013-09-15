//= require jquery
//= requrie jquery_ujs
//= require bootstrap-3.0.0/js/bootstrap
//= require handlebars
//= require ember
//= require_self
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./routes
//= require ./router

window.Busykoala = Ember.Application.create({
  LOG_TRANSITIONS: true,
  LOG_ACTIVE_GENERATION: true,
  LOG_VIEW_LOOKUPS: true
});
