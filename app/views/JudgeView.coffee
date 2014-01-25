class window.JudgeView extends Backbone.View

  className: 'judge'

  template: _.template '<img src=<%= emoticon %>><%= scoreMessage %>'

  initialize: ->
    @model.on 'change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    #@$el.attr('src', @.model.get 'emoticon')
    console.log(@model)
    @$el.html(@template(@model.attributes))