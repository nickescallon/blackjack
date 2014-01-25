class window.AppView extends Backbone.View

  className: 'container'

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="deal-button disable-button">Deal</button>
    <div class="judge-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .deal-button": -> @model.deal()

  initialize: ->
    @model.on('newHand', @redeal, @)
    @redeal()

  redeal: ->
    $('.deal-button').addClass('disable-button');
    @model.get('playerHand').on('bust',
      ()=>
        @model.get('dealerHand').reveal()
        @model.get('judge').updateScore(
          playerScore: @model.get('playerHand').getScores()
          dealerScore: @model.get('dealerHand').getScores()
          )
        # re-enable the button
        $('.deal-button').removeClass('disable-button')
      )
    @model.get('playerHand').on('stand',
      ()=>
        @model.get('dealerHand').reveal()
        @model.get('dealerHand').play()
      )
    @model.get('dealerHand').on('bust done',
      ()=> 
        @model.get('judge').updateScore(
          playerScore: @model.get('playerHand').getScores()
          dealerScore: @model.get('dealerHand').getScores()
        )
        # re-enable the button
        $('.deal-button').removeClass('disable-button')
      )
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.judge-container').html new JudgeView(model: @model.get 'judge').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
