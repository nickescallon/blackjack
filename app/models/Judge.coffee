class window.Judge extends Backbone.Model

  initialize: ->
    @set
      scoreMessage: 'Hi there'
    @

  updateScore: (params) ->
    playerScore = params.playerScore
    dealerScore = params.dealerScore
    player = @playerScore[0]
    if (@playerScore).length > 1
      if (@playerScore)[1] < 22
        player = @playerScore[1]
    dealer = @dealerScore[0]
    if (@dealerScore).length > 1
      if (@dealerScore)[1] < 22
        dealer = @dealerScore[1]
    if (player > dealer) 
      @announce('Player Wins!')
    else if (play == dealer)
      @announce('Draw!')
    else
      @announce('Player Loses!')

  announce: (message) ->
    @.set('scoreMessage', message)




