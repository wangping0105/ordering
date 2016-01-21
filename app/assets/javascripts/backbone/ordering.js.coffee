#= require_self

window.Ordering =
  Models: {}
  Collections: {}
  Routers: {}
  View: {}
  Utils: {}
  breadcrumbs: {}
  init_spin: =>
    target = $("#")
  after_initialize: =>
    window.container_spinner.stop()
    resize_window_height()
    return true