class window.Judge extends Backbone.Model

  initialize: ->
    @set
      scoreMessage: 'Play!'
      emoticon: 'styles/wondering.jpeg'
    @

  updateScore: (params) ->
    playerScore = params.playerScore
    dealerScore = params.dealerScore
    if (playerScore[0] > 21)
      @announce('Player Busted')
      @.set('emoticon', 'styles/sad2.jpeg')
    else if (dealerScore[0] > 21)
      @announce('Dealer Busted')
      @.set('emoticon', 'styles/happy.jpeg')
    else
      player = playerScore[0]
      if (playerScore).length > 1
        if (playerScore)[1] < 22
          player = playerScore[1]
      dealer = dealerScore[0]
      if (dealerScore).length > 1
        if (dealerScore)[1] < 22
          dealer = dealerScore[1]
      if (player > dealer) 
        @announce('Player Wins!')
        @.set('emoticon', 'styles/happy2.jpeg')
      else if (player == dealer)
        @announce('Draw!')
        @.set('emoticon', 'styles/upset.jpeg')
      else
        @announce('Player Loses!')
        @.set('emoticon', 'styles/sad.jpeg')

  announce: (message) ->
    @.set('scoreMessage', message)




