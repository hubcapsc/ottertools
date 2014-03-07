#include <stdio.h>
#include <convenienceLib1/cl1.h>
#include <convenienceLib2/cl2.h>
#ifdef __CL3
#include <convenienceLib3/cl3.h>
#endif
#include "app.h"

int main(int argc, char *argv[]) {
  printf("appDotHVariable:%s:\n",appDotHVariable);
  cl1print(cl1Var);
  cl2print(cl2Var);
#ifdef __CL3
  cl3print(cl3Var);
#endif
}
