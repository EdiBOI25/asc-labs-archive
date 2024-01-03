#include <stdio.h>

int find_substring(char substring[], char otherstring[]);

int main() {
	int n = 4;
	char substring[100];
	char other_strings[20][100];

	printf("Enter substring: ");
	scanf("%s", substring);
	for (int i = 0; i < n; ++i) {
		// Read other strings
		printf("Enter string %d: ", i + 1);
		scanf("%s", other_strings[i]);
	}

	int found = 1;
	// Check if substring is in other strings
	for (int i = 0; i < n; ++i) {
		found = find_substring(substring, other_strings[i]);
		printf("Found = %d\n", found);
		if (found == 0) {
			printf("Substring not found in string %d.", i + 1);
			return 0;
		}
	}

	if (found == 1) {
		printf("Substring found in every other string");
	}

	return 0;
}