#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <GL/glew.h>
#include <GL/freeglut.h>
#define WINDOW_TITLE_PREFIX "Chapter 1"

int
  CurrentWidth = 800,
  CurrentHeight = 600,
  WindowHandle = 0,
  FrameCount = 0;

void init(int, char*[]);
void init_window(int, char*[]);
void resize_function(int, int);
void render_function(void);
void timer_function(int);
void idle_function(void);

int main(int argc, char* argv[])
{
    init(argc, argv);

    glutMainLoop();

    exit(EXIT_SUCCESS);
}

void init(int argc, char* argv[])
{
    GLenum GlewInitResult;

    init_window(argc, argv);

    GlewInitResult = glewInit();

    if (GlewInitResult != GLEW_OK) {
    fprintf(
      stderr,
      "ERROR: %s\n",
      glewGetErrorString(GlewInitResult)
    );
    exit(EXIT_FAILURE);
    }

    fprintf(
    stdout,
    "INFO: OpenGL Version: %s\n",
    glGetString(GL_VERSION)
    );

    glClearColor(0.0f, 0.0f, 0.9f, 0.0f);
}

void init_window(int argc, char* argv[])
{
    glutInit(&argc, argv);

    glutInitContextVersion(4, 0);
    glutInitContextFlags(GLUT_FORWARD_COMPATIBLE);
    glutInitContextProfile(GLUT_CORE_PROFILE);

    glutSetOption(
    GLUT_ACTION_ON_WINDOW_CLOSE,
    GLUT_ACTION_GLUTMAINLOOP_RETURNS
    );

    glutInitWindowSize(CurrentWidth, CurrentHeight);

    glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);

    WindowHandle = glutCreateWindow(WINDOW_TITLE_PREFIX);

    if(WindowHandle < 1) {
    fprintf(
      stderr,
      "ERROR: Could not create a new rendering window.\n"
    );
    exit(EXIT_FAILURE);
    }

    glutReshapeFunc(resize_function);
    glutDisplayFunc(render_function);
    glutIdleFunc(idle_function);
    glutTimerFunc(0, timer_function, 0);
}

void resize_function(int Width, int Height)
{
    CurrentWidth = Width;
    CurrentHeight = Height;
    glViewport(0, 0, CurrentWidth, CurrentHeight);
}

void render_function(void)
{
    ++FrameCount;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glutSwapBuffers();
    glutPostRedisplay();
}

void idle_function(void) {
    glutPostRedisplay();
}

void timer_function(int value) {
    if (value != 0) {
        char *tmp_string = (char *) malloc(512 + strlen(WINDOW_TITLE_PREFIX));
        sprintf(tmp_string, "%s: %d Frames Per Second @ %d * %d", 
                WINDOW_TITLE_PREFIX, FrameCount * 4, CurrentWidth, CurrentHeight);

        glutSetWindowTitle(tmp_string);
        free(tmp_string);
    }

    FrameCount = 0;
    glutTimerFunc(250, timer_function, 1);
}


