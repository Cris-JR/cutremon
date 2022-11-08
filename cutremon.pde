// Importando las librerías necesarias.
import processing.javafx.*;
import processing.sound.*;
import processing.video.*;

// Variables necesarias para el funcionamiento del programa.
int scene = 0;
boolean playVid1 = true;
boolean playVid2 = false;

// Variables que guardarán imágenes, vídeos y canciones.
Movie vidIntro;
Movie vidMenu;
PFont titleFont;
PFont generalFont;

void setup() {
    fullScreen(FX2D);
    surface.setTitle("CUTREMON - Versión: Rojo Pasión");
    frameRate(24);

    vidIntro = new Movie(this, "vidIntro.mkv");
    vidIntro.loop();

    vidMenu = new Movie(this, "vidMenu.mp4");
    vidMenu.noLoop();

    titleFont = createFont("titleFont.ttf", 128);
    generalFont = createFont("pokeFont.ttf", 128);
}

void draw() {
    if (scene == 0 && playVid1 == true) {
        drawStartingVideo();
    } else if (scene == 1 || scene == 0 && playVid1 == false) {
        vidIntro.stop();
        vidMenu.play();
        drawMainMenu();
    } else if (scene == 2) {
        vidMenu.stop();
        historia();
    }
}

void keyReleased() {
    if (keyCode == ENTER) {
        scene += 1;
    }
}

void movieEvent(Movie mov) {
    mov.read();
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

void historia() {
    fill(#ffffff);
    rect(0, 0, width, height);
}