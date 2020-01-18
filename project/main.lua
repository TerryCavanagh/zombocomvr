if type(jit) == 'table' and lovr.headset.getDriver() ~= "oculusmobile" then
	desktopmode = true
else
	desktopmode = false
end

function lovr.load()
  logotexture = lovr.graphics.newTexture("graphics/zombo.png");
  logo = lovr.graphics.newMaterial(logotexture);

  colourtexture = lovr.graphics.newTexture("graphics/colours.png");
  colours = lovr.graphics.newMaterial(colourtexture);

  controllerstex = lovr.graphics.newTexture("graphics/gradienttop.png");
  controllersmat = lovr.graphics.newMaterial(controllerstex);

  background = lovr.graphics.newTexture({
    left = "graphics/gradientside.png",
    right = "graphics/gradientside.png",
    top = "graphics/gradienttop.png",
    bottom = "graphics/gradientbottom.png",
    front = "graphics/gradientside.png",
    back = "graphics/gradientside.png"
  });

  ambience = lovr.audio.newSource("audio/zombocom.ogg", "stream");
  ambience:setLooping(true);
  ambience:play();
end

coloursangle_real = 0;
coloursangle = 0;
function lovr.update(dt)
  coloursangle_real = coloursangle_real + dt;
  --Snap to 1/6th of a rad
  coloursangle = -math.floor((coloursangle_real * 15) * (math.pi / 6));
end

function lovr.draw()
  lovr.graphics.skybox(background);

  lovr.graphics.plane(logo, 0, 2.1, -0.6, 1.937 / 2, .41 / 2)

  lovr.graphics.plane(colours, 0, 1.7, -0.6, 0.4, 0.4, coloursangle, 0, 0, 1);

  if desktopmode ~= true then
    drawcontrollers()
  end
end


function drawcontrollers()
  for i, hand in ipairs(lovr.headset.getHands()) do
    local x, y, z, angle, ax, ay, az = lovr.headset.getPose(hand)
    lovr.graphics.cube(controllersmat, x, y, z, .06, angle, ax, ay, az)
  end
end
