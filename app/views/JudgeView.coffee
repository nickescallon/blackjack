class window.JudgeView extends Backbone.View

  className: 'judge'

  template: _.template '<div class="announce-outcome"><%= scoreMessage %></div>'

  initialize: ->
    @model.on 'change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    console.log(@model)
    @$el.html(@template(@model.attributes))