local physics = require("physics")

physics.start()

--physics.setDrawMode("hybrid")
--physics.setScale( 60 )
physics.setGravity( 0, 0 )

local propriedadeBola = { density=1, radius=15 }


function criarNovoJogo()
	
	componentesBordas = display.newGroup()
	
	local mesa = display.newImage( "table1.png", true)
	componentesBordas:insert(mesa)
	mesa.x = 384
	mesa.y = 512
	
	local fillTop = display.newImage( "fill_bkg.png", true )
	componentesBordas:insert(fillTop)
	fillTop.x = 384; fillTop.y = -93
	
	local fillBot = display.newImage( "fill_bkg.png", true )
	componentesBordas:insert(fillBot)
	fillBot.rotation=180; fillBot.x = 384; fillBot.y = 1117


	local bumpers = { friction=0.5, bounce=0.5 }

	local physics_body = {}
	physics_body["bumperCima"] = {
		{
		    density = 10, friction = 10, bounce = 0.15, 
		    shape = {-194, 0, 194, 0, -208, -16, 208, -16}
		}
	}
	physics_body["bumperLado"] = {
		{
		    density = 10, friction = 10, bounce = 0.15, 
		    shape = {-16, 200, -16, -200, 3, -187, 3, 187}
		}
	}


	local bumper1 = display.newImage( "bumper_cima.png" )
	componentesBordas:insert(bumper1)
	physics.addBody( bumper1, "static", unpack(physics_body["bumperCima"]) )
	bumper1.x = 384; bumper1.y = 58
	bumper1.isVisible = false

	local bumper2 = display.newImage( "bumper_cima.png" )
	componentesBordas:insert(bumper2)
	physics.addBody( bumper2, "static", unpack(physics_body["bumperCima"]) )
	bumper2.x = 384; bumper2.y = 966; bumper2.rotation = 180
	bumper2.isVisible = false

	local bumper3 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper3)
	physics.addBody( bumper3, "static", unpack(physics_body["bumperLado"]) )
	bumper3.x = 157; bumper3.y = 279
	bumper3.isVisible = false

	local bumper4 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper4)
	physics.addBody( bumper4, "static", unpack(physics_body["bumperLado"]))
	bumper4.x = 611; bumper4.y = 279; bumper4.rotation = 180
	bumper4.isVisible = false

	local bumper5 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper5)
	physics.addBody( bumper5, "static", unpack(physics_body["bumperLado"]) )
	bumper5.x = 157; bumper5.y = 745
	bumper5.isVisible = false

	local bumper6 = display.newImage( "bumper_lados.png" )
	componentesBordas:insert(bumper6)
	physics.addBody( bumper6, "static", unpack(physics_body["bumperLado"]) )
	bumper6.x = 611; bumper6.y = 745; bumper6.rotation = 180
	bumper6.isVisible = false

	Pontuacao1 = 0
	textoPontuacao1 = display.newText(Pontuacao1, 0, 0, native.systemFontBold, 50 )
	textoPontuacao1:setTextColor( 255, 255, 255, 255 )
	textoPontuacao1.x = 550; textoPontuacao1.y = 1090;

	Pontuacao2 = 0
	textoPontuacao2 = display.newText(Pontuacao2, 0, 0, native.systemFontBold, 50 )
	textoPontuacao2:setTextColor( 255, 255, 255, 255 )
	textoPontuacao2.x = 550; textoPontuacao2.y = 1150;
	
  local displayTime = display.newText({
     text     = "Bola Vermelha",
     x        = 350,
     y        = 1090,
     fontSize = 50,
     align    = "left"
  })

    local displayTime = display.newText({
     text     = "Bola Azul",
     x        = 350,
     y        = 1150,
     fontSize = 50,
     align    = "left"
  })

  componentesBordas:insert( displayTime )

 	incluirBolas()
end

function incluirBolas()
	
	bolasJogo = display.newGroup()
	
	bolaBranca = display.newImage( "ball_white.png" )
	bolasJogo:insert(bolaBranca)
	physics.addBody( bolaBranca, propriedadeBola )
	bolaBranca.x = display.contentWidth/2;
	bolaBranca.y = 780
	bolaBranca.linearDamping = 0.3
	bolaBranca.angularDamping = 0.8
	bolaBranca.type = "bolaBranca"
	bolaBranca.collision = onCollision
	bolaBranca:addEventListener("collision", bolaBranca)
	bolaBranca:addEventListener( "postCollision", bolaBranca )

		--Creat Rotating target
	target = display.newImage( "target.png" )
	target.x = bolaBranca.x; target.y = bolaBranca.y; target.alpha = 0;
	

	local bolaVermelha = {}

		bolaVermelha1 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha1)
		physics.addBody(bolaVermelha1, propriedadeBola)
		bolaVermelha1.x = 303
		bolaVermelha1.y = 90
		bolaVermelha1.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha1.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha1:addEventListener( "postCollision", bolaVermelha1 )
		bolaVermelha1.type = "bolaVermelha"
		bolaVermelha1.collision = onCollision
		bolaVermelha1:addEventListener("collision", bolaBranca)
		bolaVermelha1:addEventListener( "postCollision", bolaBranca )
		bolaVermelha1:addEventListener( "touch", baterBola )


		bolaVermelha2 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha2)
		physics.addBody(bolaVermelha2, propriedadeBola)
		bolaVermelha2.x = 337
		bolaVermelha2.y = 90
		bolaVermelha2.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha2.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha2:addEventListener( "postCollision", bolaVermelha2 )
		bolaVermelha2.type = "bolaVermelha"


		bolaVermelha3 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha3)
		physics.addBody(bolaVermelha3, propriedadeBola)
		bolaVermelha3.x = 371 
		bolaVermelha3.y = 90
		bolaVermelha3.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha3.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha3:addEventListener( "postCollision", bolaVermelha3 )
		bolaVermelha3.type = "bolaVermelha"


		bolaVermelha4 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha4)
		physics.addBody(bolaVermelha4, propriedadeBola)
		bolaVermelha4.x = 405 
		bolaVermelha4.y = 90
		bolaVermelha4.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha4.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha4:addEventListener( "postCollision", bolaVermelha4 )
		bolaVermelha4.type = "bolaVermelha"


		bolaVermelha5 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha5)
		physics.addBody(bolaVermelha5, propriedadeBola)
		bolaVermelha5.x = 439 
		bolaVermelha5.y = 90
		bolaVermelha5.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha5.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha5:addEventListener( "postCollision", bolaVermelha5 )
		bolaVermelha5.type = "bolaVermelha"


		bolaVermelha6 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha6)
		physics.addBody(bolaVermelha6, propriedadeBola)
		bolaVermelha6.x = 318
		bolaVermelha6.y = 117
		bolaVermelha6.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha6.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha6:addEventListener( "postCollision", bolaVermelha6 )
		bolaVermelha6.type = "bolaVermelha"


		bolaVermelha7 = display.newImage("1.png")
		bolasJogo:insert(bolaVermelha7)
		physics.addBody(bolaVermelha7, propriedadeBola)
		bolaVermelha7.x = 352
		bolaVermelha7.y = 117
		bolaVermelha7.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaVermelha7.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaVermelha7:addEventListener( "postCollision", bolaVermelha7 )
		bolaVermelha7.type = "bolaVermelha"

local bolaOito = {}

		bolaOito8 = display.newImage("3.png")
		bolasJogo:insert(bolaOito8)
		physics.addBody(bolaOito8, propriedadeBola)
		bolaOito8.x = 386 
		bolaOito8.y = 117
		bolaOito8.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaOito8.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaOito8:addEventListener( "postCollision", bolaOito8 )
		bolaOito8.type = "bolaOito"


local bolaAzul = {}

		bolaAzul9 = display.newImage("2.png")
		bolasJogo:insert(bolaAzul9)
		physics.addBody(bolaAzul9, propriedadeBola)
		bolaAzul9.x = 420 
		bolaAzul9.y = 117
		bolaAzul9.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaAzul9.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaAzul9:addEventListener( "postCollision", bolaAzul9 )
		bolaAzul9.type = "bolaAzul"


		bolaAzul10 = display.newImage("2.png")
		bolasJogo:insert(bolaAzul10)
		physics.addBody(bolaAzul10, propriedadeBola)
		bolaAzul10.x = 337
		bolaAzul10.y = 144
		bolaAzul10.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaAzul10.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaAzul10:addEventListener( "postCollision", bolaAzul10 )
		bolaAzul10.type = "bolaAzul"


		bolaAzul11 = display.newImage("2.png")
		bolasJogo:insert(bolaAzul11)
		physics.addBody(bolaAzul11, propriedadeBola)
		bolaAzul11.x = 371 
		bolaAzul11.y = 144
		bolaAzul11.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaAzul11.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaAzul11:addEventListener( "postCollision", bolaAzul11 )
		bolaAzul11.type = "bolaAzul"


		bolaAzul12 = display.newImage("2.png")
		bolasJogo:insert(bolaAzul12)
		physics.addBody(bolaAzul12, propriedadeBola)
		bolaAzul12.x = 405 
		bolaAzul12.y = 144
		bolaAzul12.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaAzul12.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaAzul12:addEventListener( "postCollision", bolaAzul12 )
		bolaAzul12.type = "bolaAzul"


		bolaAzul13 = display.newImage("2.png")
		bolasJogo:insert(bolaAzul13)
		physics.addBody(bolaAzul13, propriedadeBola)
		bolaAzul13.x = 352 
		bolaAzul13.y = 171
		bolaAzul13.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaAzul13.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaAzul13:addEventListener( "postCollision", bolaAzul13 )
		bolaAzul13.type = "bolaAzul"


		bolaAzul14 = display.newImage("2.png")
		bolasJogo:insert(bolaAzul14)
		physics.addBody(bolaAzul14, propriedadeBola)
		bolaAzul14.x = 386 
		bolaAzul14.y = 171
		bolaAzul14.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaAzul14.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaAzul14:addEventListener( "postCollision", bolaAzul14 )
		bolaAzul14.type = "bolaAzul"


		bolaAzul15 = display.newImage("2.png")
		bolasJogo:insert(bolaAzul15)
		physics.addBody(bolaAzul15, propriedadeBola)
		bolaAzul15.x = 371 
		bolaAzul15.y = 198
		bolaAzul15.linearDamping = 0.3 -- atrito com a mesa para parar de se mover
		bolaAzul15.angularDamping = 0.8 -- atrito com a mesa para parar de rodar
		bolaAzul15:addEventListener( "postCollision", bolaAzul15 )
		bolaAzul15.type = "bolaAzul"


		bolaBranca:addEventListener( "touch", baterBola )
		criarBuracos()
	
end


function resetbolaBranca()
	bolaBranca.alpha = 0
	bolaBranca.x = 384
	bolaBranca.y = 780
	bolaBranca.xScale = 2.0; bolaBranca.yScale = 2.0
	local dropBall = transition.to( bolaBranca, { alpha=1.0, xScale=1.0, yScale=1.0, time=400 } )
end


function colisaoBuraco( self, event )

	local caiu = transition.to( event.other, { alpha=0, xScale=0.3, yScale=0.3, time=200 } )

	local object = event.other
	
	event.other:setLinearVelocity( 0, 0 )
		
	if event.other.type == "bolaBranca" then
		timer.performWithDelay( 50, resetbolaBranca )

	elseif event.other.type == "bolaVermelha" then
		event.other.active = true
		Pontuacao1 = Pontuacao1 + 1
		textoPontuacao1.text = Pontuacao1
		display.remove(event.other)

	elseif event.other.type == "bolaAzul" then
		event.other.active = false
		Pontuacao2 = Pontuacao2 + 1
		textoPontuacao2.text = Pontuacao2
		display.remove(event.other)
	
	elseif event.other.type == "bolaOito" then				
		display.remove(bolaAzul)
		display.remove(bolaVermelha)
		display.remove(bolaOito)
		display.remove(bolaBranca)
		criarNovoJogo()

	end

end


function criarBuracos()

	local buraco = {}

			local sensorRadius = 20
			buraco1 = display.newCircle( 126, 38, sensorRadius )
			componentesBordas:insert(buraco1)
			
			buraco1.isVisible = false
			physics.addBody( buraco1, { radius=sensorRadius, isSensor=true } )
			buraco1.id = "buraco"
			buraco1.bullet = false
			buraco1.collision = colisaoBuraco
			buraco1:addEventListener( "collision", buraco1 )

			buraco2 = display.newCircle( 641, 38, sensorRadius )
			componentesBordas:insert(buraco2)
			
			buraco2.isVisible = false
			physics.addBody( buraco2, { radius=sensorRadius, isSensor=true } )
			buraco2.id = "buraco"
			buraco2.bullet = false
			buraco2.collision = colisaoBuraco
			buraco2:addEventListener( "collision", buraco2 )


			buraco3 = display.newCircle( 126, 512, sensorRadius )
			componentesBordas:insert(buraco3)

			buraco3.isVisible = false
			physics.addBody( buraco3, { radius=sensorRadius, isSensor=true } )
			buraco3.id = "buraco"
			buraco3.bullet = false
			buraco3.collision = colisaoBuraco
			buraco3:addEventListener( "collision", buraco3 )

			buraco4 = display.newCircle( 641, 512, sensorRadius )
			componentesBordas:insert(buraco4)


			buraco4.isVisible = false
			physics.addBody( buraco4, { radius=sensorRadius, isSensor=true } )
			buraco4.id = "buraco"
			buraco4.bullet = false
			buraco4.collision = colisaoBuraco
			buraco4:addEventListener( "collision", buraco4 )

			buraco5 = display.newCircle( 126, 986, sensorRadius )
			componentesBordas:insert(buraco5)

			buraco5.isVisible = false
			physics.addBody( buraco5, { radius=sensorRadius, isSensor=true } )
			buraco5.id = "buraco"
			buraco5.bullet = false
			buraco5.collision = colisaoBuraco
			buraco5:addEventListener( "collision", buraco5 )

			buraco6 = display.newCircle( 641, 986, sensorRadius )
			componentesBordas:insert(buraco6)

			buraco6.isVisible = false
			physics.addBody( buraco6, { radius=sensorRadius, isSensor=true } )
			buraco6.id = "buraco"
			buraco6.bullet = false
			buraco6.collision = colisaoBuraco
			buraco6:addEventListener( "collision", buraco6 )

end

function baterBola( event )

	local t = event.target
	local phase = event.phase
	
		
	if "began" == phase then
		display.getCurrentStage():setFocus( t )
		t.isFocus = true
		
		-- Stop current cueball motion, if any
		t:setLinearVelocity( 0, 0 )
		t.angularVelocity = 0

		target.x = t.x
		target.y = t.y

		startRotation = function()
			target.rotation = target.rotation + 4
		end
		
		Runtime:addEventListener( "enterFrame", startRotation )
		
		local showTarget = transition.to( target, { alpha=0.4, xScale=0.4, yScale=0.4, time=200 } )
		myLine = nil

	elseif t.isFocus then
		
		if "moved" == phase then
			
			if ( myLine ) then
				myLine.parent:remove( myLine ) -- erase previous line, if any
			end
			myLine = display.newLine( t.x,t.y, event.x,event.y )
			myLine:setColor( 0, 25, 255, 25 )
			myLine.width = 8

		elseif "ended" == phase or "cancelled" == phase then
		
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			local stopRotation = function()
				Runtime:removeEventListener( "enterFrame", startRotation )
			end
			
			local hideTarget = transition.to( target, { alpha=0, xScale=1.0, yScale=1.0, time=200, onComplete=stopRotation } )
			
			if ( myLine ) then
				myLine.parent:remove( myLine )
			end
			
			t:applyForce( (t.x - event.x), (t.y - event.y), t.x, t.y )	
		end
	end

	return true


end

criarNovoJogo()