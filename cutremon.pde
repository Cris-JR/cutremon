// Importando las librerías necesarias.
import processing.javafx.*;
import processing.video.*;
import ddf.minim.*;

// Variables necesarias para el funcionamiento del programa.
int scene = 0;
int typingCounter;
int robleTalks = 0;
boolean playVid1 = true;
boolean playVid2 = false;
boolean typingEffectFinished = false;
String anyText;
String playerName;
PShape textBox;

// Variables exclusivas de los botones. (Son muchas)
float buttonBoyX, buttonBoyY;
float buttonGirlX, buttonGirlY;
float buttonSize = width * 4;
boolean buttonBoyOver = false;
boolean buttonGirlOver = false;
boolean playerIsBoy = false;
boolean playerIsGirl = false;
color basicButtonColor;
color highlightedButtonColor;
color currentColorBoy;
color currentColorGirl;

float grassButtonX, grassButtonY;
float fireButtonX, fireButtonY;
float waterButtonX, waterButtonY;
boolean grassButtonOver = false;
boolean fireButtonOver = false;
boolean waterButtonOver = false;
boolean choseGrass = false;
boolean choseFire = false;
boolean choseWater = false;
PImage grass;
PImage fire;
PImage water;

// Variables que guardarán imágenes, vídeos y canciones.
Movie vidIntro;
Movie vidMenu;
PFont titleFont;
PFont generalFont;
Minim music;
AudioPlayer buttonASound;
AudioPlayer welcomeSong;
AudioPlayer pajarracoSound;
AudioPlayer boySong;
AudioPlayer girlSong;
AudioPlayer youDidIt;
AudioPlayer sadSong;
PImage robleBackground;
PImage profesorRoble;
PImage pajarraco;
PImage pajarracoBackground;
PImage chicoChicaBackground;
PImage boyBackground;
PImage girlBackground;
PImage fondoLaboratorio;
PImage inicialPlanta;
PImage inicialFuego;
PImage inicialAgua;
PImage bosqueOscuro;
PImage scaryGuy;

void setup() {
    fullScreen(FX2D);
    surface.setTitle("CUTREMON - Versión: Rojo Pasión");
    frameRate(24);

    // Cargamos los dos vídeos a utilizar.
    vidIntro = new Movie(this, "vidIntro.mkv");
    vidIntro.loop();

    vidMenu = new Movie(this, "vidMenu.mp4");
    vidMenu.noLoop();

    // Cargamos los archivos de las fuentes de texto.
    titleFont = createFont("titleFont.ttf", 128);
    generalFont = createFont("pokeFont.ttf", 128);

    // Cargamos los efectos de sonido y las canciones a emplear.
    music = new Minim(this);
    buttonASound = music.loadFile("buttonASound.mp3");
    welcomeSong = music.loadFile("welcomeSong.wav");
    pajarracoSound = music.loadFile("pajarracoSound.mp3");
    boySong = music.loadFile("boySong.mp3");
    girlSong = music.loadFile("girlSong.mp3");
    youDidIt = music.loadFile("youDidIt.mp3");
    sadSong = music.loadFile("sadSong.mp3");

    // Cargamos las imágenes necesarias.
    robleBackground = loadImage("robleBackground.jpg");
    profesorRoble = loadImage("profesorRoble.png");
    pajarraco = loadImage("pajarraco.png");
    pajarracoBackground = loadImage("pajarracoBackground.png");
    chicoChicaBackground = loadImage("fondoChicoChica.jpg");
    boyBackground = loadImage("boyBackground.jpg");
    boyBackground.filter(BLUR, 2.5);
    girlBackground = loadImage("girlBackground.jpg");
    girlBackground.filter(BLUR, 2.5);
    fondoLaboratorio = loadImage("fondoLaboratorio.jpg");
    inicialPlanta = loadImage("inicialPlanta.png");
    inicialFuego = loadImage("inicialFuego.png");
    inicialAgua = loadImage("inicialAgua.png");
    bosqueOscuro = loadImage("bosqueOscuro.jpg");
    scaryGuy = loadImage("scaryGuy.png");

    // Creamos la forma que emplearemos para los cuadros de texto.
    textBox = createShape(RECT, 0, 0, width / 1.8, height / 3.2);
    textBox.setFill(#ffffff);
    textBox.setStrokeWeight(5);
    textBox.setStroke(#f05c00);

    // Elegimos los colores que tendrán los botones según coloquemos el cursor por encima de ellos o no.
    basicButtonColor = color(#38ffc9);
    highlightedButtonColor = color(#32d3a7);
    currentColorBoy = basicButtonColor;
    currentColorGirl = basicButtonColor;

    // Cargamos los archivos para los botones de cada elemento.
    grass = loadImage("grass.png");
    fire = loadImage("fire.png");
    water = loadImage("water.png");
}

void draw() {
    // Mecanismo que gestiona el cambio de escenas para narrar la historia.
    if (scene == 0 && playVid1 == true) {
        drawStartingVideo();
    } else if (scene == 1 || scene == 0 && playVid1 == false) {
        vidIntro.stop();
        vidMenu.play();
        drawMainMenu();
    } else if (scene == 2) {
        vidMenu.stop();
        drawRobleTalks1();
    } else if (scene == 3) {
        drawRobleTalks2();
    } else if (scene == 4) {
        drawRobleTalks3();
    } else if (scene == 5) {
        drawChicoChica();
    } else if (scene == 6) {
        drawChico();
    } else if (scene == 7) {
        drawChica();
    } else if (scene == 8) {
        drawRobleTalksMore();
    } else if (scene == 9) {
        drawElementScreen();
    } else if (scene == 10) {
        drawElementChosen();
    } else if (scene == 11) {
        drawEscenaFinal();
    } else if (scene == 12) {
        exit();
    }
}

// Funciones creadas para el correcto funcionamiento del programa.
void keyReleased() {
    if (keyCode == ENTER && scene != 6) {
        scene += 1;
        buttonASound.play();
    } else if (keyCode == ENTER && scene == 6) {
        scene = 8;
        buttonASound.play();
    }

    if (key == ' ' && scene >= 2) {
        robleTalks += 1;
        buttonASound.play();
    }
}

void movieEvent(Movie mov) {
    mov.read();
}

// Elementos necesarios para crear los distintos botones.
void mousePressed() {
    // Botones para elegir si eres chico o chica.
    if (buttonBoyOver) {
        playerIsBoy = true;
        scene = 6;
    } else if (buttonGirlOver) {
        playerIsGirl = true;
        scene = 7;
    } else playerIsBoy = playerIsGirl = false;

    // Botones para elegir el elemento de tu Cutré-Mon.
    if (grassButtonOver) {
        choseGrass = true;
        buttonASound.play();
        scene = 10;
    } else if (fireButtonOver) {
        choseFire = true;
        buttonASound.play();
        scene = 10;
    } else if (waterButtonOver) {
        choseWater = true;
        buttonASound.play();
        scene = 10;
    }
}

boolean overButton(float x, float y, float width, float height) {
    if (mouseX >= x && mouseX <= x + width &&
        mouseY >= y && mouseY <= y + height) {
            return true;
        } else return false;
}

void updateButton(int x, int y) {
    /*  Comprueba si las coordenadas que recibe se encuentran encima de algún botón,
        y cambia el color de este en función de si está siendo seleccionado.
    */

    if (overButton(buttonBoyX, buttonBoyY, buttonSize, buttonSize)) {
        buttonBoyOver = true;
        currentColorBoy = highlightedButtonColor;
    } else if (overButton(buttonGirlX, buttonGirlY, buttonSize, buttonSize)) {
        buttonGirlOver = true;
        currentColorGirl = highlightedButtonColor;
    } else {
        buttonBoyOver = buttonGirlOver = false;
        currentColorBoy = currentColorGirl = basicButtonColor;
    }

    if (overButton(grassButtonX, grassButtonY, buttonSize, buttonSize)) {
        grassButtonOver = true;
        grass.filter(POSTERIZE, 2);
    } else if (overButton(fireButtonX, fireButtonY, buttonSize, buttonSize)) {
        fireButtonOver = true;
        fire.filter(POSTERIZE, 2);
    } else if (overButton(waterButtonX, waterButtonY, buttonSize, buttonSize)) {
        waterButtonOver = true;
        water.filter(POSTERIZE, 2);
    } 
}

// Efecto especial para que parezca que el texto está siendo escrito letra por letra.
void typingEffect(String anyText) {
    // Reinicia el contador si un bloque de texto se ha terminado de escribir.
    if (typingEffectFinished == true) {
        typingCounter = 0;
        typingEffectFinished = false;
    }

    if (typingCounter < anyText.length() && typingEffectFinished == false) {
        typingCounter++;
    }
    text(anyText.substring(0, typingCounter), width / 11, height / 6, width, height);
}

// Escenas principales entre las que cambiaremos a lo largo del videojuego.
void drawStartingVideo() {
    vidIntro.play();
    image(vidIntro, 0, 0, width, height);

    float currentFrame = vidIntro.time();
    float lastFrame = vidIntro.duration();

    if (currentFrame >= lastFrame) {
        vidIntro.stop();
        playVid1 = false;
        scene = 1;
    }
}

void drawMainMenu() {
    image(vidMenu, 0, 0, width, height);

    if (vidMenu.time() >= vidMenu.duration()) {
        vidMenu.stop();
        playVid2 = false;
    }

    // Borde alrededor del título de color negro.
    fill(#000000);
    textFont(titleFont, width / 8);
    for (int x = -1; x < 2; x++) {
        for (int y = -1; y < 2; y++) {
            text("CutréMon", width / 5 + x, height / 3 + y);
        }  
        text("CutréMon", width / 5 + x, height / 3);
        text("CutréMon", width / 5, height / 3 + x);
    }
    fill(#ffffff);
    text("CutréMon", width / 5.2, height / 3);
    
    fill(random(0, 256));
    textFont(generalFont, width / 24);
    text("Pulsa ENTER para comenzar", width / 3.6, height - width / 8);
}

void drawRobleTalks1() {
    welcomeSong.play();
    image(robleBackground, 0, 0, width, height);

    image(profesorRoble, width / 1.8, height / 4, width / 3, width / 1.8);

    fill(random(0, 256));
    textFont(generalFont, width / 32);
    text("Pulsa ESPACIO para seguir leyendo", width / 15, height / 1.1);

    // Comienza a narrar la "historia".
    shape(textBox, width / 14, height / 7);
    fill(#000000);
    if (robleTalks == 0) {
        typingEffect("  ¡Bienvenido al mundo Cutré-Mon!  ");
    } else if (robleTalks == 1) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 2) {
        typingEffect("  Mi nombre es Roble.  \n  Aunque soy más conocido como...  \n  ¡El Cutre-Profe!  ");
    } else if (robleTalks == 3) {
        typingEffectFinished = true;
        scene += 1;
        robleTalks += 1;
    }
}

void drawRobleTalks2() {
    image(pajarracoBackground, 0, 0, width, height);
    
    image(pajarraco, width / 1.5, height / 1.6, width / 5, width / 5);

    fill(random(0, 256));
    textFont(generalFont, width / 32);
    text("Pulsa ESPACIO para seguir leyendo", width / 15, height / 1.1);

    shape(textBox, width / 14, height / 7);
    fill(#000000);
    if (robleTalks == 4) {
        typingEffect("  Este maravilloso mundo que estás viendo... \n  está habitado por unas criaturas llamadas:  ");
    } else if (robleTalks == 5) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 6) {
        typingEffect("  ¡Cutré-Mon, como este PAJARRACO!  ");
        pajarracoSound.play();
    } else if (robleTalks == 7) {
        typingEffectFinished = true;
        scene += 1;
        robleTalks += 1;
    }
}

void drawRobleTalks3() {
    image(robleBackground, 0, 0, width, height);

    image(profesorRoble, width / 1.8, height / 4, width / 3, width / 1.8);

    fill(random(0, 256));
    textFont(generalFont, width / 32);
    text("Pulsa ESPACIO para seguir leyendo", width / 15, height / 1.1);

    shape(textBox, width / 14, height / 7);
    fill(#000000);
    if (robleTalks == 8) {
        typingEffect("  Algunas personas usan a los Cutré-Mon  \n  como meras mascotas chulis...  ");
    } else if (robleTalks == 9) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 10) {
        typingEffect("  Otras los usaban para combatir...  \n  aunque eso ahora está... \n  ¡PROHIBIDÍSIMO!  ");
        welcomeSong.pause();
    } else if (robleTalks == 11) {
        welcomeSong.play();
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 12) {
        typingEffect("  Bueno, pasemos al lío...  ");
    } else if (robleTalks == 13) {
        scene += 1;
        robleTalks += 1;
    }
}

void drawChicoChica () {
    image(chicoChicaBackground, 0, 0, width, height);

    fill(#ffffff);
    rect(width / 4, height / 6.4, width / 2, width / 18);
    fill(#000000);
    textFont(generalFont, width / 18);
    text("¿Eres chico o chica?", width / 3.6, height / 4);

    updateButton(mouseX, mouseY);

    buttonBoyX = width / 4.5;
    buttonBoyY = height / 3;
    fill(currentColorBoy);
    rect(buttonBoyX, buttonBoyY, buttonSize, buttonSize);
    fill(#000000);
    text("Chico", width / 3.8, height / 1.5);

    buttonGirlX = width / 1.8;
    buttonGirlY = height / 3;
    fill(currentColorGirl);
    rect(buttonGirlX, buttonGirlY, buttonSize, buttonSize);
    fill(#000000);
    text("Chica", width / 1.6, height / 1.5);

}

void drawChico() {
    image(boyBackground, 0, 0, width, height);
    
    textFont(titleFont, width / 16);
    fill(#000000);
    text("Has elegido a Ash Ketchup!", width / 7, height / 1.8);

    fill(random(0, 256));
    textFont(generalFont, width / 24);
    text("Pulsa ENTER para continuar", width / 3.6, height - width / 8);
}

void drawChica() {
    image(girlBackground, 0, 0, width, height);

    textFont(titleFont, width / 16);
    fill(#000000);
    text("Has elegido a Serena!", width / 6.4, height / 1.8);

    fill(random(0, 256));
    textFont(generalFont, width / 24);
    text("Pulsa ENTER para continuar", width / 3.6, height - width / 8);
}

void drawRobleTalksMore() {
    welcomeSong.pause();
    image(robleBackground, 0, 0, width, height);

    image(profesorRoble, width / 1.8, height / 4, width / 3, width / 1.8);

    fill(random(0, 256));
    textFont(generalFont, width / 32);
    text("Pulsa ESPACIO para seguir leyendo", width / 15, height / 1.1);

    /*  Si el jugador es chico, le asigna un nombre y ejecuta una canción 
        distinta a la que sonará si la jugadora es chica.
    */

    if (playerIsBoy) {
        playerName = "ASH";
        boySong.play();
    } else if (playerIsGirl) {
        playerName = "SERENA";
        girlSong.play();
    }

    shape(textBox, width / 14, height / 7);
    fill(#000000);
    if (robleTalks == 14) {
        typingEffect("  Encantado de conocerte, " + playerName + "!  ");
    } else if (robleTalks == 15) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 16) {
        typingEffect("  Tu nombre me suena de algo...  \n  No serás...  \n  No, no puede ser.");
    } else if (robleTalks == 17) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 18) {
        typingEffect("  Bueno, creo que va siendo hora  \n  de que conozcas tu futuro...  ");
    } else if (robleTalks == 19) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 20) {
        typingEffect("  Aunque, lo primero es lo primero,  \n  por favor, elige el elemento  \n  que más te represente...  ");
    } else if (robleTalks == 21) {
        typingEffectFinished = true;
        robleTalks += 1;
        scene += 1;
    }
}

void drawElementScreen() {
    image(fondoLaboratorio, 0, 0, width, height);

    updateButton(mouseX, mouseY);

    grassButtonX = width / 8;
    grassButtonY = height / 3;
    image(grass, grassButtonX, grassButtonY, buttonSize, buttonSize);
    fill(#000000);
    text("Planta", width / 8, height / 1.5);

    fireButtonX = width / 2.7;
    fireButtonY = height / 3;
    image(fire, fireButtonX, fireButtonY, buttonSize, buttonSize);
    fill(#000000);
    text("Fuego", width / 2.7, height / 1.5);

    waterButtonX = width / 1.6;
    waterButtonY = height / 3;
    image(water, waterButtonX, waterButtonY, buttonSize, buttonSize);
    fill(#000000);
    text("Agua", width / 1.6, height / 1.5);
}

void drawElementChosen() {
    image(fondoLaboratorio, 0, 0, width, height);
    youDidIt.play();

    // Muestra el Cutré-Mon inicial que el usuario ha escogido en función del elemento.
    textFont(titleFont, width / 16);
    if (choseGrass) {
        image(inicialPlanta, width / 3, height / 2.7, width / 3, width / 3);
        fill(#000000);
        text("Has elegido a Hierba-Mala!", width / 6, height / 6);
    } else if (choseFire) {
        image(inicialFuego, width / 3, height / 2.7, width / 3, width / 3);
        fill(#000000);
        text("Has elegido a Julián!", width / 6, height / 6);
    } else if (choseWater) {
        image(inicialAgua, width / 3, height / 2.7, width / 3, width / 3);
        fill(#000000);
        text("Has elegido a Dragon-Cin!", width / 6, height / 6);
    }

    fill(random(0, 256));
    textFont(generalFont, width / 24);
    text("Pulsa ENTER para continuar", width / 4.4, height - width / 6);
}

void drawEscenaFinal() {
    image(bosqueOscuro, 0, 0, width, height);
    
    if (playerIsBoy) {
        boySong.pause();
    } else if (playerIsGirl) {
        girlSong.pause();
    }

    sadSong.play();

    fill(random(0, 256));
    textFont(generalFont, width / 32);
    text("Pulsa ESPACIO para seguir leyendo", width / 15, height / 1.1);

    shape(textBox, width / 14, height / 7);
    fill(#000000);
    image(scaryGuy, width / 1.8, height / 4, width / 2.5, width / 2.5);
    if (robleTalks == 22) {
        typingEffect("  " + playerName + "! \n  Tú qué haces aquí?  ");
    } else if (robleTalks == 22) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 23) {
        typingEffect("  Esto se ha terminado...  \n  Vuelve a tu casa.  ");
    } else if (robleTalks == 24) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 25) {
        typingEffect("  He dicho...  \n  Que se ha terminado.  ");
    } else if (robleTalks == 26) {
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 27) {
        typingEffect("  Está bien...  \n  Lo haré yo mismo.  ");
    } else if (robleTalks == 28) {
        bosqueOscuro.filter(GRAY);
        typingEffectFinished = true;
        robleTalks += 1;
    } else if (robleTalks == 29) {
        typingEffect("  ADIÓS  ");
    } else if (robleTalks == 30) {
        scene = 12;
    }
}