class Mergulhador
    attr_reader :x, :y, :alive
   
    def initialize(window)
        @window = window
        @icon = Gosu::Image.new(@window, 'mergulhador.png', true)
        @x = 630#- rand(200) #determina de onde vai aparecer inicialmente inimigos no eixo X
        @y = rand(120..350) #rand(@window.height - 500) #nivel superior para aparecer objetos
        @alive = true
    end
   
   #controla o aparecimento de objetos inimigos
    def update(player) 
        @x = @x - 1
        if @x == 0
            @x = 630
            @y =  rand(120..350) #rand(@window.height) #nivel inferior para aparecer objetos   
        end
        resgate(player)
    end
   
    def draw
        @icon.draw(@x, @y, 7)
    end
   
    def resgate(player)
        if Gosu::distance(player.y, player.x, @y, @x) < 20
            @alive = false
        end
    end
   
end