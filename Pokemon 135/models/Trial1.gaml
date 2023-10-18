model PokemonGoMonitoring

global {
	int nb_player <- 5;
	int nb_pokemon <- 5;
	geometry shape <- rectangle(50#m, 50#m);
	
	init{
		create player number: nb_player;
		create pokemon number: nb_pokemon;
	}
	
	list<player> targets;
	list<pokemon> targets1;
	
}

species player skills:[moving]{
	float size <- 1.0;
	rgb color <- #violet;
	float range <- 5.0;
	
	reflex move{
		do wander amplitude: 30.0;	
	}
	
	reflex mysendmessage{
		targets <- player at_distance(range*2);
		targets1 <- pokemon at_distance(range*2);		
		
		if(length(targets) > 0){
			ask targets{
				write "I ("+name+"): " + "connected with" + targets;
			}
		}
		
		if(length(targets1) > 0){
			ask targets1{
				write "I ("+name+"): " + "connected with" + targets1;
			}
		}
	}
	
	aspect base{
		draw circle(size) color: color;
		draw circle(range) color: #blue wireframe: true;
		ask player at_distance(range*2){
			draw polyline([self.location,myself.location]) color: #red;
		}
		ask pokemon at_distance(range*2){
			draw polyline([self.location,myself.location]) color: #red;
		}
	}
}

species pokemon skills:[moving]{
    float size <- 0.5;
    rgb color <- #green;
	float range <- 5.0;
	int lifespan <- 180;
	
    reflex decreaseLifespan {
    	int remainingLS <- lifespan;
		loop destroy from: remainingLS to: 0{
			remainingLS <- remainingLS - 1;
			if(remainingLS < 0){
				
			}
		
		}
    }
    
    aspect base {
        draw circle(size) color: color;
        draw circle(range) color: #yellow wireframe: true;
		ask player at_distance(range*2){
			draw polyline([self.location,myself.location]) color: #red;
			}
    }
}


experiment PokemonGoSimulation type: gui{
	
	output{
		display map{
			species player aspect: base;
			species pokemon aspect: base;
		}
	}
	
}
