# 3D bouncing ball

Ce projet est un programme amélioré basé sur un exemple de projet processing. Nous avons choisi d’ajouter à cet exemple une troisième dimension et la possibilité de visualiser le résultat grâce à une caméra manipulable. Nous avons pris comme base un exemple disponible sur le site web de Processing :  [*Non-orthogonal Collision with Multiple Ground Segments](https://processing.org/examples/reflection2.html).*

# To begin

---

## Requirement

Make sure you have Processing installed on your machine, we use the basic version of Processing and not the one intended for development in Python. You installed Processing from their site : [*Processing.org/download*](https://processing.org/download)

## Installation

Clone or download this repository to your machine.

```bash
git clone https://github.com/your-username/3D-bouncing-ball.git
```

Open the project in the Processing IDE.

# Program execution

Once the project is opened in Processing, click the “Run” button in the upper left corner of the Processing IDE, the program will compile this and run and launch a new window displaying the visual result.

---

# Configuration

---

You can modify and vary some parameters to act on the displayed result.

- gravity : PVector gravity represents the force applied to the ball continuously. It is possible to change its value to x, y and z.
    
    ```java
    gravity = new PVector(x, y, z);
    ```
    
- ground : The ground object represents the ground on which the ball will bounce, you can modify several parameters:
    - longueur : The length of the land
    - largeur : The width of the land
    - n : The desired number of surfaces forming the ground
    - peak : The variation of the values y of the land surfaces. The values will be between -peak and peak
    
    ```java
    ground = new Ground(longueur, largeur, n, peak);
    ```
    
- orb : The orb object corresponds to the bouncing ball of the program, you can set several variables :
    - (x, y, z) : Its position is initialized by coordinates given in x, y and z
    - r : the sphere radius
    - k : The variable k represents the elastic constant of the ball. Its value must be in 0 and 1
    
    ```java
    orb = new Orb(x, y, z,  r, gravity, k);
    ```
    
- Move: The keys used for move are editable in the `keyPressed()` and `keyReleased()`functions. Be careful, if you change a key in `keyPressed()`, please change to the same value in `keyReleased()`.

# Movement

---

## Keyboard keys

By default, the following keys have been assigned to move in space:

- Z : Move forward on the z-axis
- W : Move backward on the z-axis
- Q : Move backward on the x-axis
- D : Move forward on the x-axis
- Y : Rotate on the y-axis
- X : Rotate on the x-axis
- Space : Move forward on the y-axis
- Left Ctrl : Move backward on the y-axis

An axis is drawn to help you navigate in space

- X-axis: Purple
- Z-axis: Blue
- Y-axis: Green

The color of these axes can be changed in the `Axis` class
