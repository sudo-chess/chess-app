class GamesController < ApplicationController

def index
     @pending_partner = Game.pending
    end
    
   def pending
     @games = Game.pending
     # render action: :index
   end
 
   def playing
     @games = Game.playing
     # render action: :index
   end
 
   def complete
     @games = Game.complete
     # render action: :index
   end
end