#include "app.cpp"
#include "sakana.cpp"

int main() {
  App app = appInit();
  defer(appDeinit(&app));

  appRun(&app);

  return 0;
}
