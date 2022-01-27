#include <unistd.h>

int main(int argc, char **argv)
{
	char * const args[] = {
		NULL
	};
	char * const environ[] = {
		"./fake_run",
		NULL
	};
	// argv[1]==full path to pkexec
	return execve(argv[1], args, environ);
}
