class Window < Gosu::Window

    def initialize
        super(640,480,false)
        self.caption = "Gama"
        @player = Player.new(self)
        @tubarao = 2.times.map {Tubarao.new(self)}
        @subinimigo = 3.times.map {SubInimigo.new(self)}
        @mergulhador = 1.times.map {Mergulhador.new(self)}
        @timer = Timer.new(self, @tubarao, @subinimigo, @mergulhador) #objeto para controlar o tempo de aparição dos inimigos
        @running = true
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @background = Gosu::Image.new(self, "fundo.png", true)

    end
    
    def update
        if @running
            if @player.hit_by? live_inimigos
                @running = false
            else
                run_game
            end
        end
        
        if not @running and button_down? Gosu::Button::KbR and @player.lives > 0
            @running = true
            @player.reset_position
        end
    end
    
    def run_game
        live_inimigos.each {|tubarao| tubarao.update(@player.laser)}
        live_inimigos.each {|subinimigo| subinimigo.update(@player.laser)}        
        live_inimigos.each {|mergulhador| mergulhador.update(@player.laser)} 
        @player.update
        @timer.update
        
    end
    
    def live_inimigos
        @tubarao.select {|tubarao| tubarao.alive == true} +
        @subinimigo.select {|subinimigo| subinimigo.alive == true} +
        @mergulhador.select {|mergulhador| mergulhador.alive == true}
    end
    
    def draw
        @background.draw(0,0,1)
        @player.draw
        live_inimigos.each {|subinimigo| subinimigo.draw}
        live_inimigos.each {|tubarao| tubarao.draw}
        live_inimigos.each {|mergulhador| mergulhador.draw}

        @font.draw("Lives: #{@player.lives}", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
    end
    
end